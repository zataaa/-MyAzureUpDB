using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DashboardWidgetController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DashboardWidgetController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/DashboardWidget
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<DashboardWidget>>> GetDashboardWidget()
        {
            var items = await _context.DashboardWidget.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/DashboardWidget/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<DashboardWidget>> GetDashboardWidgetById(
            int id)
        {
            var item = await _context.DashboardWidget.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/DashboardWidget
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<DashboardWidget>> PostDashboardWidget(
            DashboardWidget item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.DashboardWidget.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetDashboardWidgetById),
                new { id = item.widget_id },
                item
            );
        }


        // =====================================================
        // PUT: api/DashboardWidget/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutDashboardWidget(
            int id,
            DashboardWidget item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.widget_id))
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
                var exists = await _context.DashboardWidget
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.widget_id,
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
        // DELETE: api/DashboardWidget/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDashboardWidget(
            int id)
        {
            var item = await _context.DashboardWidget.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.DashboardWidget.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
