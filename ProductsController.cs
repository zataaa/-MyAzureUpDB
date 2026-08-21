using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Products
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Products>>> GetProducts()
        {
            var items = await _context.Products.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Products/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Products>> GetProductsById(
            int id)
        {
            var item = await _context.Products.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Products
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Products>> PostProducts(
            Products item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Products.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetProductsById),
                new { id = item.product_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Products/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProducts(
            int id,
            Products item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.product_id))
            {
                return BadRequest("Id mismatch");
            }

            _context.Entry(item).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                var exists = await _context.Products
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.product_id,
                        id));

                if (!exists)
                {
                    return NotFound();
                }

                throw;
            }

            return NoContent();
        }


        // =====================================================
        // DELETE: api/Products/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProducts(
            int id)
        {
            var item = await _context.Products.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Products.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
