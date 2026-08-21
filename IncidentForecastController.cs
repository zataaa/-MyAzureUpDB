using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IncidentForecastController : ControllerBase
    {
        private readonly AppDbContext _context;

        public IncidentForecastController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/IncidentForecast
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncidentForecast>>> GetIncidentForecast()
        {
            var items = await _context.IncidentForecast.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/IncidentForecast/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<IncidentForecast>> GetIncidentForecastById(
            int id)
        {
            var item = await _context.IncidentForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/IncidentForecast
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<IncidentForecast>> PostIncidentForecast(
            IncidentForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.IncidentForecast.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetIncidentForecastById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/IncidentForecast/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncidentForecast(
            int id,
            IncidentForecast item)
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
                var exists = await _context.IncidentForecast
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
        // DELETE: api/IncidentForecast/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncidentForecast(
            int id)
        {
            var item = await _context.IncidentForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.IncidentForecast.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
