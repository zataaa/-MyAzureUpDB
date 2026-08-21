#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Dashboard")]
    public class Dashboard
    {
        [Key]
        [Column("dashboard_id")]
        public int dashboard_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("name")]
        public string name { get; set; } = "";

        [Column("description")]
        public string? description { get; set; }   // ممكن يكون NULL

        [Column("Constants")]
        public string? Constants { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("CreatedAt")]
        public DateTime CreatedAt { get; set; }


    }
}
