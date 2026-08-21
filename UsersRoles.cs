#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("UsersRoles")]
    public class UsersRoles
    {
        [Key]
        [Column("UserID")]
        public int UserID { get; set; }

        [Key]
        [Column("RoleID")]
        public int RoleID { get; set; }

        [Key]
        [Column("UsersID")]
        public int UsersID { get; set; }


    }
}
