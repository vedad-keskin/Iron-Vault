# Iron Vault – Deployment Guide (Supabase + Render)

This project is configured for deployment with **PostgreSQL (Supabase)** and **Render**, following the deployment rules in the repository.

## Prerequisites

- .NET 8 SDK
- Flutter SDK
- Docker (for local testing)
- Supabase account
- Render account
- GitHub repository

## 1. Backend – PostgreSQL / Supabase

### Local development

1. **Start PostgreSQL and RabbitMQ** (from repo root, folder containing `docker-compose.yml`):

   ```bash
   docker-compose up -d postgres rabbitmq
   ```

2. **Configure environment** – Copy or edit `IronVault.API/.env`:

   - `DB_MODE=local`
   - `DB_HOST=localhost` (or `postgres` when API runs in Docker)
   - `DB_PORT=5432`
   - `DB_NAME=IronVault`
   - `DB_USER=postgres`
   - `DB_PASSWORD=your_password_here`

3. **Run the API**:

   ```bash
   cd IronVault.API
   dotnet run
   ```

   API listens on **http://0.0.0.0:5130** (port 5130).

### Supabase setup

1. Create a new Supabase project.
2. In **Project Settings → Database**, use the **Session pooler** (not Transaction pooler).
3. Copy: **Host**, **Database name** (usually `postgres`), **User**, **Password**.
4. In `IronVault.API/.env` set:

   ```
   DB_MODE=supabase
   DB_SUPABASE_HOST=<host>
   DB_SUPABASE_PORT=5432
   DB_SUPABASE_NAME=postgres
   DB_SUPABASE_USER=<user>
   DB_SUPABASE_PASSWORD=<password>
   ```

### Migrations

Migrations are in `IronVault.Services/Migrations`. To add a new one (from the folder that contains `IronVault.API` and `IronVault.Services`):

```bash
dotnet ef migrations add YourMigrationName --project IronVault.Services --startup-project IronVault.API
```

Ensure `IronVault.API/.env` is set (e.g. `DB_MODE=local` and local Postgres, or `DB_MODE=supabase` and Supabase vars). Migrations run automatically on API startup (including on Render).

## 2. Render deployment

1. Push the code to GitHub (root = folder containing `Dockerfile` and `render.yaml`).
2. In Render: **New → Web Service**, connect the repo.
3. Set **Root Directory** to the folder that contains the `Dockerfile` (e.g. `IronVault` if the repo root is the deploy root).
4. **Build**: Docker; use the existing `Dockerfile`.
5. **Environment variables** (in Render dashboard):

   | Key | Value |
   |-----|--------|
   | `ENVIRONMENT` | `production` |
   | `DB_MODE` | `supabase` |
   | `DB_SUPABASE_HOST` | (from Supabase) |
   | `DB_SUPABASE_PORT` | `5432` |
   | `DB_SUPABASE_NAME` | `postgres` |
   | `DB_SUPABASE_USER` | (from Supabase) |
   | `DB_SUPABASE_PASSWORD` | (from Supabase) |
   | `FRONTEND_URL` | Your Flutter app origin (for CORS) |
   | `RABBITMQ__HOST` / `USERNAME` / `PASSWORD` | (if using hosted RabbitMQ) |

6. Do **not** set `PORT`; Render sets it automatically.
7. Deploy. The API will run migrations on startup.

After deploy, the API URL will be like: `https://ironvault-api.onrender.com` (or the name you gave the service).

## 3. Flutter apps

### App names

- **Mobile**: **Iron Vault**
- **Desktop (admin)**: **Iron Vault Admin**

Names are set in AndroidManifest, Info.plist (iOS/macOS), and Windows `main.cpp` / `Runner.rc`.

### Backend URL (baseUrl)

- **Mobile default**: `http://10.0.2.2:5130/` (Android emulator).
- **Desktop default**: `http://localhost:5130/`.

For **production**, build with the Render API URL:

```bash
# Mobile (APK)
flutter build apk --dart-define=baseUrl=https://YOUR_RENDER_SERVICE.onrender.com/

# Desktop (Windows)
flutter build windows --dart-define=baseUrl=https://YOUR_RENDER_SERVICE.onrender.com/
```

Replace `YOUR_RENDER_SERVICE` with your actual Render web service name/URL.

### App icons

Launcher icons are generated from **`assets/images/tinylogo4.png`** using `flutter_launcher_icons`. To regenerate:

```bash
cd UI/ironvault_desktop   # or UI/ironvault_mobile
flutter pub get
dart run flutter_launcher_icons
```

## 4. Quick reference

| Item | Value |
|------|--------|
| API port (local/Docker) | 5130 |
| Database | PostgreSQL (Supabase in production) |
| EF Core / Npgsql | 9.0.4 |
| .NET | 8.0 |
| Mobile app name | Iron Vault |
| Desktop app name | Iron Vault Admin |

## 5. Local full stack (Docker)

From the folder containing `docker-compose.yml`:

```bash
docker-compose up -d
```

- Postgres: `localhost:5432`
- API: `http://localhost:5130`
- RabbitMQ: ports 5672, 15672 (management)

Set Flutter apps’ baseUrl to `http://localhost:5130/` (desktop) or `http://10.0.2.2:5130/` (Android emulator) when testing locally.
