using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductTableController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductTableController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/ProductTable
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductTable>>> GetProductTable()
        {
            var items = await _context.ProductTable.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/ProductTable/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<ProductTable>> GetProductTableById(
            int id)
        {
            var item = await _context.ProductTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/ProductTable
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<ProductTable>> PostProductTable(
            ProductTable item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.ProductTable.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetProductTableById),
                new { id = item.ProductID },
                item
            );
        }


        // =====================================================
        // PUT: api/ProductTable/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductTable(
            int id,
            ProductTable item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.ProductID))
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
                var exists = await _context.ProductTable
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.ProductID,
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
        // DELETE: api/ProductTable/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductTable(
            int id)
        {
            var item = await _context.ProductTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.ProductTable.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
