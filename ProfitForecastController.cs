using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProfitForecastController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProfitForecastController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/ProfitForecast
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProfitForecast>>> GetProfitForecast()
        {
            var items = await _context.ProfitForecast.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/ProfitForecast/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<ProfitForecast>> GetProfitForecastById(
            int id)
        {
            var item = await _context.ProfitForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/ProfitForecast
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<ProfitForecast>> PostProfitForecast(
            ProfitForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.ProfitForecast.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetProfitForecastById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/ProfitForecast/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProfitForecast(
            int id,
            ProfitForecast item)
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
                var exists = await _context.ProfitForecast
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
        // DELETE: api/ProfitForecast/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProfitForecast(
            int id)
        {
            var item = await _context.ProfitForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.ProfitForecast.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
