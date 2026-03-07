using IronVault.API;
using IronVault.API.Filters;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.Methods;
using IronVault.Services.SuplementStateMachine;
using Mapster;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
DotNetEnv.Env.TraversePath().Load();
var connectionString = BuildPostgresConnectionString();

static string BuildPostgresConnectionString()
{
    var mode = Environment.GetEnvironmentVariable("DB_MODE")?.Trim().ToLowerInvariant();
    string? host, port, name, user, password;
    if (mode == "supabase")
    {
        host = Environment.GetEnvironmentVariable("DB_SUPABASE_HOST");
        port = Environment.GetEnvironmentVariable("DB_SUPABASE_PORT");
        name = Environment.GetEnvironmentVariable("DB_SUPABASE_NAME");
        user = Environment.GetEnvironmentVariable("DB_SUPABASE_USER");
        password = Environment.GetEnvironmentVariable("DB_SUPABASE_PASSWORD");
    }
    else
    {
        host = Environment.GetEnvironmentVariable("DB_HOST");
        port = Environment.GetEnvironmentVariable("DB_PORT");
        name = Environment.GetEnvironmentVariable("DB_NAME");
        user = Environment.GetEnvironmentVariable("DB_USER");
        password = Environment.GetEnvironmentVariable("DB_PASSWORD");
    }
    port = string.IsNullOrWhiteSpace(port) ? "5432" : port;
    if (string.IsNullOrWhiteSpace(host) || string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(user) || string.IsNullOrWhiteSpace(password))
        return "Host=localhost;Port=5432;Database=IronVault;Username=postgres;Password=postgres";
    var cs = $"Host={host};Port={port};Database={name};Username={user};Password={password}";
    if (mode == "supabase") cs += ";SSL Mode=Require";
    return cs;
}

var builder = WebApplication.CreateBuilder(args);

var port = Environment.GetEnvironmentVariable("PORT") ?? "5130";
builder.WebHost.UseUrls($"http://0.0.0.0:{port}");

// Add services to the container.
builder.Services.AddTransient<ISuplementService, SuplementService>();
//builder.Services.AddTransient<ISuplementiService, DummySuplementiService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IDobavljacService, DobavljacService>();
builder.Services.AddTransient<IKategorijaService, KategorijaService>();
builder.Services.AddTransient<IGradService, GradService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();
builder.Services.AddTransient<IFaqService, FaqService>();
builder.Services.AddTransient<IClanarinaService, ClanarinaService>();
builder.Services.AddTransient<ISeminarService, SeminarService>();
builder.Services.AddTransient<ITrenerService, TrenerService>();
builder.Services.AddTransient<INutricionistService, NutricionistService>();
builder.Services.AddTransient<ITrenerSeminarService, TrenerSeminarService>();
builder.Services.AddTransient<INutricionistSeminarService, NutricionistSeminarService>();
builder.Services.AddTransient<ISpolService, SpolService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IKorisnikUlogaService, KorisnikUlogaService>();
builder.Services.AddTransient<INarudzbaService, NarudzbaService>();
builder.Services.AddTransient<INarudzbaStavkaService, NarudzbaStavkaService>();
builder.Services.AddTransient<IPrisustvoService, PrisustvoService>();
builder.Services.AddTransient<IKorisnikClanarinaService, KorisnikClanarinaService>();
builder.Services.AddTransient<IBiznisReportService, BiznisReportService>();
builder.Services.AddTransient<IKorisnikTrenerService, KorisnikTrenerService>();
builder.Services.AddTransient<IKorisnikNutricionistService, KorisnikNutricionistService>();
builder.Services.AddTransient<IEmailService, EmailService>();
builder.Services.AddTransient<ITrackerService, TrackerService>();

builder.Services.AddTransient<BaseSuplementState>();
builder.Services.AddTransient<InitialSuplementState>();
builder.Services.AddTransient<DraftSuplementState>();
builder.Services.AddTransient<ActiveSuplementState>();
builder.Services.AddTransient<HiddenSuplementState>();


builder.Services.AddControllers(x=>
{
    x.Filters.Add<ExceptionFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new string[]{}
    } });

});

builder.Services.AddDatabaseServices(connectionString);

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        var frontendUrl = Environment.GetEnvironmentVariable("FRONTEND_URL");
        if (!string.IsNullOrWhiteSpace(frontendUrl))
            policy.WithOrigins(frontendUrl.TrimEnd('/')).AllowAnyMethod().AllowAnyHeader();
        else
            policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

builder.Services.AddMapster();

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


var app = builder.Build();

app.UseCors();

// Health endpoint for Render/load balancers (no auth required)
app.MapGet("/health", () => Results.Ok(new { status = "ok", timestamp = DateTime.UtcNow }))
   .AllowAnonymous();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Skip HTTPS redirect in production when behind Render's proxy (avoids "Failed to determine the https port" warning)
if (!app.Environment.IsProduction())
    app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<GmsDbContext>();
    await context.Database.ExecuteSqlRawAsync(
        "CREATE TABLE IF NOT EXISTS \"__EFMigrationsHistory\" (\"MigrationId\" varchar(150) NOT NULL PRIMARY KEY, \"ProductVersion\" varchar(32) NOT NULL);");
    await context.Database.MigrateAsync();
}

app.Run();
