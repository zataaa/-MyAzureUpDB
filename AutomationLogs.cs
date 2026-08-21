#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("AutomationLogs")]
    public class AutomationLogs
    {
        [Key]
        [Column("LogID")]
        public int LogID { get; set; }

        [Column("RuleID")]
        public int? RuleID { get; set; }   // ممكن يكون NULL

        [Column("TaskID")]
        public int? TaskID { get; set; }   // ممكن يكون NULL

        [Column("ExecutionTime")]
        public DateTime? ExecutionTime { get; set; }   // ممكن يكون NULL

        [Column("Result")]
        public string? Result { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL


    }
}
