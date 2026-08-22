
#nullable enable
using Microsoft.AspNetCore.Identity;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Users")]
    public class Users
    {
        [Key]
        [Column("UserID")]
        public int user_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("UserName")]
        public string user_name { get; set; } = "";

        [Required]
        [MaxLength(400)]
        [Column("Email")]
        public string email { get; set; } = "";

        [Required]
        [Column("CreatedAT")]
        public DateTime CreatedAT { get; set; }

        [Required]
        [Column("PasswordHash")]
        public string PasswordHash { get; set; } = "";

        [Required]
        [Column("Status")]
        public string Status { get; set; } = "";

        [Column("Notes")]
        public string Notes { get; set; } = "";
        
    }
}
