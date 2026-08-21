#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("ComplianceReports")]
    public class ComplianceReports
    {
        [Key]
        [Column("report_id")]
        public int report_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("compliance_type")]
        public string compliance_type { get; set; } = "";

        [Required]
        [MaxLength(300)]
        [Column("report_name")]
        public string report_name { get; set; } = "";

        [Required]
        [MaxLength(40)]
        [Column("status")]
        public string status { get; set; } = "";

        [Column("generated_at")]
        public DateTime? generated_at { get; set; }   // ممكن يكون NULL


    }
}
