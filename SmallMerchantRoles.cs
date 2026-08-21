#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("SmallMerchantRoles")]
    public class SmallMerchantRoles
    {
        [Key]
        [Column("UserID")]
        public int UserID { get; set; }

        [Key]
        [Column("RoleID")]
        public int RoleID { get; set; }

        [Key]
        [Column("SmallMerchantID")]
        public int SmallMerchantID { get; set; }


    }
}
