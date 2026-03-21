# Iron Vault

Iron Vault is a gym / supplement management platform with a **.NET** backend and **Flutter** clients for administrators (desktop) and members (mobile). The stack targets **PostgreSQL (Supabase)** in production and **Render** for hosting the API.

## Architecture Overview

```
IronVault/
├── IronVault.Model/          # DTOs, requests, responses, search objects
├── IronVault.Services/       # Business logic, EF Core, migrations
├── IronVault.API/            # REST API, Basic Authentication
├── IronVault.RabbitMQ/       # Notification / email support (optional in compose)
└── UI/
    ├── ironvault_desktop/    # Flutter desktop — Iron Vault Admin
    └── ironvault_mobile/     # Flutter mobile — Iron Vault
```

See **[DEPLOY.md](./DEPLOY.md)** for Supabase, Render, Docker, Flutter builds, and environment variables.

## Technology Stack

- **Backend:** .NET 8, EF Core 9 + Npgsql (PostgreSQL)
- **API:** ASP.NET Core Web API, Basic Authentication
- **Frontend:** Flutter (Dart) — mobile + desktop
- **Hosting:** Docker, Render; database: Supabase (PostgreSQL)

## Development

### Prerequisites

- .NET 8 SDK  
- Flutter SDK (stable)  
- Docker Desktop (optional, for Postgres + RabbitMQ locally)

### Run API locally

```bash
cd IronVault.API
# Configure IronVault.API/.env (DB_*, etc.)
dotnet run
```

API default: **http://localhost:5130**

### Run Flutter apps

```bash
cd UI/ironvault_desktop
flutter run -d windows   # or macos / linux

cd UI/ironvault_mobile
flutter run
```

Production API URL is set in each app’s `lib/utils/app_constants.dart` (`apiBaseUrl`).

## GitHub Actions

### Keep-alive workflow (`.github/workflows/keep-alive.yml`)

Scheduled pings keep **Render** from sleeping as long and generate light activity against **Supabase** via real API calls.

| Time (UTC) | Job       | Action |
|------------|-----------|--------|
| 12:00      | `wake`    | `GET /` — wake cold Render (503/502 treated as OK) |
| 12:05      | `db-ping` | `GET /Grad`, `/Uloga`, `/Spol` with `Page=1&PageSize=1` (**AllowAnonymous** list endpoints) |
| 12:10      | `db-ping` | Same three endpoints again |

**Manual run:** Actions → **Iron Vault — Keep Supabase Alive** → **Run workflow**.

**`BASE_URL`** in the workflow must match `apiBaseUrl` in both Flutter apps (no trailing slash in YAML). Default: `https://iron-vault.onrender.com`.

**Optional:** define repository variable `IRONVAULT_API_BASE_URL` and use `env: BASE_URL: ${{ vars.IRONVAULT_API_BASE_URL }}` in the workflow.

> Swagger is **not** enabled in Production for this API; the wake step uses **`/`**, not `/swagger`.

## License

Add a LICENSE file if you need explicit licensing terms.
