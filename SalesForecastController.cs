using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SalesForecastController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SalesForecastController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/SalesForecast
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SalesForecast>>> GetSalesForecast()
        {
            var items = await _context.SalesForecast.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/SalesForecast/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<SalesForecast>> GetSalesForecastById(
            int id)
        {
            var item = await _context.SalesForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/SalesForecast
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<SalesForecast>> PostSalesForecast(
            SalesForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.SalesForecast.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetSalesForecastById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/SalesForecast/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutSalesForecast(
            int id,
            SalesForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.forecast_id))
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
                var exists = await _context.SalesForecast
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.forecast_id,
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
        // DELETE: api/SalesForecast/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSalesForecast(
            int id)
        {
            var item = await _context.SalesForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.SalesForecast.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
