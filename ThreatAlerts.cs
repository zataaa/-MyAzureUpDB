#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("ThreatAlerts")]
    public class ThreatAlerts
    {
        [Key]
        [Column("AlertID")]
        public int AlertID { get; set; }

        [Column("AlertType")]
        public string? AlertType { get; set; }   // ممكن يكون NULL

        [Column("Description")]
        public string? Description { get; set; }   // ممكن يكون NULL

        [Column("DetectedAt")]
        public DateTime? DetectedAt { get; set; }   // ممكن يكون NULL

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL


    }
}
