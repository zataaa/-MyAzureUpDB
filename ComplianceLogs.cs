#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("ComplianceLogs")]
    public class ComplianceLogs
    {
        [Key]
        [Column("ComplianceID")]
        public int ComplianceID { get; set; }

        [Column("PolicyName")]
        public string? PolicyName { get; set; }   // ممكن يكون NULL

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL

        [Column("CheckedAt")]
        public DateTime? CheckedAt { get; set; }   // ممكن يكون NULL


    }
}
