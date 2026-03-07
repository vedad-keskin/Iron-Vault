using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using DotNetEnv;

namespace IronVault.Services.Database;

public class GmsDbContextFactory : IDesignTimeDbContextFactory<GmsDbContext>
{
    public GmsDbContext CreateDbContext(string[] args)
    {
        DotNetEnv.Env.TraversePath().Load();

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
        var cs = string.IsNullOrWhiteSpace(host) || string.IsNullOrWhiteSpace(name)
              || string.IsNullOrWhiteSpace(user) || string.IsNullOrWhiteSpace(password)
            ? "Host=localhost;Port=5432;Database=IronVault;Username=postgres;Password=postgres"
            : $"Host={host};Port={port};Database={name};Username={user};Password={password}";
        if (mode == "supabase") cs += ";SSL Mode=Require";

        var optionsBuilder = new DbContextOptionsBuilder<GmsDbContext>();
        optionsBuilder.UseNpgsql(cs);
        return new GmsDbContext(optionsBuilder.Options);
    }
}
