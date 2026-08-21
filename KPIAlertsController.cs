using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KPIAlertsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public KPIAlertsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/KPIAlerts
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KPIAlerts>>> GetKPIAlerts()
        {
            var items = await _context.KPIAlerts.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/KPIAlerts/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<KPIAlerts>> GetKPIAlertsById(
            int id)
        {
            var item = await _context.KPIAlerts.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/KPIAlerts
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<KPIAlerts>> PostKPIAlerts(
            KPIAlerts item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.KPIAlerts.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetKPIAlertsById),
                new { id = item.alert_id },
                item
            );
        }


        // =====================================================
        // PUT: api/KPIAlerts/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutKPIAlerts(
            int id,
            KPIAlerts item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.alert_id))
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
                var exists = await _context.KPIAlerts
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.alert_id,
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
        // DELETE: api/KPIAlerts/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKPIAlerts(
            int id)
        {
            var item = await _context.KPIAlerts.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.KPIAlerts.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
