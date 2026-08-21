#nullable enable
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.Models
{
    [Table("ProductTable")]
    public class ProductTable

    {
        [Key]
        [Column("ProductID")]
        public int ProductID { get; set; }

        [Required]
        [MaxLength(400)]
        [Column("ProductName")]
        public string ProductName { get; set; } = "";

        [Column("Description")]
        public string? Description { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("Price")]
        public decimal Price { get; set; }

        [Required]
        [Column("Stock")]
        public int Stock { get; set; }

        [Column("Category")]
        public string? Category { get; set; }   // ممكن يكون NULL

        [Column("Note")]
        public string? Note { get; set; }   // ممكن يكون NULL

        [Required]
        [Column("CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Column("UpdatedAt")]
        public DateTime? UpdatedAt { get; set; }   // ممكن يكون NULL


    }
}
