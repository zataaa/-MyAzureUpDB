using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ForecastingController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ForecastingController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Forecasting
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Forecasting>>> GetForecasting()
        {
            var items = await _context.Forecasting.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Forecasting/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Forecasting>> GetForecastingById(
            int id)
        {
            var item = await _context.Forecasting.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Forecasting
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Forecasting>> PostForecasting(
            Forecasting item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Forecasting.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetForecastingById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Forecasting/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutForecasting(
            int id,
            Forecasting item)
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
                var exists = await _context.Forecasting
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
        // DELETE: api/Forecasting/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteForecasting(
            int id)
        {
            var item = await _context.Forecasting.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Forecasting.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
