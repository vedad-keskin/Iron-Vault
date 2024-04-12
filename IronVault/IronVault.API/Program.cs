using IronVault.API.Filters;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.Methods;
using IronVault.Services.SuplementStateMachine;
using Mapster;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ISuplementService, SuplementService>();
//builder.Services.AddTransient<ISuplementiService, DummySuplementiService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IDobavljacService, DobavljacService>();
builder.Services.AddTransient<IAktivnostService, AktivnostService>();
builder.Services.AddTransient<IKategorijaService, KategorijaService>();
builder.Services.AddTransient<IGradService, GradService>();
builder.Services.AddTransient<ITeretanaService, TeretanaService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();

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
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("IronVaultConnection");
builder.Services.AddDbContext<GmsDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddMapster();

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

app.Run();
