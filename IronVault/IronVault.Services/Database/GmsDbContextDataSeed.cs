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
        Pitanje = "Koja je cijena članarina u vašoj teretani?",
        Odgovor = "Cijene mjesečnih članarina variraju ovisno o paketu koji odaberete. Imamo različite opcije prilagođene različitim potrebama i budžetima. Detaljne informacije o cijenama možete pronaći na recepciji naše teretane."
    },
    new Faq
    {
        Faqid = 2,
        Pitanje = "Da li u sklopu teretane imate personalne trenere?",
        Odgovor = "Da, imamo stručne trenere koji vam mogu pomoći u postizanju vaših fitness ciljeva. Oni će raditi s vama kako bi razvili personalizirani plan vježbanja. Pored njih, imamo i naš tim nutricionista."
    },
    new Faq
    {
        Faqid = 3,
        Pitanje = "Kako da postanem član vaše teretane?",
        Odgovor = "Vrlo jednostavno! Posjetite našu recepciju, odaberite željeni paket i dobit ćete svoju člansku karticu!"
    },
    new Faq
    {
        Faqid = 4,
        Pitanje = "Kako da povećam svoju razinu?",
        Odgovor = "Razinu povećavate na sljedeću razinu svakih 10 sati provedenih u teretani."
    },
    new Faq
    {
        Faqid = 5,
        Pitanje = "Kako izvršiti kupovinu suplemenata?",
        Odgovor = "Kupovinu suplemenata izvršavate klikom naruči preko Stripe servisa, nakon kojeg dobijete potvrdu kupovine na mail."
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
                    Email = "vedad.keskin98@gmail.com",
                    LozinkaHash = "/sQWOxvpzqUJK7grzQGsN5yX0LI=",
                    LozinkaSalt = "BmclnyHeY8muqOn8CgWyCQ==",
                    BrojTelefona = "0644076290",
                    Visina = 170,
                    Tezina = 80,
                    Razina = 3,
                    VrijemeUteretani = "0 dana, 21 sati i 0 minuta",
                    SpolId = 1,
                    GradId = 18,
                    Slika = ConvertImageToByteArray("wwwroot", "1kor.jpg")
                },
                new Korisnik
                {
                    KorisnikId = 2,
                    Ime = "Amel",
                    Prezime = "Musić",
                    KorisnickoIme = "mobile",
                    Email = "vedad.keskin98@gmail.com",
                    LozinkaHash = "BsBZhuf6khxcsMiKOfkf8i6YCFY=",
                    LozinkaSalt = "MsAOOfOrEjMn6UE18MK0DQ==",
                    BrojTelefona = "062709689",
                    Visina = 185,
                    Tezina = 82,
                    Razina = 2,
                    VrijemeUteretani = "0 dana, 12 sati i 0 minuta",
                    SpolId = 1,
                    GradId = 33,
                    Slika = ConvertImageToByteArray("wwwroot", "2kor.jpg")
                },
                new Korisnik
                {
                    KorisnikId = 3,
                    Ime = "Denis",
                    Prezime = "Mušić",
                    KorisnickoIme = "denism",
                    Email = "vedad.keskin98@gmail.com",
                    LozinkaHash = "2Kfy1C0XBFtOApv4hlUaEQH4aqs=",
                    LozinkaSalt = "QLSAf12F9XkD+4ZLEFZz+w==",
                    BrojTelefona = "061000000",
                    Visina = 186,
                    Tezina = 83,
                    Razina = 1,
                    SpolId = 1,
                    GradId = 18,
                    Slika = ConvertImageToByteArray("wwwroot", "3kor.jpg")
                },
                new Korisnik
                {
                    KorisnikId = 4,
                    Ime = "Elmir",
                    Prezime = "Babović",
                    KorisnickoIme = "elmirb",
                    Email = "vedad.keskin98@gmail.com",
                    LozinkaHash = "1wrfyYURG83rXcpYOK7LxbASzxY=",
                    LozinkaSalt = "gu5g9kJouJlB19/DNtCtaw==",
                    BrojTelefona = "062000000",
                    Visina = 189,
                    Tezina = 86,
                    Razina = 1,
                    SpolId = 1,
                    GradId = 34,
                    Slika = ConvertImageToByteArray("wwwroot", "4kor.jpg")
                }



                );

            // Treneri


            modelBuilder.Entity<Trener>().HasData(
                 new Trener
                 {
                     TrenerId = 1,
                     Ime = "Kadir",
                     Prezime = "Keskin",
                     Email = "vedad.keskin98@gmail.com",
                     BrojTelefona = "0644076290",
                     Slika = ConvertImageToByteArray("wwwroot", "1tre.jpg")
                 },
                 new Trener
                 {
                     TrenerId = 2,
                     Ime = "Azur",
                     Prezime = "Kahriman",
                     Email = "vedad.keskin98@gmail.com",
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
                  Email = "vedad.keskin98@gmail.com",
                  BrojTelefona = "062709689",
                  Slika = ConvertImageToByteArray("wwwroot", "1nut.jpg")
              },
              new Nutricionist
              {
                  NutricionistId = 2,
                  Ime = "Amela",
                  Prezime = "Ivković",
                  Email = "vedad.keskin98@gmail.com",
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
    Slika = ConvertImageToByteArray("wwwroot", "1sup.webp")
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
    Slika = ConvertImageToByteArray("wwwroot", "2sup.webp")
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
    Slika = ConvertImageToByteArray("wwwroot", "3sup.webp")
},
new Suplement
{
    SuplementId = 4,
    Naziv = "Nitro-Tech Whey Protein",
    Gramaza = 1800,
    Cijena = 139,
    Opis = "NITRO-TECH® je naučno istražena, pojačana proteinska formula kreirana za sve sportiste koji žele veću mišićnu masu, više snage i bolje performanse. NITRO-TECH® sadrži protein čiji primarni izvor su peptidi i izolat sirutke – dva najčistija i najkvalitetnija dostupna izvora proteina, za razliku od ostalih proteinskih suplemenata koji možda sadrže tek par gama ovih lako probavljivih i visoke biološke vrijednosti proteina. NITRO-TECH® je takođe poboljšan i sa 3g kreatin monohidrata, najistraženijim oblikom kreatina, namjenjenim za još veću mišićnu masu i snagu.",
    KategorijaId = 1,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 4,
    Slika = ConvertImageToByteArray("wwwroot", "4sup.webp")
},
new Suplement
{

    SuplementId = 5,
    Naziv = "Nitro-Tech 100% Whey",
    Gramaza = 908,
    Cijena = 89,
    Opis = "Preko 20 godina NITRO-TECH® je vodeći proteinski brend, izgrađen na temelju naučnih istraživanja i korištenja najmodernije tehnologija. Sada je isti istraživački i razvojni tim stvorio novu formulu whey proteina baziranu na superiornim izvorima proteina, kvaliteti i tehnici proizvodnje. Predstavljamo vam NITRO-TECH® 100% WHEY GOLD – čistu proteinsku formulu koja sadrži peptide i izolat sirutke.",
    KategorijaId = 1,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 5,
    Slika = ConvertImageToByteArray("wwwroot", "5sup.webp")
},
new Suplement
{
    SuplementId = 6,
    Naziv = "Platinum 8",
    Gramaza = 2000,
    Cijena = 119,
    Opis = "Vrhunska proteinska mješavina za sve namjene u bilo koje vrijeme posebno formulirana za sportiste koji žele biti na vrhuncu svoje igre. Dizajniran s visokokvalitetnom, višefaznom mješavinom proteina, može se uzimati kad god je potrebno - nakon treninga, između obroka ili prije spavanja.",
    KategorijaId = 1,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 4,
    Slika = ConvertImageToByteArray("wwwroot", "6sup.webp")
},
new Suplement
{
    SuplementId = 7,
    Naziv = "BCAA 2:1:1",
    Gramaza = 250,
    Cijena = 35,
    Opis = "Vrhunski ukusan spoj esencijalnih aminokiselina. Ovaj proizvod ne samo da pruža izvanredan ukus, već je i obogaćen esencijalnim hranjivim sastojcima poput vitamina C i vitamina B6. BCAA je kritičan faktor koji vam može pomoći da postignete najbolje iz svojih treninga.",
    KategorijaId = 2,
    DobavljacId = 4,
    StateMachine = "active",
    ProsjecnaOcjena = 4.5,
    Slika = ConvertImageToByteArray("wwwroot", "7sup.webp")
},
new Suplement
{
    SuplementId = 8,
    Naziv = "HMB",
    Gramaza = 900,
    Cijena = 45,
    Opis = "Self Omninutrition HMB (beta-hidroksi-beta-metilbutirat) je metabolit leucina koji sprečava razgradnju proteina i promoviše hipertrofiju mišića (povećanje ćelija koje grade tkivo); također smanjuje moguće povrede mišića nakon treninga visokog intenziteta, čime se smanjuje postotak masnoće u tijelu. Nedavna istraživanja su također pokazala da uzimanje HMB povećava mišićnu snagu, smanjuje simptome prekomjernog treninga te pozitivno utiče na VO2max (maksimalna potrošnja kiseonika). Neki stručnjaci smatraju da je VO2max ključni faktor u sportskim takmičenjima sportista. HMB je vrijedan dodatak ishrani za snagu, performanse i izdržljivost.",
    KategorijaId = 2,
    DobavljacId = 4,
    StateMachine = "active",
    ProsjecnaOcjena = 3.5,
    Slika = ConvertImageToByteArray("wwwroot", "8sup.webp")
},
new Suplement
{
    SuplementId = 9,
    Naziv = "Amino Build",
    Gramaza = 400,
    Cijena = 75,
    Opis = "Napunjene sa gradivnim elementima kako bi podržale brz oporavak. Imajući u vidu da su BCAA kao osnova u sastavu, ubrzat će period oporavka poslije treninga.",
    KategorijaId = 2,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 5,
    Slika = ConvertImageToByteArray("wwwroot", "9sup.webp")
},
new Suplement
{
    SuplementId = 10,
    Naziv = "Cell Tech Elite",
    Gramaza = 594,
    Cijena = 85,
    Opis = "Cell Tech Elite je visoko potentna formula koja pruža vrhunsku dozu od 5 g kreatinske matrice, koja uključuje kreatin monohidrat i kreatin hidroklorid. Osim toga, ova formula sadrži klinički dokazanu dozu od 400 mg Peak ATP-a, koji omogućava povećanje snage i veći broj ponavljanja u treningu. U kliničkoj studiji je dokazano da su ispitanici koji su koristili Peak ATP izgradili 90% više mišića u poređenju sa placebom, postižući impresivne rezultate u roku od 12 sedmica intenzivnog treninga.",
    KategorijaId = 2,
    DobavljacId = 2,
    StateMachine = "active",
    ProsjecnaOcjena = 5,
    Slika = ConvertImageToByteArray("wwwroot", "10sup.webp")
}
,
new Suplement
{
    SuplementId = 11,
    Naziv = "CW Intra Surgence",
    Gramaza = 480,
    Cijena = 85,
    Opis = "CW Intra Surgence je naučno formuliran Intra-Workout dodatak koji pruža visoko doziranu mješavinu punog spektra esencijalnih aminokiselina (EAA) i razgranatih lanaca aminokiselina (BCAA), zajedno s najnovijim hidratacijskim sastojcima i patentiranim dodacima za povećanje energije.",
    KategorijaId = 2,
    DobavljacId = 5,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "11sup.webp")
}
,
new Suplement
{
    SuplementId = 12,
    Naziv = "Amino X",
    Gramaza = 433,
    Cijena = 65,
    Opis = "Amino X je specijalna aminokiselinska formula dizajnirana da pomogne tijelu u povećanju izdržljivosti tokom treninga i mišićnom oporavku nakon treninga. Sadrži kvalitetnu anaboličku mješavinu, koja spriječava katabolizam (propadanje mišićnih vlakna) te se brine za obnovu i rast mišića.",
    KategorijaId = 2,
    DobavljacId = 6,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "12sup.webp")
}
,
new Suplement
{
    SuplementId = 13,
    Naziv = "Power Reactor",
    Gramaza = 300,
    Cijena = 65,
    Opis = "Muscle Freak Power Reactor je visokokvalitetni pre-workout, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.",
    KategorijaId = 3,
    DobavljacId = 1,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "13sup.webp")
}
,
new Suplement
{
    SuplementId = 14,
    Naziv = "N.O.-Xplode Vaso",
    Gramaza = 420,
    Cijena = 85,
    Opis = "Izgradnja mišića zahtijeva pravilnu ishranu i treninge. Mnogi suplementi prije treninga mogu pružiti energiju i fokus, ali rijetko isporučuju onu pravu \"pumpu\" koju tražite. Ali sada je vaša potraga gotova zahvaljujući N.O.-XPLODE VASO!",
    KategorijaId = 3,
    DobavljacId = 2,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "14sup.webp")
}
,
new Suplement
{
    SuplementId = 15,
    Naziv = "C4 Ultimate",
    Gramaza = 410,
    Cijena = 85,
    Opis = "Cellucor C4 Ultimate je dugi niz godina usavršavao pre-workoute, mnogo prije nego neki drugi brendovi u industriji sportskih suplemenata. Gotovo desetljeće brend C4® bio je prvi u kategoriji pre-workouta sa učinkom i eksplozivnom energijom, najboljim okusima, klinički proučenim sastojcima i vrhunskim formulama.",
    KategorijaId = 3,
    DobavljacId = 7,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "15sup.webp")
}
,
new Suplement
{
    SuplementId = 16,
    Naziv = "C4 Ripped",
    Gramaza = 180,
    Cijena = 65,
    Opis = "C4 Ripped sadrži sličnu energetsku mješavinu kao i klasični C4, s ključnim sastojcima za energiju koji će vam pomoći da prođete kroz najteže vježbe.",
    KategorijaId = 3,
    DobavljacId = 7,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "16sup.webp")
}
,
new Suplement
{
    SuplementId = 17,
    Naziv = "N.O.-Xplode",
    Gramaza = 390,
    Cijena = 69,
    Opis = "N.O.-XPLODE pomaže u održavanju mentalne budnosti i mišićne snage, donosi energiju i izdržljivost te pomaže sportistima poboljšati kapacitet na svim razinama.",
    KategorijaId = 3,
    DobavljacId = 6,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "17sup.webp")
}
,
new Suplement
{
    SuplementId = 18,
    Naziv = "Shatter",
    Gramaza = 363,
    Cijena = 69,
    Opis = "MuscleTech Shatter™ je iznimno snažan i naučno osmišljen pre-workout suplement koji će Vam doslovno razderati majicu i poboljšati vaše performanse snage i izdržljivosti. Ova vrhunska formula pruža i snažnu energiju i kompleks koji će Vas potaknuti kroz svaki trening.",
    KategorijaId = 3,
    DobavljacId = 2,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "18sup.webp")
}
,
new Suplement
{
    SuplementId = 19,
    Naziv = "Mega Mass",
    Gramaza = 1200,
    Cijena = 79,
    Opis = "Muscle Freak Mega Mass je visokokvalitetni gainer, koji smo kreirali kako bi zadovoljili potrebe i najzahtjevnijih vježbača. Nakon godina uspješnog rada i distribucije najvećih brendova na tržištu, mi u Muscle Freaku smo odlučili da je vrijeme da i naša linija proizvoda ugleda svjetlo dana i da vam u skladu s našom tradicijom ponudimo najbolje i najkvalitetnije proizvode s predznakom bosanski brend.",
    KategorijaId = 4,
    DobavljacId = 1,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "19sup.webp")
}
,
new Suplement
{
    SuplementId = 20,
    Naziv = "Mass Tech ELITE",
    Gramaza = 3200,
    Cijena = 119,
    Opis = "Mass-Tech Elite je napredni mass gainer za one koji imaju problemasa povećanjem veličine ili žele da probiju svoje platoe snage...",
    KategorijaId = 4,
    DobavljacId = 2,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "20sup.webp")
}
,
new Suplement
{
    SuplementId = 21,
    Naziv = "100% Mass Gainer",
    Gramaza = 2300,
    Cijena = 89,
    Opis = "Iz najbolje američke kompanije za prodaju suplemenata, MuscleTech predstavlja Vam 100% Mass Gainer - visokoproteinski suplement za povećanje mišične mase. Ovaj dodatak, obogaćen prirodnim i umjetnim aromama, pruža Vam sve što je potrebno da unaprijedite mišiće, snagu i performanse, uz brži oporavak mišića.",
    KategorijaId = 4,
    DobavljacId = 2,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "21sup.webp")
}
,
new Suplement
{
    SuplementId = 22,
    Naziv = "Mass Super Charger",
    Gramaza = 2270,
    Cijena = 75,
    Opis = "Tesla Mass Super Charger može pomoći vašim mišićima da rastu, zahvaljujući  ugljikohidratima iz više izvora, visokom sadržaju proteina i dodatku aminokiselina u optimalnom omjeru 2:1:1 za pomoć u iskorištavanju proteina. Kreatin je također dodat kako bi pomogao da se mišići napune vodom i potakne daljnji rast, zajedno s pažljivo odabranim vitaminskim kompleksom koji podržava sposobnost vašeg tijela da koristi proteine ​​i ugljikohidrate za energiju i čistu mišićnu masu.",
    KategorijaId = 4,
    DobavljacId = 10,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "22sup.webp")
}
,
new Suplement
{
    SuplementId = 23,
    Naziv = "IsoGainz",
    Gramaza = 1000,
    Cijena = 119,
    Opis = "Evolite IsoGainz je ugljikohidratno-proteinski suplement visoke kvalitete namijenjen prvenstveno aktivnim osobama koji se sastoji od: odabrani ugljikohidrati (maltodextrin sa jako malim sadržajem šećera) proteina (izolat I koncentrat koji ne sadrže laktozu) .Proizvod se može koristiti kao dodatak svakodnevnoj prehrani. Idealno prikladan za korištenje nakon treninga kako bi se nadoknadile zalihe energije u mišićima. Protein doprinosi rastu mišične mase I pomaže u njenom održavanju.",
    KategorijaId = 4,
    DobavljacId = 8,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "23sup.png")
}
,
new Suplement
{
    SuplementId = 24,
    Naziv = "Hyper Mass",
    Gramaza = 8000,
    Cijena = 159,
    Opis = "Hyper Mass Professional je izuzetno moćan suplement s bogatim vitaminskim kompleksom, namijenjen da vam pomogne postići vaše ciljeve u izgradnji mišića! Ovaj preparat Hyper Mass, sa svojom vrhunskom kombinacijom sastojaka, idealan je izbor za sve koji žele dodati mišićnu masu, povećati snagu i izdržljivost tokom treninga.",
    KategorijaId = 4,
    DobavljacId = 9,
    StateMachine = "active",
    Slika = ConvertImageToByteArray("wwwroot", "24sup.webp")
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
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 6,
                KorisnikId = 4,
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
               SuplementId = 9,
               Kolicina = 3
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 5,
               NarudzbaId = 3,
               SuplementId = 11,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 6,
               NarudzbaId = 4,
               SuplementId = 16,
               Kolicina = 1
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 7,
               NarudzbaId = 4,
               SuplementId = 7,
               Kolicina = 1
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 8,
               NarudzbaId = 5,
               SuplementId = 2,
               Kolicina = 2
           },
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 9,
               NarudzbaId = 5,
               SuplementId = 8,
               Kolicina = 1
           }
           ,
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 10,
               NarudzbaId = 6,
               SuplementId = 20,
               Kolicina = 6
           }
           ,
           new NarudzbaStavka
           {
               NarudzbaStavkaId = 11,
               NarudzbaId = 6,
               SuplementId = 21,
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
               DatumVrijemeUlaska = new DateTime(2024, 08, 19, 20, 52, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 15,
               KorisnikId = 2,
               DatumVrijemeUlaska = new DateTime(2024, 08, 19, 21, 22, 0),
           },
           new Prisustvo
           {
               PrisustvoId = 16,
               KorisnikId = 3,
               DatumVrijemeUlaska = new DateTime(2024, 08, 19, 17, 12, 0),
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
           },
           new Recenzija
           {
               RecenzijaId = 9,
               KorisnikId = 2,
               SuplementId = 7,
               Ocjena = 5,
               Opis = "Perfektan proizvod."
           },
           new Recenzija
           {
               RecenzijaId = 10,
               KorisnikId = 3,
               SuplementId = 7,
               Ocjena = 4,
               Opis = "Jako dobar proizvod."
           },
           new Recenzija
           {
               RecenzijaId = 11,
               KorisnikId = 1,
               SuplementId = 8,
               Ocjena = 3,
               Opis = "Dobar ukus."
           },
           new Recenzija
           {
               RecenzijaId = 12,
               KorisnikId = 2,
               SuplementId = 8,
               Ocjena = 4,
               Opis = "Sve pohvale."
           },
           new Recenzija
           {
               RecenzijaId = 13,
               KorisnikId = 1,
               SuplementId = 9,
               Ocjena = 5,
               Opis = "Vrhunski suplement."
           },
           new Recenzija
           {
               RecenzijaId = 14,
               KorisnikId = 1,
               SuplementId = 10,
               Ocjena = 5,
               Opis = "Sve preporuke."
           },
           new Recenzija
           {
               RecenzijaId = 15,
               KorisnikId = 3,
               SuplementId = 1,
               Ocjena = 4,
               Opis = "Izvrstan proizvod, okus mi se nije baš najviše dopao, idući put ću probati okus sa jagodom."
           },
           new Recenzija
           {
               RecenzijaId = 16,
               KorisnikId = 4,
               SuplementId = 1,
               Ocjena = 5,
               Opis = "Jako mi se dopalo, osjetio sam promijene nakon sedmicu dana."
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

                    Console.WriteLine($"---------------> {imagePath}");


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