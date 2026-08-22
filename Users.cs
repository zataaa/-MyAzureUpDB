#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Users")]
    public class Users
    {
        [Key]
        [Column("user_id")]
        public int user_id { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("user_name")]
        public string user_name { get; set; } = "";

        [Required]
        [MaxLength(400)]
        [Column("email")]
        public string email { get; set; } = "";

        [Required]
        [Column("CreatedAT")]
        public DateTime CreatedAT { get; set; }


    }
}
