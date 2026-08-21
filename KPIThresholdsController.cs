using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KPIThresholdsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public KPIThresholdsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/KPIThresholds
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KPIThresholds>>> GetKPIThresholds()
        {
            var items = await _context.KPIThresholds.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/KPIThresholds/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<KPIThresholds>> GetKPIThresholdsById(
            int id)
        {
            var item = await _context.KPIThresholds.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/KPIThresholds
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<KPIThresholds>> PostKPIThresholds(
            KPIThresholds item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.KPIThresholds.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetKPIThresholdsById),
                new { id = item.threshold_id },
                item
            );
        }


        // =====================================================
        // PUT: api/KPIThresholds/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutKPIThresholds(
            int id,
            KPIThresholds item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.threshold_id))
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
                var exists = await _context.KPIThresholds
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.threshold_id,
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
        // DELETE: api/KPIThresholds/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKPIThresholds(
            int id)
        {
            var item = await _context.KPIThresholds.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.KPIThresholds.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
