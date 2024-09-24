using IronVault.Model.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;


namespace IronVault.Services.Database
{
    partial class GmsDbContext
    {


        partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {

            // Gradovi

            modelBuilder.Entity<Grad>().HasData(
    new Grad { GradId = 1, Naziv = "Banja Luka" },
    new Grad { GradId = 2, Naziv = "Bihać" },
    new Grad { GradId = 3, Naziv = "Bijeljina" },
    new Grad { GradId = 4, Naziv = "Bosnaska Krupa" },
    new Grad { GradId = 5, Naziv = "Cazin" },
    new Grad { GradId = 6, Naziv = "Čapljina" },
    new Grad { GradId = 7, Naziv = "Drventa" },
    new Grad { GradId = 8, Naziv = "Doboj" },
    new Grad { GradId = 9, Naziv = "Goražde" },
    new Grad { GradId = 10, Naziv = "Gračanica" },
    new Grad { GradId = 11, Naziv = "Gradačac" },
    new Grad { GradId = 12, Naziv = "Gradiška" },
    new Grad { GradId = 13, Naziv = "Konjic" },
    new Grad { GradId = 14, Naziv = "Laktaši" },
    new Grad { GradId = 15, Naziv = "Livno" },
    new Grad { GradId = 16, Naziv = "Lukavac" },
    new Grad { GradId = 17, Naziv = "Ljubuški" },
    new Grad { GradId = 18, Naziv = "Mostar" },
    new Grad { GradId = 19, Naziv = "Orašje" },
    new Grad { GradId = 20, Naziv = "Prijedor" },
    new Grad { GradId = 21, Naziv = "Prnjavor" },
    new Grad { GradId = 22, Naziv = "Sarajevo" },
    new Grad { GradId = 23, Naziv = "Srebrenik" },
    new Grad { GradId = 24, Naziv = "Stolac" },
    new Grad { GradId = 25, Naziv = "Široki Brijeg" },
    new Grad { GradId = 26, Naziv = "Travnik" },
    new Grad { GradId = 27, Naziv = "Tuzla" },
    new Grad { GradId = 28, Naziv = "Visoko" },
    new Grad { GradId = 29, Naziv = "Zavidovići" },
    new Grad { GradId = 30, Naziv = "Zenica" },
    new Grad { GradId = 31, Naziv = "Zvornik" },
    new Grad { GradId = 32, Naziv = "Živinice" },
    new Grad { GradId = 33, Naziv = "Donji Vakuf" },
    new Grad { GradId = 34, Naziv = "Zavidovići" }
);

            // Faq

            modelBuilder.Entity<Faq>().HasData(
    new Faq
    {
        Faqid = 1,
        Pitanje = "Kako mogu zakazati termin kod trenera ili nutricioniste?",
        Odgovor = "Zakazivanje termina vršite klikom 'Zakaži termin' u sekciji trenera ili nutricionista. Nakon zakazivanja termina trenera/nutricioniste isti će biti obavješten mail-om nakon čega će vam se on/ona javiti na prijavljeni e-mail ili broj telefona."
    },
    new Faq
    {
        Faqid = 2,
        Pitanje = "Kako mogu naručiti suplement sa vaše aplikacije?",
        Odgovor = "Naručivanje suplemenata vrište klikom 'Dodaj u korpu' u sekciji suplementi gdje se odabrani proizvodi prebacuju u sekciju korpa, nakon dodavanja odabranih suplemenata klikom na 'Kupi' u sekciji korpa ćete biti prebačeni u stripe servis gdje možete izvršiti kupovinu."
    },
    new Faq
    {
        Faqid = 3,
        Pitanje = "Kako mogu ocjeniti suplement?",
        Odgovor = "Recenzije suplemenata možete izvršiti samo nakon kupovine istog suplementa. Nakon kupovine suplementa, isti možete naći u sekciji 'Profil', gdje vam se nudi mogućnost ocjenjivanja suplementa ocjenom od 1 do 5, zajedno sa mogućnošću ostavljanja komentara na svoju ocjenu."
    },
    new Faq
    {
        Faqid = 4,
        Pitanje = "Kako mogu povećati razinu svog profila?",
        Odgovor = "Razinu povećavate svakih 10 sati provednih u teretani. Veća razina ne samo da govori o većem ličnom progresu nego povećavate svoje šanse za ostvarivanjem bonus nagrada poput besplatnih suplemenata, personalnih termina kod naših trenera i sl."
    },
    new Faq
    {
        Faqid = 5,
        Pitanje = "Gdje mogu viditi podatke o personalnom napretku?",
        Odgovor = "Sve informacije o svom profilu, zajedno sa razinom, vremenom provedenom u teretani, listi uplaćenih članarina, kupovina možete naći u sekciji 'Profil'."
    }
);
            // Clanarine


            modelBuilder.Entity<Clanarina>().HasData(
    new Clanarina
    {
        ClanarinaId = 1,
        Naziv = "Fit Plus",
        Cijena = 50,
        Opis = "Teretane predstavljaju oazu zdravlja pružajući nam prostor gdje možemo ojačati svoje tijelo i smanjiti stres. Članstvo u teretani nije samo ulaganje u tjelesno zdravlje već i putovanje prema boljoj verziji sebe."
    },
    new Clanarina
    {
        ClanarinaId = 2,
        Naziv = "Student Fit Plus",
        Cijena = 40,
        Opis = "Studentska članarina u teretani nije samo investicija u tjelesno zdravlje, već i u opću dobrobit studenata. Zahvaljujući ovim povlasticama, teretane postaju pristupačne za studente svih financijskih mogućnosti, čime se stvara zdraviji i sretniji studentski život. Zbog toga mi nudimo popust od čak 20% za sve studente!"
    },
    new Clanarina
    {
        ClanarinaId = 3,
        Naziv = "Partner Fit Duo",
        Cijena = 25,
        Opis = "Teretane nude posebne članarine za parove koje omogućuju partnerima da zajedno uživaju u prednostima vježbanja. Podijelite iznos jedne članarine i uživajte u jačanju tijela i uma!"
    }
);


            // Dobavljaci


            modelBuilder.Entity<Dobavljac>().HasData(
    new Dobavljac
    {
        DobavljacId = 1,
        Naziv = "MUSCLE FREAK"
    },
    new Dobavljac
    {
        DobavljacId = 2,
        Naziv = "MUSCLETECH"
    },
    new Dobavljac
    {
        DobavljacId = 3,
        Naziv = "OPTIMUM NUTRITION"
    },
    new Dobavljac
    {
        DobavljacId = 4,
        Naziv = "SELF OMNINUTRITION"
    },
    new Dobavljac
    {
        DobavljacId = 5,
        Naziv = "CW-CHEMICAL WARFARE"
    },
    new Dobavljac
    {
        DobavljacId = 6,
        Naziv = "BSN"
    },
    new Dobavljac
    {
        DobavljacId = 7,
        Naziv = "CELLUCOR"
    },
    new Dobavljac
    {
        DobavljacId = 8,
        Naziv = "EVOLITE"
    },
    new Dobavljac
    {
        DobavljacId = 9,
        Naziv = "SUPERIOR"
    },
    new Dobavljac
    {
        DobavljacId = 10,
        Naziv = "TESLA"
    }
);


            // Kategorija 



            modelBuilder.Entity<Kategorija>().HasData(
    new Kategorija
    {
        KategorijaId = 1,
        Naziv = "Proteini"
    },
    new Kategorija
    {
        KategorijaId = 2,
        Naziv = "Amino kiseline"
    },
    new Kategorija
    {
        KategorijaId = 3,
        Naziv = "Preworkout"
    },
    new Kategorija
    {
        KategorijaId = 4,
        Naziv = "Mass gaineri"
    }
);

            // Seminari



            modelBuilder.Entity<Seminar>().HasData(
    new Seminar
    {
        SeminarId = 1,
        Tema = "Metabolički Sindrom",
        Predavac = "Maja Gradinjan",
        Datum = new DateTime(2022, 12, 10, 9, 15, 0)
    },
    new Seminar
    {
        SeminarId = 2,
        Tema = "Pravilna prehrana u službi zdravlja i sportskog razvoja",
        Predavac = "Darija Topić",
        Datum = new DateTime(2023, 04, 12, 9, 15, 0)
    },
    new Seminar
    {
        SeminarId = 3,
        Tema = "Snaga u vama",
        Predavac = "Tatjana Popović",
        Datum = new DateTime(2020, 01, 10, 9, 15, 0)
    },
    new Seminar
    {
        SeminarId = 4,
        Tema = "CrossFit Level 3",
        Predavac = "Ivan Račić",
        Datum = new DateTime(2019, 12, 10, 9, 15, 0)
    },
    new Seminar
    {
        SeminarId = 5,
        Tema = "Pro Bodybuilding",
        Predavac = "Petar Klančir",
        Datum = new DateTime(2017, 06, 10, 9, 15, 0)
    },
    new Seminar
    {
        SeminarId = 6,
        Tema = "Samoodbrana",
        Predavac = "Almir Tunić",
        Datum = new DateTime(2022, 01, 01, 12, 15, 0)
    }
);

            // Spolovi

            modelBuilder.Entity<Spol>().HasData(
    new Spol
    {
        SpolId = 1,
        Naziv = "Muški"
    },
    new Spol
    {
        SpolId = 2,
        Naziv = "Ženski"
    }
);

            // Uloge

            modelBuilder.Entity<Uloga>().HasData(
                 new Uloga
                 {
                     UlogaId = 1,
                     Naziv = "Administrator",
                     Opis = "Administrator ima sve permisije na aplikaciji."
                 },
                 new Uloga
                 {
                     UlogaId = 2,
                     Naziv = "User",
                     Opis = "User ima samo korisničke permisije."
                 });


            // Korisnici


            modelBuilder.Entity<Korisnik>().HasData(
                new Korisnik
                {
                    KorisnikId = 1,
                    Ime = "Vedad",
                    Prezime = "Keskin",
                    KorisnickoIme = "desktop",
                    Email = "ironvault.test@gmail.com",
                    LozinkaHash = "/sQWOxvpzqUJK7grzQGsN5yX0LI=",
                    LozinkaSalt = "BmclnyHeY8muqOn8CgWyCQ==",
                    BrojTelefona = "0644076290",
                    Visina = 170,
                    Tezina = 80,
                    Razina = 3,
                    VrijemeUteretani = "0 dana, 21 sati i 0 minuta",
                    SpolId = 1,
                    GradId = 18,
                    Slika = ConvertImageToByteArray("wwwroot", "1kor.jpg"),
                    SatiUteretani = 21
                },
                new Korisnik
                {
                    KorisnikId = 2,
                    Ime = "Amel",
                    Prezime = "Musić",
                    KorisnickoIme = "mobile",
                    Email = "ironvault.test@gmail.com",
                    LozinkaHash = "BsBZhuf6khxcsMiKOfkf8i6YCFY=",
                    LozinkaSalt = "MsAOOfOrEjMn6UE18MK0DQ==",
                    BrojTelefona = "062709689",
                    Visina = 185,
                    Tezina = 82,
                    Razina = 2,
                    VrijemeUteretani = "0 dana, 12 sati i 0 minuta",
                    SpolId = 1,
                    GradId = 33,
                    Slika = ConvertImageToByteArray("wwwroot", "2kor.jpg"),
                    SatiUteretani = 12
                },
                new Korisnik
                {
                    KorisnikId = 3,
                    Ime = "Denis",
                    Prezime = "Mušić",
                    KorisnickoIme = "denism",
                    Email = "ironvault.test@gmail.com",
                    LozinkaHash = "2Kfy1C0XBFtOApv4hlUaEQH4aqs=",
                    LozinkaSalt = "QLSAf12F9XkD+4ZLEFZz+w==",
                    BrojTelefona = "061000000",
                    Visina = 186,
                    Tezina = 83,
                    Razina = 1,
                    SpolId = 1,
                    GradId = 18,
                    Slika = ConvertImageToByteArray("wwwroot", "3kor.jpg"),
                    SatiUteretani = 0
                }


                );

            // Treneri


            modelBuilder.Entity<Trener>().HasData(
                 new Trener
                 {
                     TrenerId = 1,
                     Ime = "Kadir",
                     Prezime = "Keskin",
                     Email = "ironvault.test@gmail.com",
                     BrojTelefona = "0644076290",
                     Slika = ConvertImageToByteArray("wwwroot", "1tre.jpg")
                 },
                 new Trener
                 {
                     TrenerId = 2,
                     Ime = "Azur",
                     Prezime = "Kahriman",
                     Email = "ironvault.test@gmail.com",
                     BrojTelefona = "0644076290",
                     Slika = ConvertImageToByteArray("wwwroot", "2tre.jpg")
                 });

            // Nutricionisti 


            modelBuilder.Entity<Nutricionist>().HasData(
              new Nutricionist
              {
                  NutricionistId = 1,
                  Ime = "Marijana",
                  Prezime = "Zubac",
                  Email = "ironvault.test@gmail.com",
                  BrojTelefona = "062709689",
                  Slika = ConvertImageToByteArray("wwwroot", "1nut.jpg")
              },
              new Nutricionist
              {
                  NutricionistId = 2,
                  Ime = "Amela",
                  Prezime = "Ivković",
                  Email = "ironvault.test@gmail.com",
                  BrojTelefona = "062709689",
                  Slika = ConvertImageToByteArray("wwwroot", "2nut.jpg")
              });


            // Suplementi


            modelBuilder.Entity<Suplement>().HasData(
new Suplement
{
    SuplementId = 1,
    Naziv = "100% Whey Protein",
    Gramaza = 2500,
    Cijena = 139,
    Opis = "Muscle Freak 100% Isolate Whey Protein je visokokvalitetni izolat proteina sirutke, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.",
    KategorijaId = 1,
    DobavljacId = 1,
    StateMachine = "active",
    ProsjecnaOcjena = 4.5,
    Slika = ConvertImageToByteArray("wwwroot", "1sup.jpg")
},
new Suplement
{
    SuplementId = 2,
    Naziv = "Gold 100% Casein",
    Gramaza = 809,
    Cijena = 99,
    Opis = "Korištenjem samo vrhunskog kazeina kao izvora proteina u svom 100% Gold Standard Casein-u, Optimum Nutrition je stvorio formulu koja postavlja standard za sve sporootpuštajuće proteine.",
    KategorijaId = 1,
    DobavljacId = 3,
    StateMachine = "active",
    ProsjecnaOcjena = 3.5,
    Slika = ConvertImageToByteArray("wwwroot", "2sup.jpg")
},
new Suplement
{
    SuplementId = 3,
    Naziv = "Nitro-Tech Ripped",
    Gramaza = 900,
    Cijena = 89,
    Opis = "NITRO-TECH RIPPED™ je najnovija inovacija iz MuscleTech-a, branda koji oduševljava svojim proizvodima više od 20 godina. Ova napredna formula kombinuje proteinske peptide najviše kvalitete i izolat sa naučno testiranim sastojcima za gubitak težine. Ova 7 u 1 formula također sadrži CLA, trigliceride srednjeg lanca (MCT), L-carnitine L-tartrate, ekstrakt zelenog čaja, ekstrakt šipka i prah algi. MuscleTech® je napravio ovu jedinstvenu formula s ciljem objedinjavanja ultra-čistog proteina i gubitka težine - ovakvo nešto niste nikad prije vidjeli. Za razliku od konkurencije, svaka mjerica NITRO-TECH RIPPED™ sadrži naučno proučavanu dozu ključnih sastojaka za gubitak težine, C. canephora robusta, koja je potvrđena od strane dvije naučne studije i u čije rezultate ne morate sumnjati! Također, nevjerovatnog je okusa koji će Vas oduševiti!",
    KategorijaId = 1,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 1,
    Slika = ConvertImageToByteArray("wwwroot", "3sup.jpg")
},
new Suplement
{
    SuplementId = 4,
    Naziv = "Amino Build",
    Gramaza = 400,
    Cijena = 75,
    Opis = "Napunjene sa gradivnim elementima kako bi podržale brz oporavak. Imajući u vidu da su BCAA kao osnova u sastavu, ubrzat će period oporavka poslije treninga.",
    KategorijaId = 2,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 4,
    Slika = ConvertImageToByteArray("wwwroot", "4sup.jpg")
},
new Suplement
{

    SuplementId = 5,
    Naziv = "Cell Tech Elite",
    Gramaza = 594,
    Cijena = 85,
    Opis = "Cell Tech Elite je visoko potentna formula koja pruža vrhunsku dozu od 5 g kreatinske matrice, koja uključuje kreatin monohidrat i kreatin hidroklorid. Osim toga, ova formula sadrži klinički dokazanu dozu od 400 mg Peak ATP-a, koji omogućava povećanje snage i veći broj ponavljanja u treningu. U kliničkoj studiji je dokazano da su ispitanici koji su koristili Peak ATP izgradili 90% više mišića u poređenju sa placebom, postižući impresivne rezultate u roku od 12 sedmica intenzivnog treninga.",
    KategorijaId = 2,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 5,
    Slika = ConvertImageToByteArray("wwwroot", "5sup.jpg")
},
new Suplement
{
    SuplementId = 6,
    Naziv = "N.O.-Xplode Vaso",
    Gramaza = 420,
    Cijena = 85,
    Opis = "Izgradnja mišića zahtijeva pravilnu ishranu i treninge. Mnogi suplementi prije treninga mogu pružiti energiju i fokus, ali rijetko isporučuju onu pravu \"pumpu\" koju tražite. Ali sada je vaša potraga gotova zahvaljujući N.O.-XPLODE VASO!",
    KategorijaId = 3,
    DobavljacId = 2,
    ProsjecnaOcjena = 4,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "6sup.jpg")
},
new Suplement
{
    SuplementId = 7,
    Naziv = "C4 Ultimate",
    Gramaza = 410,
    Cijena = 85,
    Opis = "Cellucor C4 Ultimate je dugi niz godina usavršavao pre-workoute, mnogo prije nego neki drugi brendovi u industriji sportskih suplemenata. Gotovo desetljeće brend C4® bio je prvi u kategoriji pre-workouta sa učinkom i eksplozivnom energijom, najboljim okusima, klinički proučenim sastojcima i vrhunskim formulama.",
    KategorijaId = 3,
    DobavljacId = 7,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "7sup.jpg")
},
new Suplement
{
    SuplementId = 8,
    Naziv = "C4 Ripped",
    Gramaza = 180,
    Cijena = 65,
    Opis = "C4 Ripped sadrži sličnu energetsku mješavinu kao i klasični C4, s ključnim sastojcima za energiju koji će vam pomoći da prođete kroz najteže vježbe.",
    KategorijaId = 3,
    DobavljacId = 7,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "8sup.jpg")

}
);











            // Korisnik Clanarine

            modelBuilder.Entity<KorisnikClanarina>().HasData(
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 1,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2023, 09, 01, 9, 15, 0),
        DatumIsteka = new DateTime(2023, 10, 01, 9, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 2,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2023, 10, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2023, 11, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 3,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2023, 11, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2023, 12, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 4,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2023, 12, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 01, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 5,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 01, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 02, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 6,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 02, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 03, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 7,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 04, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 05, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 8,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 05, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 06, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 9,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 06, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 07, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 10,
        KorisnikId = 1,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 07, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 08, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 11,
        KorisnikId = 2,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 06, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 07, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 12,
        KorisnikId = 2,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 07, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 08, 01, 7, 15, 0)
    },
    new KorisnikClanarina
    {
        KorisnikClanarinaId = 13,
        KorisnikId = 2,
        ClanarinaId = 2,
        DatumUplate = new DateTime(2024, 08, 01, 7, 15, 0),
        DatumIsteka = new DateTime(2024, 09, 01, 7, 15, 0)
    }
);

            // Korisnik Uloga


            modelBuilder.Entity<KorisnikUloga>().HasData(
            new KorisnikUloga
            {
                KorisnikUlogaId = 1,
                KorisnikId = 1,
                UlogaId = 1,
                DatumIzmjene = new DateTime(2023, 10, 01, 7, 15, 0),
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 2,
                KorisnikId = 1,
                UlogaId = 2,
                DatumIzmjene = new DateTime(2023, 10, 01, 7, 15, 0),
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 3,
                KorisnikId = 2,
                UlogaId = 1,
                DatumIzmjene = new DateTime(2023, 10, 01, 7, 15, 0),
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 4,
                KorisnikId = 2,
                UlogaId = 2,
                DatumIzmjene = new DateTime(2023, 10, 01, 7, 15, 0),
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 5,
                KorisnikId = 3,
                UlogaId = 2,
                DatumIzmjene = new DateTime(2023, 10, 01, 7, 15, 0),
            }
        );



            // Narudzbe 


            modelBuilder.Entity<Narudzba>().HasData(
        new Narudzba
        {
            NarudzbaId = 1,
            KorisnikId = 1,
            Sifra = "SIF-000-001",
            DatumVrijemeNarudzbe = new DateTime(2023, 09, 01, 9, 15, 0),
            Otkazano = false,
            Status = false
        },
        new Narudzba
        {
            NarudzbaId = 2,
            KorisnikId = 2,
            Sifra = "SIF-000-002",
            DatumVrijemeNarudzbe = new DateTime(2023, 10, 01, 9, 15, 0),
            Otkazano = false,
            Status = false
        },
        new Narudzba
        {
            NarudzbaId = 3,
            KorisnikId = 1,
            Sifra = "SIF-000-003",
            DatumVrijemeNarudzbe = new DateTime(2023, 10, 04, 9, 15, 0),
            Otkazano = false,
            Status = false
        },
        new Narudzba
        {
            NarudzbaId = 4,
            KorisnikId = 2,
            Sifra = "SIF-000-004",
            DatumVrijemeNarudzbe = new DateTime(2023, 10, 09, 9, 15, 0),
            Otkazano = true,
            Status = false
        },
        new Narudzba
        {
            NarudzbaId = 5,
            KorisnikId = 1,
            Sifra = "SIF-000-005",
            DatumVrijemeNarudzbe = new DateTime(2023, 11, 07, 9, 15, 0),
            Otkazano = false,
            Status = false
        }
        ,
        new Narudzba
        {
            NarudzbaId = 6,
            KorisnikId = 3,
            Sifra = "SIF-000-006",
            DatumVrijemeNarudzbe = new DateTime(2024, 08, 08, 9, 15, 0),
            Otkazano = false,
            Status = false
        }
    );

            // NarudzbeStavke 


            modelBuilder.Entity<NarudzbaStavka>().HasData(
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 1,
               NarudzbaId = 1,
               SuplementId = 1,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 2,
               NarudzbaId = 1,
               SuplementId = 4,
               Kolicina = 1
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 3,
               NarudzbaId = 2,
               SuplementId = 3,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 4,
               NarudzbaId = 2,
               SuplementId = 4,
               Kolicina = 3
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 5,
               NarudzbaId = 3,
               SuplementId = 8,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 6,
               NarudzbaId = 4,
               SuplementId = 3,
               Kolicina = 1
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 7,
               NarudzbaId = 4,
               SuplementId = 8,
               Kolicina = 1
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 8,
               NarudzbaId = 5,
               SuplementId = 8,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 9,
               NarudzbaId = 5,
               SuplementId = 7,
               Kolicina = 1
           }
           ,
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 10,
               NarudzbaId = 6,
               SuplementId = 8,
               Kolicina = 6
           }
           ,
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 11,
               NarudzbaId = 6,
               SuplementId = 2,
               Kolicina = 1
           }
       );

            // Nutricionist Seminar


            modelBuilder.Entity<NutricionistSeminar>().HasData(
            new NutricionistSeminar
            {
                NutricionistSeminarId = 1,
                NutricionistId = 1,
                SeminarId = 2
            },
            new NutricionistSeminar
            {
                NutricionistSeminarId = 2,
                NutricionistId = 1,
                SeminarId = 3
            },
            new NutricionistSeminar
            {
                NutricionistSeminarId = 3,
                NutricionistId = 2,
                SeminarId = 1
            },
            new NutricionistSeminar
            {
                NutricionistSeminarId = 4,
                NutricionistId = 2,
                SeminarId = 3
            }
        );


            // TrenerSeminari

            modelBuilder.Entity<TrenerSeminar>().HasData(
           new TrenerSeminar
           {
               TrenerSeminarId = 1,
               TrenerId = 1,
               SeminarId = 5
           },
           new TrenerSeminar
           {
               TrenerSeminarId = 2,
               TrenerId = 1,
               SeminarId = 6
           },
           new TrenerSeminar
           {
               TrenerSeminarId = 3,
               TrenerId = 2,
               SeminarId = 4
           },
           new TrenerSeminar
           {
               TrenerSeminarId = 4,
               TrenerId = 2,
               SeminarId = 6
           }
       );

            // Prisustva

            modelBuilder.Entity<Prisustvo>().HasData(
           new Prisustvo
           {
               PrisustvoId = 1,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 03, 03, 18, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 03, 03, 19, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 2,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 03, 05, 20, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 03, 05, 21, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 3,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 03, 08, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 03, 08, 21, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 4,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 07, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 07, 21, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 5,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 09, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 09, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 6,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 13, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 13, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 7,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 16, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 16, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 8,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 21, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 21, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 9,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 04, 25, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 25, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 10,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 04, 26, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 26, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 11,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 04, 29, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 04, 29, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 12,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 05, 03, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 05, 03, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 13,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 05, 09, 19, 0, 0),
               DatumVrijemeIzlaska = new DateTime(2024, 05, 09, 22, 0, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 14,
               KorisnikId = 1,
               DatumVrijemeUlaska = new DateTime(2024, 09, 22, 20, 52, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 15,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 09, 22, 21, 22, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 16,
               KorisnikId = 3,
               DatumVrijemeUlaska = new DateTime(2024, 09, 22, 17, 12, 0),
           }
       );


            // Recenzije


            modelBuilder.Entity<Recenzija>().HasData(
           new Recenzija
           {
               RecenzijaId = 1,
               KorisnikId = 1,
               SuplementId = 1,
               Ocjena = 5,
               Opis = "Prozivod mi je mnogo pomogao, tople preporuke."
           },
           new Recenzija
           {
               RecenzijaId = 2,
               KorisnikId = 2,
               SuplementId = 1,
               Ocjena = 4,
               Opis = "Dobar proizvod, samo je dostava trajala duže od dogovorenog."
           },
           new Recenzija
           {
               RecenzijaId = 3,
               KorisnikId = 1,
               SuplementId = 2,
               Ocjena = 5,
               Opis = "Odličan proizvod."
           },
           new Recenzija
           {
               RecenzijaId = 4,
               KorisnikId = 2,
               SuplementId = 2,
               Ocjena = 2,
               Opis = "Loš ukus."
           },
           new Recenzija
           {
               RecenzijaId = 5,
               KorisnikId = 3,
               SuplementId = 3,
               Ocjena = 1,
               Opis = "Katastrofa."
           },
           new Recenzija
           {
               RecenzijaId = 6,
               KorisnikId = 1,
               SuplementId = 4,
               Ocjena = 4,
               Opis = "Ukus nije baš najbolji ali je progres očigledan."
           },
           new Recenzija
           {
               RecenzijaId = 7,
               KorisnikId = 3,
               SuplementId = 5,
               Ocjena = 5,
               Opis = "Odličan suplement."
           },
           new Recenzija
           {
               RecenzijaId = 8,
               KorisnikId = 1,
               SuplementId = 6,
               Ocjena = 4,
               Opis = "Jako dobar."
           }
         
       );


            // 







        }








        public static byte[] HexToByteArray(string hex)
        {
            hex = hex.Replace("0x", "");
            byte[] bytes = new byte[hex.Length / 2];
            for (int i = 0; i < bytes.Length; i++)
            {
                bytes[i] = Convert.ToByte(hex.Substring(i * 2, 2), 16);
            }
            return bytes;
        }


        private string ConvertImageToBase64String(string folder, string imageName)
        {
            string currentDirectory = Directory.GetCurrentDirectory();
            string imagePath = Path.Combine(currentDirectory, folder, imageName);




            try
            {
                if (File.Exists(imagePath))
                {
                    byte[] imageBytes = File.ReadAllBytes(imagePath);
                    return Convert.ToBase64String(imageBytes);
                }
                else
                {
                    Console.WriteLine("Image file not found.");
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading image file: {ex.Message}");
                return null;
            }
        }



        private byte[] ConvertImageToByteArray(string folder, string imageName)
        {
            string currentDirectory = Directory.GetCurrentDirectory();
            string imagePath = Path.Combine(currentDirectory, folder, imageName);


            try
            {
                if (File.Exists(imagePath))
                {
                    return File.ReadAllBytes(imagePath);
                }
                else
                {
                    Console.WriteLine("Image file not found.");
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading image file: {ex.Message}");
                return null;
            }
        }






    }
}