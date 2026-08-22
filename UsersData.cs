#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("UsersData")]
    public class UsersData
    {
        [Key]
        [Column("UsersData")]
        public int UserID { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("UserName")]
        public string UserName { get; set; } = "";

        [Required]
        [MaxLength(400)]
        [Column("Email")]
        public string Email { get; set; } = "";

        [Required]
        [MaxLength(400)]
        [Column("PasswordHash")]
        public string PasswordHash { get; set; } = "";

        [Column("FacebookAccount")]
        public string? FacebookAccount { get; set; }   // ممكن يكون NULL

        [Column("InstagramAccount")]
        public string? InstagramAccount { get; set; }   // ممكن يكون NULL

        [Column("TwitterAccount")]
        public string? TwitterAccount { get; set; }   // ممكن يكون NULL

        [Column("TikTokAccount")]
        public string? TikTokAccount { get; set; }   // ممكن يكون NULL

        [Column("LinkedInAccount")]
        public string? LinkedInAccount { get; set; }   // ممكن يكون NULL

        [Column("Phone1")]
        public string? Phone1 { get; set; }   // ممكن يكون NULL

        [Column("Phone2")]
        public string? Phone2 { get; set; }   // ممكن يكون NULL

        [Column("Address")]
        public string? Address { get; set; }   // ممكن يكون NULL

        [Column("CreatedAt")]
        public DateTime? CreatedAt { get; set; }   // ممكن يكون NULL

        [Column("UpdatedAt")]
        public DateTime? UpdatedAt { get; set; }   // ممكن يكون NULL

        [Column("RoleID")]
        public int RoleID { get; set; }

        
    }
}
