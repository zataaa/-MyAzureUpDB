#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("DigitalWallets")]
    public class DigitalWallets
    {
        [Key]
        [Column("WalletID")]
        public int WalletID { get; set; }

        [Required]
        [Column("UserID")]
        public int UserID { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("WalletType")]
        public string WalletType { get; set; } = "";

        [Required]
        [Column("Balance")]
        public decimal Balance { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("Status")]
        public string Status { get; set; } = "";

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Column("UpdatedAt")]
        public DateTime? UpdatedAt { get; set; }   // ممكن يكون NULL


    }
}
