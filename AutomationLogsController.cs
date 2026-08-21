using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AutomationLogsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AutomationLogsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/AutomationLogs
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AutomationLogs>>> GetAutomationLogs()
        {
            var items = await _context.AutomationLogs.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/AutomationLogs/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<AutomationLogs>> GetAutomationLogsById(
            int id)
        {
            var item = await _context.AutomationLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/AutomationLogs
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<AutomationLogs>> PostAutomationLogs(
            AutomationLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.AutomationLogs.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAutomationLogsById),
                new { id = item.LogID },
                item
            );
        }


        // =====================================================
        // PUT: api/AutomationLogs/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAutomationLogs(
            int id,
            AutomationLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.LogID))
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
                var exists = await _context.AutomationLogs
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.LogID,
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
        // DELETE: api/AutomationLogs/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAutomationLogs(
            int id)
        {
            var item = await _context.AutomationLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.AutomationLogs.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
