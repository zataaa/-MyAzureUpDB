using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ThreatAlertsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ThreatAlertsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/ThreatAlerts
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ThreatAlerts>>> GetThreatAlerts()
        {
            var items = await _context.ThreatAlerts.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/ThreatAlerts/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<ThreatAlerts>> GetThreatAlertsById(
            int id)
        {
            var item = await _context.ThreatAlerts.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/ThreatAlerts
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<ThreatAlerts>> PostThreatAlerts(
            ThreatAlerts item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.ThreatAlerts.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetThreatAlertsById),
                new { id = item.AlertID },
                item
            );
        }


        // =====================================================
        // PUT: api/ThreatAlerts/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutThreatAlerts(
            int id,
            ThreatAlerts item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.AlertID))
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
                var exists = await _context.ThreatAlerts
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.AlertID,
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
        // DELETE: api/ThreatAlerts/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteThreatAlerts(
            int id)
        {
            var item = await _context.ThreatAlerts.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.ThreatAlerts.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
