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

    public virtual DbSet<Administrator> Administrators { get; set; }

    public virtual DbSet<AutentifikacijaToken> AutentifikacijaTokens { get; set; }

    public virtual DbSet<Clanarina> Clanarinas { get; set; }

    public virtual DbSet<Dobavljac> Dobavljacs { get; set; }

    public virtual DbSet<Faq> Faqs { get; set; }

    public virtual DbSet<Grad> Grads { get; set; }

    public virtual DbSet<Kategorija> Kategorijas { get; set; }

    public virtual DbSet<KorisnickiNalog> KorisnickiNalogs { get; set; }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<KorisnikClanarina> KorisnikClanarinas { get; set; }

    public virtual DbSet<KorisnikNutricionst> KorisnikNutricionsts { get; set; }

    public virtual DbSet<KorisnikSuplement> KorisnikSuplements { get; set; }

    public virtual DbSet<KorisnikTrener> KorisnikTreners { get; set; }

    public virtual DbSet<LogKretanjePoSistemu> LogKretanjePoSistemus { get; set; }

    public virtual DbSet<Nutricionist> Nutricionists { get; set; }

    public virtual DbSet<Recenzija> Recenzijas { get; set; }

    public virtual DbSet<Seminar> Seminars { get; set; }

    public virtual DbSet<Spol> Spols { get; set; }

    public virtual DbSet<Suplement> Suplements { get; set; }

    public virtual DbSet<Teretana> Teretanas { get; set; }

    public virtual DbSet<Trener> Treners { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=GMS_db;Trusted_Connection=True;User ID=gms;Password=gms2023; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Administrator>(entity =>
        {
            entity.ToTable("Administrator");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Administrator)
                .HasForeignKey<Administrator>(d => d.Id)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<AutentifikacijaToken>(entity =>
        {
            entity.ToTable("AutentifikacijaToken");

            entity.HasIndex(e => e.KorisnickiNalogId, "IX_AutentifikacijaToken_KorisnickiNalogId");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.IpAdresa).HasColumnName("ipAdresa");
            entity.Property(e => e.TwoFkey).HasColumnName("TwoFKey");
            entity.Property(e => e.Vrijednost).HasColumnName("vrijednost");
            entity.Property(e => e.VrijemeEvidentiranja).HasColumnName("vrijemeEvidentiranja");

            entity.HasOne(d => d.KorisnickiNalog).WithMany(p => p.AutentifikacijaTokens)
                .HasForeignKey(d => d.KorisnickiNalogId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Clanarina>(entity =>
        {
            entity.ToTable("Clanarina");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Dobavljac>(entity =>
        {
            entity.ToTable("Dobavljac");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Faq>(entity =>
        {
            entity.ToTable("FAQ");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Kategorija>(entity =>
        {
            entity.ToTable("Kategorija");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<KorisnickiNalog>(entity =>
        {
            entity.ToTable("KorisnickiNalog");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Is2Factive).HasColumnName("is2FActive");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.GradId, "IX_Korisnik_GradID");

            entity.HasIndex(e => e.SpolId, "IX_Korisnik_SpolID");

            entity.HasIndex(e => e.TeretanaId, "IX_Korisnik_TeretanaID");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.SpolId).HasColumnName("SpolID");
            entity.Property(e => e.TeretanaId).HasColumnName("TeretanaID");

            entity.HasOne(d => d.Grad).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Korisnik)
                .HasForeignKey<Korisnik>(d => d.Id)
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
            entity.HasKey(e => new { e.ClanarinaId, e.KorisnikId, e.DatumUplate });

            entity.ToTable("Korisnik_Clanarina");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Clanarina_KorisnikID");

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
            entity.HasKey(e => new { e.KorisnikId, e.NutricionistId, e.DatumTermina });

            entity.ToTable("Korisnik_Nutricionst");

            entity.HasIndex(e => e.NutricionistId, "IX_Korisnik_Nutricionst_NutricionistID");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.NutricionistId).HasColumnName("NutricionistID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikNutricionsts)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Nutricionist).WithMany(p => p.KorisnikNutricionsts)
                .HasForeignKey(d => d.NutricionistId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikSuplement>(entity =>
        {
            entity.HasKey(e => new { e.SuplementId, e.KorisnikId, e.DatumVrijemeNarudzbe });

            entity.ToTable("Korisnik_Suplement");

            entity.HasIndex(e => e.KorisnikId, "IX_Korisnik_Suplement_KorisnikID");

            entity.Property(e => e.SuplementId).HasColumnName("SuplementID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikSuplements)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Suplement).WithMany(p => p.KorisnikSuplements)
                .HasForeignKey(d => d.SuplementId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<KorisnikTrener>(entity =>
        {
            entity.HasKey(e => new { e.KorisnikId, e.TrenerId, e.DatumTermina });

            entity.ToTable("Korisnik_Trener");

            entity.HasIndex(e => e.TrenerId, "IX_Korisnik_Trener_TrenerID");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikTreners)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Trener).WithMany(p => p.KorisnikTreners)
                .HasForeignKey(d => d.TrenerId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<LogKretanjePoSistemu>(entity =>
        {
            entity.ToTable("LogKretanjePoSistemu");

            entity.HasIndex(e => e.KorisnikId, "IX_LogKretanjePoSistemu_KorisnikID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.LogKretanjePoSistemus)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Nutricionist>(entity =>
        {
            entity.ToTable("Nutricionist");

            entity.Property(e => e.Id).HasColumnName("ID");

            entity.HasMany(d => d.Seminars).WithMany(p => p.Nutricionists)
                .UsingEntity<Dictionary<string, object>>(
                    "NutricionistSeminar",
                    r => r.HasOne<Seminar>().WithMany()
                        .HasForeignKey("SeminarId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    l => l.HasOne<Nutricionist>().WithMany()
                        .HasForeignKey("NutricionistId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    j =>
                    {
                        j.HasKey("NutricionistId", "SeminarId");
                        j.ToTable("Nutricionist_Seminar");
                        j.HasIndex(new[] { "SeminarId" }, "IX_Nutricionist_Seminar_SeminarID");
                        j.IndexerProperty<int>("NutricionistId").HasColumnName("NutricionistID");
                        j.IndexerProperty<int>("SeminarId").HasColumnName("SeminarID");
                    });
        });

        modelBuilder.Entity<Recenzija>(entity =>
        {
            entity.ToTable("Recenzija");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Seminar>(entity =>
        {
            entity.ToTable("Seminar");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Spol>(entity =>
        {
            entity.ToTable("Spol");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Suplement>(entity =>
        {
            entity.ToTable("Suplement");

            entity.HasIndex(e => e.DobavljacId, "IX_Suplement_DobavljacID");

            entity.HasIndex(e => e.KategorijaId, "IX_Suplement_KategorijaID");

            entity.Property(e => e.Id).HasColumnName("ID");
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

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.GradId).HasColumnName("GradID");

            entity.HasOne(d => d.Grad).WithMany(p => p.Teretanas)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Trener>(entity =>
        {
            entity.ToTable("Trener");

            entity.Property(e => e.Id).HasColumnName("ID");

            entity.HasMany(d => d.Seminars).WithMany(p => p.Treners)
                .UsingEntity<Dictionary<string, object>>(
                    "TrenerSeminar",
                    r => r.HasOne<Seminar>().WithMany()
                        .HasForeignKey("SeminarId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    l => l.HasOne<Trener>().WithMany()
                        .HasForeignKey("TrenerId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    j =>
                    {
                        j.HasKey("TrenerId", "SeminarId");
                        j.ToTable("Trener_Seminar");
                        j.HasIndex(new[] { "SeminarId" }, "IX_Trener_Seminar_SeminarID");
                        j.IndexerProperty<int>("TrenerId").HasColumnName("TrenerID");
                        j.IndexerProperty<int>("SeminarId").HasColumnName("SeminarID");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
