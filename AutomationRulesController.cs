using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AutomationRulesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AutomationRulesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/AutomationRules
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AutomationRules>>> GetAutomationRules()
        {
            var items = await _context.AutomationRules.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/AutomationRules/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<AutomationRules>> GetAutomationRulesById(
            int id)
        {
            var item = await _context.AutomationRules.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/AutomationRules
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<AutomationRules>> PostAutomationRules(
            AutomationRules item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.AutomationRules.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAutomationRulesById),
                new { id = item.RuleID },
                item
            );
        }


        // =====================================================
        // PUT: api/AutomationRules/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAutomationRules(
            int id,
            AutomationRules item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.RuleID))
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
                var exists = await _context.AutomationRules
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.RuleID,
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
        // DELETE: api/AutomationRules/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAutomationRules(
            int id)
        {
            var item = await _context.AutomationRules.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.AutomationRules.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
