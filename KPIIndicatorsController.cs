using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KPIIndicatorsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public KPIIndicatorsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/KPIIndicators
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KPIIndicators>>> GetKPIIndicators()
        {
            var items = await _context.KPIIndicators.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/KPIIndicators/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<KPIIndicators>> GetKPIIndicatorsById(
            int id)
        {
            var item = await _context.KPIIndicators.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/KPIIndicators
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<KPIIndicators>> PostKPIIndicators(
            KPIIndicators item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.KPIIndicators.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetKPIIndicatorsById),
                new { id = item.kpi_id },
                item
            );
        }


        // =====================================================
        // PUT: api/KPIIndicators/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutKPIIndicators(
            int id,
            KPIIndicators item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.kpi_id))
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
                var exists = await _context.KPIIndicators
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.kpi_id,
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
        // DELETE: api/KPIIndicators/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKPIIndicators(
            int id)
        {
            var item = await _context.KPIIndicators.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.KPIIndicators.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
