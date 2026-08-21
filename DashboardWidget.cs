#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("DashboardWidget")]
    public class DashboardWidget
    {
        [Key]
        [Column("widget_id")]
        public int widget_id { get; set; }

        [Required]
        [Column("dashboard_id")]
        public int dashboard_id { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("widget_type")]
        public string widget_type { get; set; } = "";

        [Required]
        [MaxLength(200)]
        [Column("data_source")]
        public string data_source { get; set; } = "";

        [Column("config")]
        public string? config { get; set; }   // ممكن يكون NULL


    }
}
