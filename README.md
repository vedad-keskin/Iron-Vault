# Iron Vault - Flutter aplikacija za upravljanje teretane

## Desktop Aplikacija

### Admin
- **Korisničko ime:** desktop
- **Lozinka:** test

## Mobilna Aplikacija

### Korisnik
- **Korisničko ime:** mobile
- **Lozinka:** test

## RabbitMQ Test E-mail Adresa

### Mail se šalje nakon zakazivanja termina kod trenera ili nutricioniste od strane korisnika
- **Email:** ironvault.test@gmail.com
- **Lozinka:** ironvaulttest1

## Environment fajlovi (.env)

### Pored baseUrl koji je konfigurabilan, postoje dva .env fajla 
- **.env u rootu projekta:** za konfiguraciju sql i rabbitmq podataka
- **.env u mobilnoj aplikaciji (UI/ironVault_mobile):** za konfiguraciju stripe publishable i secret key-a

## Recommender sistem

### Recommender sistem je implementiran na profilnoj stranici korisnika gdje su content-based filteringom na osnovu kategorija i proizvođača suplemenata kojih je korisnik ranije kupovao preporučena 3 najbolja rezultata

