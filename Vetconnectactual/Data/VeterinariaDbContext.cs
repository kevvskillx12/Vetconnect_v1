using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Models;

namespace VetConnect_v1.Data
{
    public class VeterinariaDbContext : DbContext
    {
        public VeterinariaDbContext(DbContextOptions<VeterinariaDbContext> options) : base(options) { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Mascota> Mascotas { get; set; }
        public DbSet<Veterinario> Veterinarios { get; set; }
        public DbSet<Cita> Citas { get; set; }
        public DbSet<Servicio> Servicios { get; set; }
        public DbSet<Configuracion> Configuraciones { get; set; }
        public DbSet<Geolocalizacion> Geolocalizaciones { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuración de claves primarias y relaciones
            modelBuilder.Entity<Cita>()
                .HasOne(c => c.Usuario)
                .WithMany()
                .HasForeignKey(c => c.UsuarioId)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Geolocalizacion>()
                .Property(g => g.Latitud)
                .HasColumnType("decimal(9,6)");

            modelBuilder.Entity<Geolocalizacion>()
                .Property(g => g.Longitud)
                .HasColumnType("decimal(9,6)");

            modelBuilder.Entity<Mascota>()
                .Property(m => m.Peso)
                .HasColumnType("decimal(5,2)");

            modelBuilder.Entity<Veterinario>().HasKey(v => v.VeterinarioId);

        }
    }
}
