#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("KPIThresholds")]
    public class KPIThresholds
    {
        [Key]
        [Column("threshold_id")]
        public int threshold_id { get; set; }

        [Required]
        [Column("kpi_id")]
        public int kpi_id { get; set; }

        [Column("min_value")]
        public decimal? min_value { get; set; }   // ممكن يكون NULL

        [Column("max_value")]
        public decimal? max_value { get; set; }   // ممكن يكون NULL

        [Required]
        [MaxLength(100)]
        [Column("alert_level")]
        public string alert_level { get; set; } = "";

        [Required]
        [Column("CreatedAT")]
        public DateTime CreatedAT { get; set; }


    }
}
