#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("RecommendedBigmerchant")]
    public class RecommendedBigmerchant
    {
        [Key]
        [Column("UserID")]
        public int UserID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("UserName")]
        public string UserName { get; set; } = "";

        [Required]
        [MaxLength(200)]
        [Column("Email")]
        public string Email { get; set; } = "";

        [Required]
        [Column("CreatedAT")]
        public DateTime CreatedAT { get; set; }


    }
}
