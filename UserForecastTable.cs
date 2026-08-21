#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("UserForecastTable")]
    public class UserForecastTable
    {
        [Key]
        [Column("forecast_id")]
        public int forecast_id { get; set; }

        [Column("period_start")]
        public DateTime? period_start { get; set; }   // ممكن يكون NULL

        [Column("period_end")]
        public DateTime? period_end { get; set; }   // ممكن يكون NULL

        [Column("predicted_users")]
        public int? predicted_users { get; set; }   // ممكن يكون NULL

        [Column("confidence_interval")]
        public string? confidence_interval { get; set; }   // ممكن يكون NULL

        [Column("model_used")]
        public string? model_used { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("created_at")]
        public DateTime created_at { get; set; }


    }
}
