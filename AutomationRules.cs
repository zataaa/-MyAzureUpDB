#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("AutomationRules")]
    public class AutomationRules
    {
        [Key]
        [Column("RuleID")]
        public int RuleID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("RuleName")]
        public string RuleName { get; set; } = "";

        [Required]
        [MaxLength(510)]
        [Column("Condition")]
        public string Condition { get; set; } = "";

        [Required]
        [MaxLength(510)]
        [Column("Action")]
        public string Action { get; set; } = "";

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL

        [Column("CreatedAt")]
        public DateTime? CreatedAt { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL


    }
}
