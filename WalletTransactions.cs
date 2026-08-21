#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("WalletTransactions")]
    public class WalletTransactions
    {
        [Key]
        [Column("TransactionID")]
        public int TransactionID { get; set; }

        [Required]
        [Column("WalletID")]
        public int WalletID { get; set; }

        [Required]
        [Column("Amount")]
        public decimal Amount { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("TransactionType")]
        public string TransactionType { get; set; } = "";

        [Column("CreatedAt")]
        public DateTime? CreatedAt { get; set; }   // ممكن يكون NULL


    }
}
