#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("TeamAssignments")]
    public class TeamAssignments
    {
        [Key]
        [Column("assignment_id")]
        public int assignment_id { get; set; }

        [Required]
        [Column("incident_id")]
        public int incident_id { get; set; }

        [Required]
        [Column("team_id")]
        public int team_id { get; set; }

        [Column("confidence_score")]
        public decimal? confidence_score { get; set; }   // ممكن يكون NULL

        [Column("created_at")]
        public DateTime? created_at { get; set; }   // ممكن يكون NULL


    }
}
