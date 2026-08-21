#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("IncidentForecast")]
    public class IncidentForecast
    {
        [Key]
        [Column("forecast_id")]
        public int forecast_id { get; set; }

        [Column("category")]
        public string? category { get; set; }   // ممكن يكون NULL

        [Column("period_start")]
        public DateTime? period_start { get; set; }   // ممكن يكون NULL

        [Column("period_end")]
        public DateTime? period_end { get; set; }   // ممكن يكون NULL

        [Column("predicted_incidents")]
        public int? predicted_incidents { get; set; }   // ممكن يكون NULL

        [Column("confidence_interval")]
        public string? confidence_interval { get; set; }   // ممكن يكون NULL

        [Column("model_used")]
        public string? model_used { get; set; }   // ممكن يكون NULL

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL


    }
}
