#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Reports")]
    public class Reports
    {
        [Key]
        [Column("report_id")]
        public int report_id { get; set; }

        [Required]
        [MaxLength(300)]
        [Column("report_name")]
        public string report_name { get; set; } = "";

        [Required]
        [MaxLength(100)]
        [Column("report_type")]
        public string report_type { get; set; } = "";

        [Column("created_by")]
        public string? created_by { get; set; }   // ممكن يكون NULL

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL


    }
}
