using EasyNetQ;
using IronVault.Model.Models;
using MailingService;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

public class ConsumeRabbitMQHostedService : BackgroundService
{
    private readonly ILogger _logger;
    private IConnection _connection;
    private IModel _channel;
    private readonly IEmailSender _emailSender;

    private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
    private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
    private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
    private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

    public ConsumeRabbitMQHostedService(ILoggerFactory loggerFactory, IEmailSender emailSender)
    {
        _logger = loggerFactory.CreateLogger<ConsumeRabbitMQHostedService>();
        _emailSender = emailSender;
        InitRabbitMQ();
    }

    private void InitRabbitMQ()
    {
        var factory = new ConnectionFactory
        {
            HostName = _host,
            UserName = _username,
            Password = _password
        };


        _connection = factory.CreateConnection();


        _channel = _connection.CreateModel();


        _channel.QueueDeclare("Reservation_added", false, false, false, null);
        
        _channel.BasicQos(0, 1, false);

        _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
     
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using (var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}"))
                {
                    bus.PubSub.Subscribe<Notifikacija>("New_Reservations", HandleMessage);
                    Console.WriteLine("Čekanje na mailove");
                    await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken);
                }

           
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                
                break;
            }
            catch (Exception ex)
            {
              
                Console.WriteLine($"Error in RabbitMQ listener: {ex.Message}");
            }
        }
    }

    private async Task HandleMessage(Notifikacija mail)
    {
        
        await _emailSender.SendEmailAsync(mail.Email, "Dobili ste zakazani termin", $"Termin je zakazao korisnik {mail.Korisnik} na datum {mail.DatumTermina.ToShortDateString()} u {mail.DatumTermina.ToString("HH:mm")}, korisnik je zakazao {mail.ZakazanoSati} sati.");

    }

    private void OnConsumerConsumerCancelled(object sender, ConsumerEventArgs e) { }
    private void OnConsumerUnregistered(object sender, ConsumerEventArgs e) { }
    private void OnConsumerRegistered(object sender, ConsumerEventArgs e) { }
    private void OnConsumerShutdown(object sender, ShutdownEventArgs e) { }
    private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e) { }

    public override void Dispose()
    {
        _channel.Close();
        _connection.Close();
        base.Dispose();
    }
}