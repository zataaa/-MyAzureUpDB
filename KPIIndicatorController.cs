using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KPIIndicatorController : ControllerBase
    {
        private readonly AppDbContext _context;

        public KPIIndicatorController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/KPIIndicator
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KPIIndicator>>> GetKPIIndicator()
        {
            var items = await _context.KPIIndicator.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/KPIIndicator/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<KPIIndicator>> GetKPIIndicatorById(
            int id)
        {
            var item = await _context.KPIIndicator.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/KPIIndicator
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<KPIIndicator>> PostKPIIndicator(
            KPIIndicator item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.KPIIndicator.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetKPIIndicatorById),
                new { id = item.kpi_id },
                item
            );
        }


        // =====================================================
        // PUT: api/KPIIndicator/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutKPIIndicator(
            int id,
            KPIIndicator item)
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
                var exists = await _context.KPIIndicator
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
        // DELETE: api/KPIIndicator/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKPIIndicator(
            int id)
        {
            var item = await _context.KPIIndicator.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.KPIIndicator.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
