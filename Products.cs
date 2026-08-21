#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("Products")]
    public class Products
    {
        [Key]
        [Column("product_id")]
        public int product_id { get; set; }

        [Required]
        [MaxLength(400)]
        [Column("product_name")]
        public string product_name { get; set; } = "";

        [Column("category")]
        public string? category { get; set; }   // ممكن يكون NULL


    }
}
