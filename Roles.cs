#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Roles")]
    public class Roles
    {
        [Key]
        [Column("RoleID")]
        public int RoleID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("RoleName")]
        public string RoleName { get; set; } = "";

        [Column("Permissions")]
        public string? Permissions { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("CreatedAt")]
        public DateTime CreatedAt { get; set; }


    }
}
