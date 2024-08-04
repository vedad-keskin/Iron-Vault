using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace IronVault.Services.Database;

public partial class GmsDbContext : DbContext
{
    public GmsDbContext()
    {
    }

    public GmsDbContext(DbContextOptions<GmsDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Aktivnost> Aktivnosts { get; set; }

    public virtual DbSet<Clanarina> Clanarinas { get; set; }

    public virtual DbSet<Dobavljac> Dobavljacs { get; set; }

    public virtual DbSet<Faq> Faqs { get; set; }

    public virtual DbSet<Grad> Grads { get; set; }

    public virtual DbSet<Kategorija> Kategorijas { get; set; }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<KorisnikClanarina> KorisnikClanarinas { get; set; }

    public virtual DbSet<KorisnikNutricionst> KorisnikNutricionsts { get; set; }

    public virtual DbSet<KorisnikTrener> KorisnikTreners { get; set; }

    public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; }

    public virtual DbSet<Narudzba> Narudzbas { get; set; }

    public virtual DbSet<NarudzbaStavka> NarudzbaStavkas { get; set; }

    public virtual DbSet<Nutricionist> Nutricionists { get; set; }

    public virtual DbSet<NutricionistSeminar> NutricionistSeminars { get; set; }

    public virtual DbSet<Recenzija> Recenzijas { get; set; }

    public virtual DbSet<Seminar> Seminars { get; set; }

    public virtual DbSet<Spol> Spols { get; set; }

    public virtual DbSet<Suplement> Suplements { get; set; }

    public virtual DbSet<Teretana> Teretanas { get; set; }

    public virtual DbSet<Trener> Treners { get; set; }

    public virtual DbSet<TrenerSeminar> TrenerSeminars { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

//    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
//        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=GMS_db;Trusted_Connection=True;User ID=gms;Password=gms2023; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Aktivnost>(entity =>
        {
            entity.ToTable("Aktivnost");

            entity.HasIndex(e => e.KorisnikId, "IX_Aktivnost_KorisnikID");

            entity.HasIndex(e => e.TeretanaId, "IX_Aktivnost_TeretanaID");

            entity.Property(e => e.AktivnostId).HasColumnName("AktivnostID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.TeretanaId).HasColumnName("TeretanaID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Aktivnosts)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Teretana).WithMany(p => p.Aktivnosts)
                .HasForeignKey(d => d.TeretanaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Clanarina>(entity =>
        {
            entity.ToTable("Clanarina");

            entity.Property(e => e.ClanarinaId).HasColumnName("ClanarinaID");
        });

        modelBuilder.Entity<Dobavljac>(entity =>
        {
            entity.ToTable("Dobavljac");

            entity.Property(e => e.DobavljacId).HasColumnName("DobavljacID");
        });

        modelBuilder.Entity<Faq>(entity =>
        {
            entity.ToTable("FAQ");

            entity.Property(e => e.Faqid).HasColumnName("FAQID");
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");

            entity.Property(e => e.GradId).HasColumnName("GradID");
        });

        modelBuilder.Entity<Kategorija>(entity =>
        {
            entity.ToTable("Kategorija");

            entity.Property(e => e.KategorijaId).HasColumnName("KategorijaID");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.GradId, "IX_Korisnik_GradID");

            entity.HasIndex(e => e.SpolId, "IX_Korisnik_SpolID");

            entity.HasIndex(e => e.TeretanaId, "IX_Korisnik_TeretanaID");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.SpolId).HasColumnName("SpolID");
            entity.Property(e => e.TeretanaId).HasColumnName("TeretanaID");
            entity.Property(e => e.VrijemeUteretani).HasColumnName("VrijemeUTeretani");

            entity.HasOne(d => d.Grad).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Spol).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.SpolId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Teretana).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.TeretanaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikClanarina>(entity =>
        {
            entity.ToTable("Korisnik_Clanarina");

            entity.HasIndex(e => e.ClanarinaId, "IX_Korisnik_Clanarina_ClanarinaID");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Clanarina_KorisnikID");

            entity.Property(e => e.KorisnikClanarinaId).HasColumnName("Korisnik_ClanarinaID");
            entity.Property(e => e.ClanarinaId).HasColumnName("ClanarinaID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Clanarina).WithMany(p => p.KorisnikClanarinas)
                .HasForeignKey(d => d.ClanarinaId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikClanarinas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikNutricionst>(entity =>
        {
            entity.HasKey(e => e.KorisnikNutricionistId);

            entity.ToTable("Korisnik_Nutricionst");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Nutricionst_KorisnikID");

            entity.HasIndex(e => e.NutricionistId, "IX_Korisnik_Nutricionst_NutricionistID");

            entity.Property(e => e.KorisnikNutricionistId).HasColumnName("Korisnik_NutricionistID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.NutricionistId).HasColumnName("NutricionistID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikNutricionsts)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Nutricionist).WithMany(p => p.KorisnikNutricionsts)
                .HasForeignKey(d => d.NutricionistId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikTrener>(entity =>
        {
            entity.ToTable("Korisnik_Trener");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Trener_KorisnikID");

            entity.HasIndex(e => e.TrenerId, "IX_Korisnik_Trener_TrenerID");

            entity.Property(e => e.KorisnikTrenerId).HasColumnName("Korisnik_TrenerID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikTreners)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Trener).WithMany(p => p.KorisnikTreners)
                .HasForeignKey(d => d.TrenerId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikUloga>(entity =>
        {
            entity.ToTable("Korisnik_Uloga");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Uloga_KorisnikID");

            entity.HasIndex(e => e.UlogaId, "IX_Korisnik_Uloga_UlogaID");

            entity.Property(e => e.KorisnikUlogaId).HasColumnName("Korisnik_UlogaID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Narudzba>(entity =>
        {
            entity.ToTable("Narudzba");

            entity.HasIndex(e => e.KorisnikId, "IX_Narudzba_KorisnikID");

            entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Narudzbas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<NarudzbaStavka>(entity =>
        {
            entity.ToTable("Narudzba_Stavka");

            entity.HasIndex(e => e.NarudzbaId, "IX_Narudzba_Stavka_NarudzbaID");

            entity.HasIndex(e => e.SuplementId, "IX_Narudzba_Stavka_SuplementID");

            entity.Property(e => e.NarudzbaStavkaId).HasColumnName("Narudzba_StavkaID");
            entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");
            entity.Property(e => e.SuplementId).HasColumnName("SuplementID");

            entity.HasOne(d => d.Narudzba).WithMany(p => p.NarudzbaStavkas)
                .HasForeignKey(d => d.NarudzbaId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Suplement).WithMany(p => p.NarudzbaStavkas)
                .HasForeignKey(d => d.SuplementId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Nutricionist>(entity =>
        {
            entity.ToTable("Nutricionist");

            entity.Property(e => e.NutricionistId).HasColumnName("NutricionistID");
        });

        modelBuilder.Entity<NutricionistSeminar>(entity =>
        {
            entity.ToTable("Nutricionist_Seminar");

            entity.HasIndex(e => e.NutricionistId, "IX_Nutricionist_Seminar_NutricionistID");

            entity.HasIndex(e => e.SeminarId, "IX_Nutricionist_Seminar_SeminarID");

            entity.Property(e => e.NutricionistSeminarId).HasColumnName("Nutricionist_SeminarID");
            entity.Property(e => e.NutricionistId).HasColumnName("NutricionistID");
            entity.Property(e => e.SeminarId).HasColumnName("SeminarID");

            entity.HasOne(d => d.Nutricionist).WithMany(p => p.NutricionistSeminars)
                .HasForeignKey(d => d.NutricionistId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Seminar).WithMany(p => p.NutricionistSeminars)
                .HasForeignKey(d => d.SeminarId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Recenzija>(entity =>
        {
            entity.ToTable("Recenzija");

            entity.HasIndex(e => e.KorisnikId, "IX_Recenzija_KorisnikID");

            entity.HasIndex(e => e.SuplementId, "IX_Recenzija_SuplementID");

            entity.Property(e => e.RecenzijaId).HasColumnName("RecenzijaID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.SuplementId).HasColumnName("SuplementID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Recenzijas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Suplement).WithMany(p => p.Recenzijas)
                .HasForeignKey(d => d.SuplementId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Seminar>(entity =>
        {
            entity.ToTable("Seminar");

            entity.Property(e => e.SeminarId).HasColumnName("SeminarID");
        });

        modelBuilder.Entity<Spol>(entity =>
        {
            entity.ToTable("Spol");

            entity.Property(e => e.SpolId).HasColumnName("SpolID");
        });

        modelBuilder.Entity<Suplement>(entity =>
        {
            entity.ToTable("Suplement");

            entity.HasIndex(e => e.DobavljacId, "IX_Suplement_DobavljacID");

            entity.HasIndex(e => e.KategorijaId, "IX_Suplement_KategorijaID");

            entity.Property(e => e.SuplementId).HasColumnName("SuplementID");
            entity.Property(e => e.DobavljacId).HasColumnName("DobavljacID");
            entity.Property(e => e.KategorijaId).HasColumnName("KategorijaID");

            entity.HasOne(d => d.Dobavljac).WithMany(p => p.Suplements)
                .HasForeignKey(d => d.DobavljacId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Kategorija).WithMany(p => p.Suplements)
                .HasForeignKey(d => d.KategorijaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Teretana>(entity =>
        {
            entity.ToTable("Teretana");

            entity.HasIndex(e => e.GradId, "IX_Teretana_GradID");

            entity.Property(e => e.TeretanaId).HasColumnName("TeretanaID");
            entity.Property(e => e.GradId).HasColumnName("GradID");

            entity.HasOne(d => d.Grad).WithMany(p => p.Teretanas)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Trener>(entity =>
        {
            entity.ToTable("Trener");

            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");
        });

        modelBuilder.Entity<TrenerSeminar>(entity =>
        {
            entity.ToTable("Trener_Seminar");

            entity.HasIndex(e => e.SeminarId, "IX_Trener_Seminar_SeminarID");

            entity.HasIndex(e => e.TrenerId, "IX_Trener_Seminar_TrenerID");

            entity.Property(e => e.TrenerSeminarId).HasColumnName("Trener_SeminarID");
            entity.Property(e => e.SeminarId).HasColumnName("SeminarID");
            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");

            entity.HasOne(d => d.Seminar).WithMany(p => p.TrenerSeminars)
                .HasForeignKey(d => d.SeminarId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Trener).WithMany(p => p.TrenerSeminars)
                .HasForeignKey(d => d.TrenerId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.ToTable("Uloga");

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
