#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("KPIHistory")]
    public class KPIHistory
    {
        [Key]
        [Column("history_id")]
        public int history_id { get; set; }

        [Required]
        [Column("kpi_id")]
        public int kpi_id { get; set; }

        [Required]
        [Column("recorded_value")]
        public decimal recorded_value { get; set; }

        [Required]
        [Column("recorded_at")]
        public DateTime recorded_at { get; set; }


    }
}
