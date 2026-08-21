#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("KPIAlerts")]
    public class KPIAlerts
    {
        [Key]
        [Column("alert_id")]
        public int alert_id { get; set; }

        [Required]
        [Column("kpi_id")]
        public int kpi_id { get; set; }

        [Required]
        [Column("recorded_value")]
        public decimal recorded_value { get; set; }

        [Required]
        [Column("threshold_value")]
        public decimal threshold_value { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("alert_level")]
        public string alert_level { get; set; } = "";

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL


    }
}
