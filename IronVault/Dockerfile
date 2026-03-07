FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5130
ENV ASPNETCORE_URLS=http://+:5130

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "IronVault.API/IronVault.API.csproj"
RUN dotnet build "IronVault.API/IronVault.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "IronVault.API/IronVault.API.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "IronVault.API.dll"]
