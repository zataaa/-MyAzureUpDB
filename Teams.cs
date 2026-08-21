#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Teams")]
    public class Teams
    {
        [Key]
        [Column("team_id")]
        public int team_id { get; set; }

        [Column("team_name")]
        public string? team_name { get; set; }   // ممكن يكون NULL

        [Column("specialization")]
        public string? specialization { get; set; }   // ممكن يكون NULL

        [Column("current_load")]
        public int? current_load { get; set; }   // ممكن يكون NULL

        [Column("team_lead")]
        public string? team_lead { get; set; }   // ممكن يكون NULL


    }
}
