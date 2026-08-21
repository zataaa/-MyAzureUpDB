#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("AdHocReports")]
    public class AdHocReports
    {
        [Key]
        [Column("report_id")]
        public int Id { get; set; }   // المفتاح الأساسي مرتبط بالعمود report_id

        [Required]
        [MaxLength(300)]
        [Column("report_name")]
        public string report_name { get; set; } = "";

        [Required]
        [MaxLength(16)]
        [Column("query_text")]
        public string query_text { get; set; } = "";

        [Column("created_by")]
        public string? created_by { get; set; }

        [Column("created_at")]
        public DateTime? created_at { get; set; }
    }
}
