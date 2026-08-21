#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("AuthenticationLogs")]
    public class AuthenticationLogs
    {
        [Key]
        [Column("ID")]
        public int ID { get; set; }

        [Column("UserID")]
        public int? UserID { get; set; }   // ممكن يكون NULL

        [Column("SmallMerchantID")]
        public int? SmallMerchantID { get; set; }   // ممكن يكون NULL

        [Column("BigMerchantID")]
        public int? BigMerchantID { get; set; }   // ممكن يكون NULL

        [Required]
        [MaxLength(400)]
        [Column("PasswordHash")]
        public string PasswordHash { get; set; } = "";

        [Column("LoginTime")]
        public DateTime? LoginTime { get; set; }   // ممكن يكون NULL

        [Column("Status")]
        public string? Status { get; set; }   // ممكن يكون NULL


    }
}
