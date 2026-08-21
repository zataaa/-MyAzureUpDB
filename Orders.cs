#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Orders")]
    public class Orders
    {
        [Key]
        [Column("order_id")]
        public int order_id { get; set; }

        [Required]
        [Column("customer_id")]
        public int customer_id { get; set; }

        [Required]
        [Column("order_date")]
        public DateTime order_date { get; set; }

        [Required]
        [Column("total_amount")]
        public decimal total_amount { get; set; }


    }
}
