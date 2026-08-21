#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Schedules")]
    public class Schedules
    {
        [Key]
        [Column("ScheduleID")]
        public int ScheduleID { get; set; }

        [Required]
        [Column("TaskID")]
        public int TaskID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("CronExpression")]
        public string CronExpression { get; set; } = "";

        [Column("NextRun")]
        public DateTime? NextRun { get; set; }   // ممكن يكون NULL

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL


    }
}
