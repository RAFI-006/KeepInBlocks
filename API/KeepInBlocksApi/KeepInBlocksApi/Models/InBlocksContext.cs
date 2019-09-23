using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace KeepInBlocksApi.Models
{
    public partial class InBlocksContext : DbContext
    {
        public InBlocksContext()
        {
        }

        public InBlocksContext(DbContextOptions<InBlocksContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Credentials> Credentials { get; set; }
        public virtual DbSet<Transaction> Transaction { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=LAPTOP-29GLHAK4\\SQLEXPRESS;Database=InBlocks;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Credentials>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.PrimaryKey)
                    .IsRequired()
                    .IsUnicode(false);

                entity.Property(e => e.UniqueKey)
                    .IsRequired()
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Transaction>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.TransactionHash)
                    .IsRequired()
                    .IsUnicode(false);

                entity.HasOne(d => d.Credentials)
                    .WithMany(p => p.Transaction)
                    .HasForeignKey(d => d.CredentialsId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Transaction_Credentials");
            });
        }
    }
}
