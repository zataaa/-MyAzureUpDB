#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("IncidentSolutions")]
    public class IncidentSolutions
    {
        [Key]
        [Column("solution_id")]
        public int solution_id { get; set; }

        [Required]
        [Column("incident_id")]
        public int incident_id { get; set; }

        [Column("solution_text")]
        public string? solution_text { get; set; }   // ممكن يكون NULL

        [Column("success_rate")]
        public decimal? success_rate { get; set; }   // ممكن يكون NULL

        [Column("avg_resolution_time")]
        public int? avg_resolution_time { get; set; }   // ممكن يكون NULL

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL


    }
}
