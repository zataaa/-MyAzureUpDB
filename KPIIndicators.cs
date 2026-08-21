#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("KPIIndicators")]
    public class KPIIndicators
    {
        [Key]
        [Column("kpi_id")]
        public int kpi_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("kpi_name")]
        public string kpi_name { get; set; } = "";

        [Required]
        [Column("target_value")]
        public decimal target_value { get; set; }

        [Required]
        [Column("CreatedAT")]
        public DateTime CreatedAT { get; set; }


    }
}
