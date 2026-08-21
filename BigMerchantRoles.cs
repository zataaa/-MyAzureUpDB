#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("BigMerchantRoles")]
    public class BigMerchantRoles
    {
        [Key]
        [Column("UserID")]
        public int UserID { get; set; }

        [Key]
        [Column("RoleID")]
        public int RoleID { get; set; }

        [Key]
        [Column("BigMerchantID")]
        public int BigMerchantID { get; set; }


    }
}
