#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("WorkflowTasks")]
    public class WorkflowTasks
    {
        [Key]
        [Column("TaskID")]
        public int TaskID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("WorkflowName")]
        public string WorkflowName { get; set; } = "";

        [Required]
        [MaxLength(200)]
        [Column("TaskName")]
        public string TaskName { get; set; } = "";

        [Required]
        [Column("SequenceOrder")]
        public int SequenceOrder { get; set; }

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL

        [Column("CreatedAt")]
        public DateTime? CreatedAt { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL


    }
}
