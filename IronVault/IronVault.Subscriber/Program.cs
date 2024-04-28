using EasyNetQ;
using IronVault.Model.Messages;



var bus = RabbitHutch.CreateBus("host=localhost:5673");
await bus.PubSub.SubscribeAsync<SuplementActivated>("console_printer", msg =>
{
    Console.WriteLine($"Product activated: {msg.Suplement.Naziv}");
});

await bus.PubSub.SubscribeAsync<SuplementActivated>("console_printer", msg =>
{
    Console.WriteLine($"Product activated 2: {msg.Suplement.Naziv}");
});


await bus.PubSub.SubscribeAsync<SuplementActivated>("mail_sender", msg =>
{
    Console.WriteLine($"Sending email for: {msg.Suplement.Naziv}");
    //todo send email
});




Console.WriteLine("Listening for messages, press <return> key to close!");
Console.ReadLine();
