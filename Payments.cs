#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Payments")]
    public class Payments
    {
        [Key]
        [Column("PaymentID")]
        public int PaymentID { get; set; }

        [Required]
        [Column("OrderID")]
        public int OrderID { get; set; }

        [Required]
        [Column("UserID")]
        public int UserID { get; set; }

        [Required]
        [Column("Amount")]
        public decimal Amount { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("Method")]
        public string Method { get; set; } = "";

        [Required]
        [MaxLength(100)]
        [Column("Status")]
        public string Status { get; set; } = "";

        [Required]
        [Column("TransactionDate")]
        public DateTime TransactionDate { get; set; }

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Column("UpdatedAt")]
        public DateTime? UpdatedAt { get; set; }   // ممكن يكون NULL


    }
}
