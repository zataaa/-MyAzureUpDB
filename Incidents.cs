#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Incidents")]
    public class Incidents
    {
        [Key]
        [Column("incident_id")]
        public int incident_id { get; set; }

        [Column("incident_title")]
        public string? incident_title { get; set; }   // ممكن يكون NULL

        [Column("incident_description")]
        public string? incident_description { get; set; }   // ممكن يكون NULL

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL

        [Column("severity")]
        public string? severity { get; set; }   // ممكن يكون NULL

        [Column("category")]
        public string? category { get; set; }   // ممكن يكون NULL


    }
}
