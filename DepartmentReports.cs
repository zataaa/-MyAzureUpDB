#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("DepartmentReports")]
    public class DepartmentReports
    {
        [Key]
        [Column("report_id")]
        public int report_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("department_name")]
        public string department_name { get; set; } = "";

        [Required]
        [MaxLength(300)]
        [Column("report_name")]
        public string report_name { get; set; } = "";

        [Column("kpi_values")]
        public string? kpi_values { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("created_at")]
        public DateTime created_at { get; set; }


    }
}
