#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("IncidentResponse")]
    public class IncidentResponse
    {
        [Key]
        [Column("IncidentID")]
        public int IncidentID { get; set; }

        [Required]
        [Column("AlertID")]
        public int AlertID { get; set; }

        [Column("ResponseAction")]
        public string? ResponseAction { get; set; }   // ممكن يكون NULL

        [Column("ResponseTime")]
        public DateTime? ResponseTime { get; set; }   // ممكن يكون NULL


    }
}
