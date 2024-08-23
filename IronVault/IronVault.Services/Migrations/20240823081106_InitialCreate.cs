using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace IronVault.Services.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Clanarina",
                columns: table => new
                {
                    ClanarinaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<float>(type: "real", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Clanarina", x => x.ClanarinaID);
                });

            migrationBuilder.CreateTable(
                name: "Dobavljac",
                columns: table => new
                {
                    DobavljacID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Dobavljac", x => x.DobavljacID);
                });

            migrationBuilder.CreateTable(
                name: "FAQ",
                columns: table => new
                {
                    FAQID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Pitanje = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Odgovor = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FAQ", x => x.FAQID);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradID);
                });

            migrationBuilder.CreateTable(
                name: "Kategorija",
                columns: table => new
                {
                    KategorijaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kategorija", x => x.KategorijaID);
                });

            migrationBuilder.CreateTable(
                name: "Nutricionist",
                columns: table => new
                {
                    NutricionistID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nutricionist", x => x.NutricionistID);
                });

            migrationBuilder.CreateTable(
                name: "Seminar",
                columns: table => new
                {
                    SeminarID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Tema = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Predavac = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Seminar", x => x.SeminarID);
                });

            migrationBuilder.CreateTable(
                name: "Spol",
                columns: table => new
                {
                    SpolID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Spol", x => x.SpolID);
                });

            migrationBuilder.CreateTable(
                name: "Trener",
                columns: table => new
                {
                    TrenerID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Trener", x => x.TrenerID);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaID);
                });

            migrationBuilder.CreateTable(
                name: "Suplement",
                columns: table => new
                {
                    SuplementID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<float>(type: "real", nullable: false),
                    Gramaza = table.Column<float>(type: "real", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ProsjecnaOcjena = table.Column<double>(type: "float", nullable: true),
                    DobavljacID = table.Column<int>(type: "int", nullable: false),
                    KategorijaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Suplement", x => x.SuplementID);
                    table.ForeignKey(
                        name: "FK_Suplement_Dobavljac_DobavljacID",
                        column: x => x.DobavljacID,
                        principalTable: "Dobavljac",
                        principalColumn: "DobavljacID");
                    table.ForeignKey(
                        name: "FK_Suplement_Kategorija_KategorijaID",
                        column: x => x.KategorijaID,
                        principalTable: "Kategorija",
                        principalColumn: "KategorijaID");
                });

            migrationBuilder.CreateTable(
                name: "Nutricionist_Seminar",
                columns: table => new
                {
                    Nutricionist_SeminarID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NutricionistID = table.Column<int>(type: "int", nullable: false),
                    SeminarID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nutricionist_Seminar", x => x.Nutricionist_SeminarID);
                    table.ForeignKey(
                        name: "FK_Nutricionist_Seminar_Nutricionist_NutricionistID",
                        column: x => x.NutricionistID,
                        principalTable: "Nutricionist",
                        principalColumn: "NutricionistID");
                    table.ForeignKey(
                        name: "FK_Nutricionist_Seminar_Seminar_SeminarID",
                        column: x => x.SeminarID,
                        principalTable: "Seminar",
                        principalColumn: "SeminarID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrojTelefona = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Visina = table.Column<float>(type: "real", nullable: false),
                    Tezina = table.Column<float>(type: "real", nullable: false),
                    Razina = table.Column<int>(type: "int", nullable: true),
                    VrijemeUTeretani = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    GradID = table.Column<int>(type: "int", nullable: false),
                    SpolID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Grad_GradID",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "GradID");
                    table.ForeignKey(
                        name: "FK_Korisnik_Spol_SpolID",
                        column: x => x.SpolID,
                        principalTable: "Spol",
                        principalColumn: "SpolID");
                });

            migrationBuilder.CreateTable(
                name: "Trener_Seminar",
                columns: table => new
                {
                    Trener_SeminarID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TrenerID = table.Column<int>(type: "int", nullable: false),
                    SeminarID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Trener_Seminar", x => x.Trener_SeminarID);
                    table.ForeignKey(
                        name: "FK_Trener_Seminar_Seminar_SeminarID",
                        column: x => x.SeminarID,
                        principalTable: "Seminar",
                        principalColumn: "SeminarID");
                    table.ForeignKey(
                        name: "FK_Trener_Seminar_Trener_TrenerID",
                        column: x => x.TrenerID,
                        principalTable: "Trener",
                        principalColumn: "TrenerID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnik_Clanarina",
                columns: table => new
                {
                    Korisnik_ClanarinaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    ClanarinaID = table.Column<int>(type: "int", nullable: false),
                    DatumUplate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumIsteka = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik_Clanarina", x => x.Korisnik_ClanarinaID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Clanarina_Clanarina_ClanarinaID",
                        column: x => x.ClanarinaID,
                        principalTable: "Clanarina",
                        principalColumn: "ClanarinaID");
                    table.ForeignKey(
                        name: "FK_Korisnik_Clanarina_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnik_Nutricionst",
                columns: table => new
                {
                    Korisnik_NutricionistID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    NutricionistID = table.Column<int>(type: "int", nullable: false),
                    DatumTermina = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ZakazanoSati = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik_Nutricionst", x => x.Korisnik_NutricionistID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Nutricionst_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_Korisnik_Nutricionst_Nutricionist_NutricionistID",
                        column: x => x.NutricionistID,
                        principalTable: "Nutricionist",
                        principalColumn: "NutricionistID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnik_Trener",
                columns: table => new
                {
                    Korisnik_TrenerID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    TrenerID = table.Column<int>(type: "int", nullable: false),
                    DatumTermina = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ZakazanoSati = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik_Trener", x => x.Korisnik_TrenerID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Trener_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_Korisnik_Trener_Trener_TrenerID",
                        column: x => x.TrenerID,
                        principalTable: "Trener",
                        principalColumn: "TrenerID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnik_Uloga",
                columns: table => new
                {
                    Korisnik_UlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    UlogaID = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik_Uloga", x => x.Korisnik_UlogaID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Uloga_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_Korisnik_Uloga_Uloga_UlogaID",
                        column: x => x.UlogaID,
                        principalTable: "Uloga",
                        principalColumn: "UlogaID");
                });

            migrationBuilder.CreateTable(
                name: "Narudzba",
                columns: table => new
                {
                    NarudzbaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    Sifra = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumVrijemeNarudzbe = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    Otkazano = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Narudzba", x => x.NarudzbaID);
                    table.ForeignKey(
                        name: "FK_Narudzba_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "Prisustvo",
                columns: table => new
                {
                    PrisustvoID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    DatumVrijemeUlaska = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumVrijemeIzlaska = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Prisustvo", x => x.PrisustvoID);
                    table.ForeignKey(
                        name: "FK_Prisustvo_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "Recenzija",
                columns: table => new
                {
                    RecenzijaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    SuplementID = table.Column<int>(type: "int", nullable: false),
                    Ocjena = table.Column<int>(type: "int", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recenzija", x => x.RecenzijaID);
                    table.ForeignKey(
                        name: "FK_Recenzija_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_Recenzija_Suplement_SuplementID",
                        column: x => x.SuplementID,
                        principalTable: "Suplement",
                        principalColumn: "SuplementID");
                });

            migrationBuilder.CreateTable(
                name: "Narudzba_Stavka",
                columns: table => new
                {
                    Narudzba_StavkaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NarudzbaID = table.Column<int>(type: "int", nullable: false),
                    SuplementID = table.Column<int>(type: "int", nullable: false),
                    Kolicina = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Narudzba_Stavka", x => x.Narudzba_StavkaID);
                    table.ForeignKey(
                        name: "FK_Narudzba_Stavka_Narudzba_NarudzbaID",
                        column: x => x.NarudzbaID,
                        principalTable: "Narudzba",
                        principalColumn: "NarudzbaID");
                    table.ForeignKey(
                        name: "FK_Narudzba_Stavka_Suplement_SuplementID",
                        column: x => x.SuplementID,
                        principalTable: "Suplement",
                        principalColumn: "SuplementID");
                });

            migrationBuilder.InsertData(
                table: "Clanarina",
                columns: new[] { "ClanarinaID", "Cijena", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, 50f, "Fit Plus", "Teretane predstavljaju oazu zdravlja pružajući nam prostor gdje možemo ojačati svoje tijelo i smanjiti stres. Članstvo u teretani nije samo ulaganje u tjelesno zdravlje već i putovanje prema boljoj verziji sebe." },
                    { 2, 40f, "Student Fit Plus", "Studentska članarina u teretani nije samo investicija u tjelesno zdravlje, već i u opću dobrobit studenata. Zahvaljujući ovim povlasticama, teretane postaju pristupačne za studente svih financijskih mogućnosti, čime se stvara zdraviji i sretniji studentski život. Zbog toga mi nudimo popust od čak 20% za sve studente!" },
                    { 3, 25f, "Partner Fit Duo", "Teretane nude posebne članarine za parove koje omogućuju partnerima da zajedno uživaju u prednostima vježbanja. Podijelite iznos jedne članarine i uživajte u jačanju tijela i uma!" }
                });

            migrationBuilder.InsertData(
                table: "Dobavljac",
                columns: new[] { "DobavljacID", "Naziv" },
                values: new object[,]
                {
                    { 1, "MUSCLE FREAK" },
                    { 2, "MUSCLETECH" },
                    { 3, "OPTIMUM NUTRITION" },
                    { 4, "SELF OMNINUTRITION" },
                    { 5, "CW-CHEMICAL WARFARE" },
                    { 6, "BSN" },
                    { 7, "CELLUCOR" },
                    { 8, "EVOLITE" },
                    { 9, "SUPERIOR" },
                    { 10, "TESLA" }
                });

            migrationBuilder.InsertData(
                table: "FAQ",
                columns: new[] { "FAQID", "Odgovor", "Pitanje" },
                values: new object[,]
                {
                    { 1, "Cijene mjesečnih članarina variraju ovisno o paketu koji odaberete. Imamo različite opcije prilagođene različitim potrebama i budžetima. Detaljne informacije o cijenama možete pronaći na recepciji naše teretane.", "Koja je cijena članarina u vašoj teretani?" },
                    { 2, "Da, imamo stručne trenere koji vam mogu pomoći u postizanju vaših fitness ciljeva. Oni će raditi s vama kako bi razvili personalizirani plan vježbanja. Pored njih, imamo i naš tim nutricionista.", "Da li u sklopu teretane imate personalne trenere?" },
                    { 3, "Vrlo jednostavno! Posjetite našu recepciju, odaberite željeni paket i dobit ćete svoju člansku karticu!", "Kako da postanem član vaše teretane?" },
                    { 4, "Razinu povećavate na sljedeću razinu svakih 10 sati provedenih u teretani.", "Kako da povećam svoju razinu?" },
                    { 5, "Kupovinu suplemenata izvršavate klikom naruči preko Stripe servisa, nakon kojeg dobijete potvrdu kupovine na mail.", "Kako izvršiti kupovinu suplemenata?" }
                });

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "GradID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Banja Luka" },
                    { 2, "Bihać" },
                    { 3, "Bijeljina" },
                    { 4, "Bosnaska Krupa" },
                    { 5, "Cazin" },
                    { 6, "Čapljina" },
                    { 7, "Drventa" },
                    { 8, "Doboj" },
                    { 9, "Goražde" },
                    { 10, "Gračanica" },
                    { 11, "Gradačac" },
                    { 12, "Gradiška" },
                    { 13, "Konjic" },
                    { 14, "Laktaši" },
                    { 15, "Livno" },
                    { 16, "Lukavac" },
                    { 17, "Ljubuški" },
                    { 18, "Mostar" },
                    { 19, "Orašje" },
                    { 20, "Prijedor" },
                    { 21, "Prnjavor" },
                    { 22, "Sarajevo" },
                    { 23, "Srebrenik" },
                    { 24, "Stolac" },
                    { 25, "Široki Brijeg" },
                    { 26, "Travnik" },
                    { 27, "Tuzla" },
                    { 28, "Visoko" },
                    { 29, "Zavidovići" },
                    { 30, "Zenica" },
                    { 31, "Zvornik" },
                    { 32, "Živinice" },
                    { 33, "Donji Vakuf" },
                    { 34, "Zavidovići" }
                });

            migrationBuilder.InsertData(
                table: "Kategorija",
                columns: new[] { "KategorijaID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Proteini" },
                    { 2, "Amino kiseline" },
                    { 3, "Preworkout" },
                    { 4, "Mass gaineri" }
                });

            migrationBuilder.InsertData(
                table: "Nutricionist",
                columns: new[] { "NutricionistID", "BrojTelefona", "Email", "Ime", "Prezime", "Slika" },
                values: new object[,]
                {
                    { 1, "062709689", "vedad.keskin98@gmail.com", "Marijana", "Zubac", null },
                    { 2, "062709689", "vedad.keskin98@gmail.com", "Amela", "Ivković", null }
                });

            migrationBuilder.InsertData(
                table: "Seminar",
                columns: new[] { "SeminarID", "Datum", "Predavac", "Tema" },
                values: new object[,]
                {
                    { 1, new DateTime(2022, 12, 10, 9, 15, 0, 0, DateTimeKind.Unspecified), "Maja Gradinjan", "Metabolički Sindrom" },
                    { 2, new DateTime(2023, 4, 12, 9, 15, 0, 0, DateTimeKind.Unspecified), "Darija Topić", "Pravilna prehrana u službi zdravlja i sportskog razvoja" },
                    { 3, new DateTime(2020, 1, 10, 9, 15, 0, 0, DateTimeKind.Unspecified), "Tatjana Popović", "Snaga u vama" },
                    { 4, new DateTime(2019, 12, 10, 9, 15, 0, 0, DateTimeKind.Unspecified), "Ivan Račić", "CrossFit Level 3" },
                    { 5, new DateTime(2017, 6, 10, 9, 15, 0, 0, DateTimeKind.Unspecified), "Petar Klančir", "Pro Bodybuilding" },
                    { 6, new DateTime(2022, 1, 1, 12, 15, 0, 0, DateTimeKind.Unspecified), "Almir Tunić", "Samoodbrana" }
                });

            migrationBuilder.InsertData(
                table: "Spol",
                columns: new[] { "SpolID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Muški" },
                    { 2, "Ženski" }
                });

            migrationBuilder.InsertData(
                table: "Trener",
                columns: new[] { "TrenerID", "BrojTelefona", "Email", "Ime", "Prezime", "Slika" },
                values: new object[,]
                {
                    { 1, "0644076290", "vedad.keskin98@gmail.com", "Kadir", "Keskin", null },
                    { 2, "0644076290", "vedad.keskin98@gmail.com", "Azur", "Kahriman", null }
                });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Administrator", "Administrator ima sve permisije na aplikaciji." },
                    { 2, "User", "User ima samo korisničke permisije." }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikID", "BrojTelefona", "Email", "GradID", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Razina", "Slika", "SpolID", "Tezina", "Visina", "VrijemeUTeretani" },
                values: new object[,]
                {
                    { 1, "0644076290", "vedad.keskin98@gmail.com", 18, "Vedad", "vedadke", "g7FHgT4d85m0BouhHe1t0KYM2wA=", "QZ4IoSnKb7hg8L7nDFizTg==", "Keskin", 3, null, 1, 80f, 170f, "0 dana, 21 sati i 0 minuta" },
                    { 2, "062709689", "vedad.keskin98@gmail.com", 33, "Amel", "amelm", "Yya6va1Yoa/gtyLz5Z4IXYfFt5Q=", "tXOzvBnYM/kaUy/CDd7V/g==", "Musić", 2, null, 1, 82f, 185f, "0 dana, 12 sati i 0 minuta" },
                    { 3, "061000000", "vedad.keskin98@gmail.com", 18, "Denis", "denism", "2Kfy1C0XBFtOApv4hlUaEQH4aqs=", "QLSAf12F9XkD+4ZLEFZz+w==", "Mušić", 1, null, 1, 83f, 186f, null },
                    { 4, "062000000", "vedad.keskin98@gmail.com", 34, "Elmir", "elmirb", "1wrfyYURG83rXcpYOK7LxbASzxY=", "gu5g9kJouJlB19/DNtCtaw==", "Babović", 1, null, 1, 86f, 189f, null }
                });

            migrationBuilder.InsertData(
                table: "Nutricionist_Seminar",
                columns: new[] { "Nutricionist_SeminarID", "NutricionistID", "SeminarID" },
                values: new object[,]
                {
                    { 1, 1, 2 },
                    { 2, 1, 3 },
                    { 3, 2, 1 },
                    { 4, 2, 3 }
                });

            migrationBuilder.InsertData(
                table: "Suplement",
                columns: new[] { "SuplementID", "Cijena", "DobavljacID", "Gramaza", "KategorijaID", "Naziv", "Opis", "ProsjecnaOcjena", "Slika", "StateMachine" },
                values: new object[,]
                {
                    { 1, 139f, 1, 2500f, 1, "100% Whey Protein", "Muscle Freak 100% Isolate Whey Protein je visokokvalitetni izolat proteina sirutke, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.", 4.5, null, "active" },
                    { 2, 99f, 3, 809f, 1, "Gold 100% Casein", "Korištenjem samo vrhunskog kazeina kao izvora proteina u svom 100% Gold Standard Casein-u, Optimum Nutrition je stvorio formulu koja postavlja standard za sve sporootpuštajuće proteine.", 3.5, null, "active" },
                    { 3, 89f, 2, 900f, 1, "Nitro-Tech Ripped", "NITRO-TECH RIPPED™ je najnovija inovacija iz MuscleTech-a, branda koji oduševljava svojim proizvodima više od 20 godina. Ova napredna formula kombinuje proteinske peptide najviše kvalitete i izolat sa naučno testiranim sastojcima za gubitak težine. Ova 7 u 1 formula također sadrži CLA, trigliceride srednjeg lanca (MCT), L-carnitine L-tartrate, ekstrakt zelenog čaja, ekstrakt šipka i prah algi. MuscleTech® je napravio ovu jedinstvenu formula s ciljem objedinjavanja ultra-čistog proteina i gubitka težine - ovakvo nešto niste nikad prije vidjeli. Za razliku od konkurencije, svaka mjerica NITRO-TECH RIPPED™ sadrži naučno proučavanu dozu ključnih sastojaka za gubitak težine, C. canephora robusta, koja je potvrđena od strane dvije naučne studije i u čije rezultate ne morate sumnjati! Također, nevjerovatnog je okusa koji će Vas oduševiti!", 1.0, null, "active" },
                    { 4, 139f, 2, 1800f, 1, "Nitro-Tech Whey Protein", "NITRO-TECH® je naučno istražena, pojačana proteinska formula kreirana za sve sportiste koji žele veću mišićnu masu, više snage i bolje performanse. NITRO-TECH® sadrži protein čiji primarni izvor su peptidi i izolat sirutke – dva najčistija i najkvalitetnija dostupna izvora proteina, za razliku od ostalih proteinskih suplemenata koji možda sadrže tek par gama ovih lako probavljivih i visoke biološke vrijednosti proteina. NITRO-TECH® je takođe poboljšan i sa 3g kreatin monohidrata, najistraženijim oblikom kreatina, namjenjenim za još veću mišićnu masu i snagu.", 4.0, null, "active" },
                    { 5, 89f, 2, 908f, 1, "Nitro-Tech 100% Whey", "Preko 20 godina NITRO-TECH® je vodeći proteinski brend, izgrađen na temelju naučnih istraživanja i korištenja najmodernije tehnologija. Sada je isti istraživački i razvojni tim stvorio novu formulu whey proteina baziranu na superiornim izvorima proteina, kvaliteti i tehnici proizvodnje. Predstavljamo vam NITRO-TECH® 100% WHEY GOLD – čistu proteinsku formulu koja sadrži peptide i izolat sirutke.", 5.0, null, "active" },
                    { 6, 119f, 2, 2000f, 1, "Platinum 8", "Vrhunska proteinska mješavina za sve namjene u bilo koje vrijeme posebno formulirana za sportiste koji žele biti na vrhuncu svoje igre. Dizajniran s visokokvalitetnom, višefaznom mješavinom proteina, može se uzimati kad god je potrebno - nakon treninga, između obroka ili prije spavanja.", 4.0, null, "active" },
                    { 7, 35f, 4, 250f, 2, "BCAA 2:1:1", "Vrhunski ukusan spoj esencijalnih aminokiselina. Ovaj proizvod ne samo da pruža izvanredan ukus, već je i obogaćen esencijalnim hranjivim sastojcima poput vitamina C i vitamina B6. BCAA je kritičan faktor koji vam može pomoći da postignete najbolje iz svojih treninga.", 4.5, null, "active" },
                    { 8, 45f, 4, 900f, 2, "HMB", "Self Omninutrition HMB (beta-hidroksi-beta-metilbutirat) je metabolit leucina koji sprečava razgradnju proteina i promoviše hipertrofiju mišića (povećanje ćelija koje grade tkivo); također smanjuje moguće povrede mišića nakon treninga visokog intenziteta, čime se smanjuje postotak masnoće u tijelu. Nedavna istraživanja su također pokazala da uzimanje HMB povećava mišićnu snagu, smanjuje simptome prekomjernog treninga te pozitivno utiče na VO2max (maksimalna potrošnja kiseonika). Neki stručnjaci smatraju da je VO2max ključni faktor u sportskim takmičenjima sportista. HMB je vrijedan dodatak ishrani za snagu, performanse i izdržljivost.", 3.5, null, "active" },
                    { 9, 75f, 2, 400f, 2, "Amino Build", "Napunjene sa gradivnim elementima kako bi podržale brz oporavak. Imajući u vidu da su BCAA kao osnova u sastavu, ubrzat će period oporavka poslije treninga.", 5.0, null, "active" },
                    { 10, 85f, 2, 594f, 2, "Cell Tech Elite", "Cell Tech Elite je visoko potentna formula koja pruža vrhunsku dozu od 5 g kreatinske matrice, koja uključuje kreatin monohidrat i kreatin hidroklorid. Osim toga, ova formula sadrži klinički dokazanu dozu od 400 mg Peak ATP-a, koji omogućava povećanje snage i veći broj ponavljanja u treningu. U kliničkoj studiji je dokazano da su ispitanici koji su koristili Peak ATP izgradili 90% više mišića u poređenju sa placebom, postižući impresivne rezultate u roku od 12 sedmica intenzivnog treninga.", 5.0, null, "active" },
                    { 11, 85f, 5, 480f, 2, "CW Intra Surgence", "CW Intra Surgence je naučno formuliran Intra-Workout dodatak koji pruža visoko doziranu mješavinu punog spektra esencijalnih aminokiselina (EAA) i razgranatih lanaca aminokiselina (BCAA), zajedno s najnovijim hidratacijskim sastojcima i patentiranim dodacima za povećanje energije.", null, null, "active" },
                    { 12, 65f, 6, 433f, 2, "Amino X", "Amino X je specijalna aminokiselinska formula dizajnirana da pomogne tijelu u povećanju izdržljivosti tokom treninga i mišićnom oporavku nakon treninga. Sadrži kvalitetnu anaboličku mješavinu, koja spriječava katabolizam (propadanje mišićnih vlakna) te se brine za obnovu i rast mišića.", null, null, "active" },
                    { 13, 65f, 1, 300f, 3, "Power Reactor", "Muscle Freak Power Reactor je visokokvalitetni pre-workout, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.", null, null, "active" },
                    { 14, 85f, 2, 420f, 3, "N.O.-Xplode Vaso", "Izgradnja mišića zahtijeva pravilnu ishranu i treninge. Mnogi suplementi prije treninga mogu pružiti energiju i fokus, ali rijetko isporučuju onu pravu \"pumpu\" koju tražite. Ali sada je vaša potraga gotova zahvaljujući N.O.-XPLODE VASO!", null, null, "active" },
                    { 15, 85f, 7, 410f, 3, "C4 Ultimate", "Cellucor C4 Ultimate je dugi niz godina usavršavao pre-workoute, mnogo prije nego neki drugi brendovi u industriji sportskih suplemenata. Gotovo desetljeće brend C4® bio je prvi u kategoriji pre-workouta sa učinkom i eksplozivnom energijom, najboljim okusima, klinički proučenim sastojcima i vrhunskim formulama.", null, null, "active" },
                    { 16, 65f, 7, 180f, 3, "C4 Ripped", "C4 Ripped sadrži sličnu energetsku mješavinu kao i klasični C4, s ključnim sastojcima za energiju koji će vam pomoći da prođete kroz najteže vježbe.", null, null, "active" },
                    { 17, 69f, 6, 390f, 3, "N.O.-Xplode", "N.O.-XPLODE pomaže u održavanju mentalne budnosti i mišićne snage, donosi energiju i izdržljivost te pomaže sportistima poboljšati kapacitet na svim razinama.", null, null, "active" },
                    { 18, 69f, 2, 363f, 3, "Shatter", "MuscleTech Shatter™ je iznimno snažan i naučno osmišljen pre-workout suplement koji će Vam doslovno razderati majicu i poboljšati vaše performanse snage i izdržljivosti. Ova vrhunska formula pruža i snažnu energiju i kompleks koji će Vas potaknuti kroz svaki trening.", null, null, "active" },
                    { 19, 79f, 1, 1200f, 4, "Mega Mass", "Muscle Freak Mega Mass je visokokvalitetni gainer, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.", null, null, "active" },
                    { 20, 119f, 2, 3200f, 4, "Mass Tech ELITE", "Mass-Tech Elite je napredni mass gainer za one koji imaju problemasa povećanjem veličine ili žele da probiju svoje platoe snage...", null, null, "active" },
                    { 21, 89f, 2, 2300f, 4, "100% Mass Gainer", "Iz najbolje američke kompanije za prodaju suplemenata, MuscleTech predstavlja Vam 100% Mass Gainer - visokoproteinski suplement za povećanje mišične mase. Ovaj dodatak, obogaćen prirodnim i umjetnim aromama, pruža Vam sve što je potrebno da unaprijedite mišiće, snagu i performanse, uz brži oporavak mišića.", null, null, "active" },
                    { 22, 75f, 10, 2270f, 4, "Mass Super Charger", "Tesla Mass Super Charger može pomoći vašim mišićima da rastu, zahvaljujući  ugljikohidratima iz više izvora, visokom sadržaju proteina i dodatku aminokiselina u optimalnom omjeru 2:1:1 za pomoć u iskorištavanju proteina. Kreatin je također dodat kako bi pomogao da se mišići napune vodom i potakne daljnji rast, zajedno s pažljivo odabranim vitaminskim kompleksom koji podržava sposobnost vašeg tijela da koristi proteine ​​i ugljikohidrate za energiju i čistu mišićnu masu.", null, null, "active" },
                    { 23, 119f, 8, 1000f, 4, "IsoGainz", "Evolite IsoGainz je ugljikohidratno-proteinski suplement visoke kvalitete namijenjen prvenstveno aktivnim osobama koji se sastoji od: odabrani ugljikohidrati (maltodextrin sa jako malim sadržajem šećera) proteina (izolat I koncentrat koji ne sadrže laktozu) .Proizvod se može koristiti kao dodatak svakodnevnoj prehrani. Idealno prikladan za korištenje nakon treninga kako bi se nadoknadile zalihe energije u mišićima. Protein doprinosi rastu mišične mase I pomaže u njenom održavanju.", null, null, "active" },
                    { 24, 159f, 9, 8000f, 4, "Hyper Mass", "Hyper Mass Professional je izuzetno moćan suplement s bogatim vitaminskim kompleksom, namijenjen da vam pomogne postići vaše ciljeve u izgradnji mišića! Ovaj preparat Hyper Mass, sa svojom vrhunskom kombinacijom sastojaka, idealan je izbor za sve koji žele dodati mišićnu masu, povećati snagu i izdržljivost tokom treninga.", null, null, "active" }
                });

            migrationBuilder.InsertData(
                table: "Trener_Seminar",
                columns: new[] { "Trener_SeminarID", "SeminarID", "TrenerID" },
                values: new object[,]
                {
                    { 1, 5, 1 },
                    { 2, 6, 1 },
                    { 3, 4, 2 },
                    { 4, 6, 2 }
                });

            migrationBuilder.InsertData(
                table: "Korisnik_Clanarina",
                columns: new[] { "Korisnik_ClanarinaID", "ClanarinaID", "DatumIsteka", "DatumUplate", "KorisnikID" },
                values: new object[,]
                {
                    { 1, 2, new DateTime(2023, 10, 1, 9, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 9, 1, 9, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 2, 2, new DateTime(2023, 11, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 3, 2, new DateTime(2023, 12, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 11, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 4, 2, new DateTime(2024, 1, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 12, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 5, 2, new DateTime(2024, 2, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 1, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 6, 2, new DateTime(2024, 3, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 2, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 7, 2, new DateTime(2024, 5, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 8, 2, new DateTime(2024, 6, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 9, 2, new DateTime(2024, 7, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 10, 2, new DateTime(2024, 8, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 11, 2, new DateTime(2024, 7, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 12, 2, new DateTime(2024, 8, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 13, 2, new DateTime(2024, 9, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 2 }
                });

            migrationBuilder.InsertData(
                table: "Korisnik_Uloga",
                columns: new[] { "Korisnik_UlogaID", "DatumIzmjene", "KorisnikID", "UlogaID" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 1, 2 },
                    { 3, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 4, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 2, 2 },
                    { 5, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 6, new DateTime(2023, 10, 1, 7, 15, 0, 0, DateTimeKind.Unspecified), 4, 2 }
                });

            migrationBuilder.InsertData(
                table: "Narudzba",
                columns: new[] { "NarudzbaID", "DatumVrijemeNarudzbe", "KorisnikID", "Otkazano", "Sifra", "Status" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 9, 1, 9, 15, 0, 0, DateTimeKind.Unspecified), 1, false, "SIF-000-001", false },
                    { 2, new DateTime(2023, 10, 1, 9, 15, 0, 0, DateTimeKind.Unspecified), 2, false, "SIF-000-002", false },
                    { 3, new DateTime(2023, 10, 4, 9, 15, 0, 0, DateTimeKind.Unspecified), 1, false, "SIF-000-003", false },
                    { 4, new DateTime(2023, 10, 9, 9, 15, 0, 0, DateTimeKind.Unspecified), 2, true, "SIF-000-004", false },
                    { 5, new DateTime(2023, 11, 7, 9, 15, 0, 0, DateTimeKind.Unspecified), 1, false, "SIF-000-005", false },
                    { 6, new DateTime(2023, 11, 8, 9, 15, 0, 0, DateTimeKind.Unspecified), 3, false, "SIF-000-006", false }
                });

            migrationBuilder.InsertData(
                table: "Prisustvo",
                columns: new[] { "PrisustvoID", "DatumVrijemeIzlaska", "DatumVrijemeUlaska", "KorisnikID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 3, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 3, 18, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 2, new DateTime(2024, 3, 5, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 5, 20, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 3, new DateTime(2024, 3, 8, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 8, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 4, new DateTime(2024, 4, 7, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 7, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 5, new DateTime(2024, 4, 9, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 9, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 6, new DateTime(2024, 4, 13, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 13, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 7, new DateTime(2024, 4, 16, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 16, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 8, new DateTime(2024, 4, 21, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 21, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 9, new DateTime(2024, 4, 25, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 25, 19, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 10, new DateTime(2024, 4, 26, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 26, 19, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 11, new DateTime(2024, 4, 29, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 4, 29, 19, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 12, new DateTime(2024, 5, 3, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 3, 19, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 13, new DateTime(2024, 5, 9, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 19, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 14, null, new DateTime(2024, 8, 19, 20, 52, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 15, null, new DateTime(2024, 8, 19, 21, 22, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 16, null, new DateTime(2024, 8, 19, 17, 12, 0, 0, DateTimeKind.Unspecified), 3 }
                });

            migrationBuilder.InsertData(
                table: "Recenzija",
                columns: new[] { "RecenzijaID", "KorisnikID", "Ocjena", "Opis", "SuplementID" },
                values: new object[,]
                {
                    { 1, 1, 5, "Prozivod mi je mnogo pomogao, tople preporuke.", 1 },
                    { 2, 2, 4, "Dobar proizvod, samo je dostava trajala duže od dogovorenog.", 1 },
                    { 3, 1, 5, "Odličan proizvod.", 2 },
                    { 4, 2, 2, "Loš ukus.", 2 },
                    { 5, 3, 1, "Katastrofa.", 3 },
                    { 6, 1, 4, "Ukus nije baš najbolji ali je progres očigledan.", 4 },
                    { 7, 3, 5, "Odličan suplement.", 5 },
                    { 8, 1, 4, "Jako dobar.", 6 },
                    { 9, 2, 5, "Perfektan proizvod.", 7 },
                    { 10, 3, 4, "Jako dobar proizvod.", 7 },
                    { 11, 1, 3, "Dobar ukus.", 8 },
                    { 12, 2, 4, "Sve pohvale.", 8 },
                    { 13, 1, 5, "Vrhunski suplement.", 9 },
                    { 14, 1, 5, "Sve preporuke.", 10 },
                    { 15, 3, 4, "Izvrstan proizvod, okus mi se nije baš najviše dopao, idući put ću probati okus sa jagodom.", 1 },
                    { 16, 4, 5, "Jako mi se dopalo, osjetio sam promijene nakon sedmicu dana.", 1 }
                });

            migrationBuilder.InsertData(
                table: "Narudzba_Stavka",
                columns: new[] { "Narudzba_StavkaID", "Kolicina", "NarudzbaID", "SuplementID" },
                values: new object[,]
                {
                    { 1, 2, 1, 1 },
                    { 2, 1, 1, 4 },
                    { 3, 2, 2, 3 },
                    { 4, 3, 2, 9 },
                    { 5, 2, 3, 11 },
                    { 6, 1, 4, 16 },
                    { 7, 1, 4, 7 },
                    { 8, 2, 5, 2 },
                    { 9, 1, 5, 8 },
                    { 10, 6, 6, 20 },
                    { 11, 1, 6, 21 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_GradID",
                table: "Korisnik",
                column: "GradID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_SpolID",
                table: "Korisnik",
                column: "SpolID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Clanarina_ClanarinaID",
                table: "Korisnik_Clanarina",
                column: "ClanarinaID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Clanarina_KorisnikID",
                table: "Korisnik_Clanarina",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Nutricionst_KorisnikID",
                table: "Korisnik_Nutricionst",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Nutricionst_NutricionistID",
                table: "Korisnik_Nutricionst",
                column: "NutricionistID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Trener_KorisnikID",
                table: "Korisnik_Trener",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Trener_TrenerID",
                table: "Korisnik_Trener",
                column: "TrenerID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Uloga_KorisnikID",
                table: "Korisnik_Uloga",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_Uloga_UlogaID",
                table: "Korisnik_Uloga",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_KorisnikID",
                table: "Narudzba",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_Stavka_NarudzbaID",
                table: "Narudzba_Stavka",
                column: "NarudzbaID");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_Stavka_SuplementID",
                table: "Narudzba_Stavka",
                column: "SuplementID");

            migrationBuilder.CreateIndex(
                name: "IX_Nutricionist_Seminar_NutricionistID",
                table: "Nutricionist_Seminar",
                column: "NutricionistID");

            migrationBuilder.CreateIndex(
                name: "IX_Nutricionist_Seminar_SeminarID",
                table: "Nutricionist_Seminar",
                column: "SeminarID");

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_KorisnikID",
                table: "Prisustvo",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_KorisnikID",
                table: "Recenzija",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_SuplementID",
                table: "Recenzija",
                column: "SuplementID");

            migrationBuilder.CreateIndex(
                name: "IX_Suplement_DobavljacID",
                table: "Suplement",
                column: "DobavljacID");

            migrationBuilder.CreateIndex(
                name: "IX_Suplement_KategorijaID",
                table: "Suplement",
                column: "KategorijaID");

            migrationBuilder.CreateIndex(
                name: "IX_Trener_Seminar_SeminarID",
                table: "Trener_Seminar",
                column: "SeminarID");

            migrationBuilder.CreateIndex(
                name: "IX_Trener_Seminar_TrenerID",
                table: "Trener_Seminar",
                column: "TrenerID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FAQ");

            migrationBuilder.DropTable(
                name: "Korisnik_Clanarina");

            migrationBuilder.DropTable(
                name: "Korisnik_Nutricionst");

            migrationBuilder.DropTable(
                name: "Korisnik_Trener");

            migrationBuilder.DropTable(
                name: "Korisnik_Uloga");

            migrationBuilder.DropTable(
                name: "Narudzba_Stavka");

            migrationBuilder.DropTable(
                name: "Nutricionist_Seminar");

            migrationBuilder.DropTable(
                name: "Prisustvo");

            migrationBuilder.DropTable(
                name: "Recenzija");

            migrationBuilder.DropTable(
                name: "Trener_Seminar");

            migrationBuilder.DropTable(
                name: "Clanarina");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Narudzba");

            migrationBuilder.DropTable(
                name: "Nutricionist");

            migrationBuilder.DropTable(
                name: "Suplement");

            migrationBuilder.DropTable(
                name: "Seminar");

            migrationBuilder.DropTable(
                name: "Trener");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Dobavljac");

            migrationBuilder.DropTable(
                name: "Kategorija");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Spol");
        }
    }
}
