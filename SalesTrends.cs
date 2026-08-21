#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("SalesTrends")]
    public class SalesTrends
    {
        [Key]
        [Column("trend_id")]
        public int trend_id { get; set; }

        [Required]
        [Column("product_id")]
        public int product_id { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("trend_type")]
        public string trend_type { get; set; } = "";

        [Required]
        [Column("percentage_change")]
        public decimal percentage_change { get; set; }

        [Required]
        [Column("period_start")]
        public DateTime period_start { get; set; }

        [Required]
        [Column("period_end")]
        public DateTime period_end { get; set; }


    }
}
