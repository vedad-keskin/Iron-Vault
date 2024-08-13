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

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ISuplementService, SuplementService>();
//builder.Services.AddTransient<ISuplementiService, DummySuplementiService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IDobavljacService, DobavljacService>();
builder.Services.AddTransient<IAktivnostService, AktivnostService>();
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

var connectionString = builder.Configuration.GetConnectionString("IronVaultConnection");
builder.Services.AddDbContext<GmsDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddMapster();

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();


using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<GmsDbContext>();
    // dataContext.Database.EnsureCreated();

    // dataContext.Database.Migrate();  // prilikom dockera da migrira
}

app.Run();
