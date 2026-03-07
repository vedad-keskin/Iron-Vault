# Deployment Rules – Supabase + Render (PostgreSQL)

Use this document as a step-by-step checklist when deploying any .NET backend + Flutter frontend project to **Supabase (PostgreSQL)** and **Render**. Copy and paste the relevant prompt section when configuring a new project.

---

## 1. Backend (.NET) – Convert to PostgreSQL

### 1.1 Version alignment (critical)

Use the **exact same** EF Core and Npgsql versions across all projects. No mixing 8.x and 9.x:

| Project | Package | Version |
|---------|---------|---------|
| Services (DbContext + migrations) | `Npgsql.EntityFrameworkCore.PostgreSQL` | **9.0.4** |
| Services | `Microsoft.EntityFrameworkCore.Tools` | **9.0.4** |
| Services | `DotNetEnv` | **3.1.1** |
| WebAPI | `Microsoft.EntityFrameworkCore.Design` | **9.0.4** |
| WebAPI | `DotNetEnv` | **3.1.1** |

**Remove** all SQL Server packages:
- `Microsoft.EntityFrameworkCore.SqlServer`

### 1.2 DatabaseConfiguration.cs (Services project)

Replace `UseSqlServer` with `UseNpgsql`:

```csharp
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection;

public static class DatabaseConfiguration
{
    public static void AddDatabaseServices(this IServiceCollection services, string connectionString)
    {
        services.AddDbContext<YourDbContext>(options =>
            options.UseNpgsql(connectionString)
                   .ConfigureWarnings(w => w.Ignore(RelationalEventId.PendingModelChangesWarning)));
    }
}
```

### 1.3 Design-time DbContext factory (Services project)

Create `YourDbContextFactory.cs` that implements `IDesignTimeDbContextFactory<YourDbContext>`:

```csharp
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using DotNetEnv;

public class YourDbContextFactory : IDesignTimeDbContextFactory<YourDbContext>
{
    public YourDbContext CreateDbContext(string[] args)
    {
        DotNetEnv.Env.TraversePath().Load();

        var mode = Environment.GetEnvironmentVariable("DB_MODE")?.Trim().ToLowerInvariant();
        string? host, port, name, user, password;

        if (mode == "supabase")
        {
            host     = Environment.GetEnvironmentVariable("DB_SUPABASE_HOST");
            port     = Environment.GetEnvironmentVariable("DB_SUPABASE_PORT");
            name     = Environment.GetEnvironmentVariable("DB_SUPABASE_NAME");
            user     = Environment.GetEnvironmentVariable("DB_SUPABASE_USER");
            password = Environment.GetEnvironmentVariable("DB_SUPABASE_PASSWORD");
        }
        else
        {
            host     = Environment.GetEnvironmentVariable("DB_HOST");
            port     = Environment.GetEnvironmentVariable("DB_PORT");
            name     = Environment.GetEnvironmentVariable("DB_NAME");
            user     = Environment.GetEnvironmentVariable("DB_USER");
            password = Environment.GetEnvironmentVariable("DB_PASSWORD");
        }

        port = string.IsNullOrWhiteSpace(port) ? "5432" : port;
        var cs = string.IsNullOrWhiteSpace(host) || string.IsNullOrWhiteSpace(name)
              || string.IsNullOrWhiteSpace(user) || string.IsNullOrWhiteSpace(password)
            ? "Host=localhost;Port=5432;Database=YourDb;Username=postgres;Password=postgres"
            : $"Host={host};Port={port};Database={name};Username={user};Password={password}";
        if (mode == "supabase") cs += ";SSL Mode=Require";

        var optionsBuilder = new DbContextOptionsBuilder<YourDbContext>();
        optionsBuilder.UseNpgsql(cs);
        return new YourDbContext(optionsBuilder.Options);
    }
}
```

### 1.4 Program.cs (WebAPI)

At the very top, before `WebApplication.CreateBuilder`:

```csharp
AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
DotNetEnv.Env.TraversePath().Load();
var connectionString = BuildPostgresConnectionString();
```

Key features to add:
- `BuildPostgresConnectionString()` – reads `DB_MODE`, `DB_*` or `DB_SUPABASE_*` from environment
- Render `PORT` detection: `builder.WebHost.UseUrls($"http://0.0.0.0:{port}");`
- CORS: in production use `FRONTEND_URL`; in dev allow all
- Before `app.Run()`:
  1. `CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" ...` (raw SQL)
  2. `context.Database.Migrate();`

### 1.5 .env files

**Root .env** (for docker-compose):
```
DB_NAME=YourDb
DB_USER=postgres
DB_PASSWORD=your_password_here
RABBITMQ__HOST=rabbitmq
RABBITMQ__USERNAME=guest
RABBITMQ__PASSWORD=guest
```

**WebAPI/.env** (for runtime + migrations):
```
ENVIRONMENT=local
FRONTEND_URL=
DB_MODE=local

DB_HOST=localhost
DB_PORT=5432
DB_NAME=YourDb
DB_USER=postgres
DB_PASSWORD=your_password_here

DB_SUPABASE_HOST=
DB_SUPABASE_PORT=5432
DB_SUPABASE_NAME=postgres
DB_SUPABASE_USER=
DB_SUPABASE_PASSWORD=

RABBITMQ__HOST=rabbitmq
RABBITMQ__USERNAME=guest
RABBITMQ__PASSWORD=guest
RABBITMQ__VIRTUALHOST=/
```

**Do NOT add `.env` to `.gitignore`** (this is a demo project).

### 1.6 Docker

**docker-compose.yml** – use `postgres:16-alpine` instead of SQL Server:
- API env: `DB_MODE=local`, `DB_HOST=postgres`, `DB_PORT=5432`
- Depends on: `postgres`

**Dockerfile** – expose 5130, set `ASPNETCORE_URLS=http://+:5130`

### 1.7 render.yaml

```yaml
services:
  - type: web
    name: yourproject-api
    runtime: docker
    dockerfilePath: ./Dockerfile
    envVars:
      - key: ENVIRONMENT
        value: production
      - key: DB_MODE
        sync: false
      - key: DB_SUPABASE_HOST
        sync: false
      - key: DB_SUPABASE_PORT
        value: "5432"
      - key: DB_SUPABASE_NAME
        value: postgres
      - key: DB_SUPABASE_USER
        sync: false
      - key: DB_SUPABASE_PASSWORD
        sync: false
      - key: FRONTEND_URL
        sync: false
      - key: RABBITMQ__HOST
        sync: false
      - key: RABBITMQ__USERNAME
        sync: false
      - key: RABBITMQ__PASSWORD
        sync: false
```

### 1.8 Migrations

**Do NOT create or edit migration files.** The developer creates migrations manually:

```bash
dotnet ef migrations add InitialPostgres --project YourProject.Services --startup-project YourProject.WebAPI
```

Delete the old SQL Server migrations folder before creating new ones.

---

## 2. Flutter Apps – Naming Conventions

### 2.1 App names

| App type | Name pattern | Example |
|----------|-------------|---------|
| Mobile (client) | `{ProjectName}` | **ManiFest** |
| Desktop (admin) | `{ProjectName} Admin` | **ManiFest Admin** |
| Desktop (role-specific) | `{ProjectName} {Role}` | **ManiFest Driver** |

### 2.2 Where to set names

**Android** – `android/app/src/main/AndroidManifest.xml`:
```xml
android:label="ManiFest"         <!-- mobile -->
android:label="ManiFest Admin"   <!-- desktop -->
```

**iOS** – `ios/Runner/Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>ManiFest</string>
<key>CFBundleName</key>
<string>ManiFest</string>
```

**macOS** – `macos/Runner/Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>ManiFest Admin</string>
```

**Windows** – `windows/runner/main.cpp`:
```cpp
window.Create(L"ManiFest Admin", origin, size)
```

**Windows** – `windows/runner/Runner.rc`:
```
VALUE "FileDescription", "ManiFest Admin"
VALUE "OriginalFilename", "ManiFest Admin.exe"
VALUE "ProductName", "ManiFest Admin"
```

### 2.3 App icons

Replace icons on all platforms using a high-res source image:
- **Android**: `android/app/src/main/res/mipmap-*dpi/ic_launcher.png`
- **iOS**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/` (all sizes in Contents.json)
- **macOS**: `macos/Runner/Assets.xcassets/AppIcon.appiconset/` (16–1024)
- **Windows**: `windows/runner/resources/app_icon.ico`

### 2.4 Base provider (backend URL)

Both apps use `String.fromEnvironment("baseUrl", defaultValue: ...)`:
- **Mobile default**: `http://10.0.2.2:5130/` (Android emulator)
- **Desktop default**: `http://localhost:5130/`

For production builds:
```bash
flutter build apk --dart-define=baseUrl=https://YOUR_RENDER_SERVICE.onrender.com/
flutter build windows --dart-define=baseUrl=https://YOUR_RENDER_SERVICE.onrender.com/
```

---

## 3. Supabase Setup

1. Create a new Supabase project
2. Go to **Project Settings → Database**
3. Copy from **Session pooler** (not Transaction):
   - Host (e.g. `aws-1-eu-central-1.pooler.supabase.com`)
   - Database name (usually `postgres`)
   - User (e.g. `postgres.xxxxx`)
   - Password
4. Fill these into `WebAPI/.env` under `DB_SUPABASE_*`
5. Set `DB_MODE=supabase`

---

## 4. Render Deployment

1. Push code to GitHub
2. Render → **New Web Service** → connect repo
3. Set root directory to the folder containing `Dockerfile`
4. Build: Docker
5. Add environment variables in Render dashboard:
   - `ENVIRONMENT=production`
   - `DB_MODE=supabase`
   - `DB_SUPABASE_HOST`, `DB_SUPABASE_PORT`, `DB_SUPABASE_NAME`, `DB_SUPABASE_USER`, `DB_SUPABASE_PASSWORD`
   - `FRONTEND_URL` (for CORS)
   - RabbitMQ vars (if using hosted broker)
6. `PORT` is set automatically by Render – do not override
7. Deploy. Migrations run automatically on startup.

---

## 5. Quick Reference – Full Workflow

```
1. Remove SQL Server NuGet packages, add Npgsql + DotNetEnv
2. Update DatabaseConfiguration.cs → UseNpgsql
3. Create DbContextFactory for design-time migrations
4. Update Program.cs (Npgsql switch, .env loading, BuildPostgresConnectionString, PORT, CORS, __EFMigrationsHistory)
5. Create/update .env files (root + WebAPI)
6. Update docker-compose.yml (postgres:16-alpine)
7. Create render.yaml
8. Create DEPLOY.md
9. Delete old SQL Server migrations
10. Run: dotnet ef migrations add InitialPostgres --project X.Services --startup-project X.WebAPI
11. Update Flutter app names (Android, iOS, macOS, Windows)
12. Update Flutter app icons (all platforms)
13. Update Flutter base_provider.dart (backend URL placeholder)
14. Test locally with docker-compose
15. Push to GitHub → deploy on Render
```



