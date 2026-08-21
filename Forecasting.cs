#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Forecasting")]
    public class Forecasting
    {
        [Key]
        [Column("forecast_id")]
        public int forecast_id { get; set; }

        [Required]
        [MaxLength(40)]
        [Column("forecast_type")]
        public string forecast_type { get; set; } = "";

        [Column("model_used")]
        public string? model_used { get; set; }   // ممكن يكون NULL

        [Column("horizon")]
        public string? horizon { get; set; }   // ممكن يكون NULL

        [Column("predicted_value")]
        public decimal? predicted_value { get; set; }   // ممكن يكون NULL

        [Column("confidence_interval")]
        public string? confidence_interval { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("created_at")]
        public DateTime created_at { get; set; }


    }
}
