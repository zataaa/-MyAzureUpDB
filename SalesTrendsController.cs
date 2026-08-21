using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SalesTrendsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SalesTrendsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/SalesTrends
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SalesTrends>>> GetSalesTrends()
        {
            var items = await _context.SalesTrends.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/SalesTrends/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<SalesTrends>> GetSalesTrendsById(
            int id)
        {
            var item = await _context.SalesTrends.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/SalesTrends
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<SalesTrends>> PostSalesTrends(
            SalesTrends item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.SalesTrends.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetSalesTrendsById),
                new { id = item.trend_id },
                item
            );
        }


        // =====================================================
        // PUT: api/SalesTrends/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutSalesTrends(
            int id,
            SalesTrends item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.trend_id))
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
                var exists = await _context.SalesTrends
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.trend_id,
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
        // DELETE: api/SalesTrends/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSalesTrends(
            int id)
        {
            var item = await _context.SalesTrends.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.SalesTrends.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
