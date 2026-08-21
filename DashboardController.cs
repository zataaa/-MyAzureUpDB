using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DashboardController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DashboardController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Dashboard
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Dashboard>>> GetDashboard()
        {
            var items = await _context.Dashboard.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Dashboard/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Dashboard>> GetDashboardById(
            int id)
        {
            var item = await _context.Dashboard.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Dashboard
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Dashboard>> PostDashboard(
            Dashboard item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Dashboard.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetDashboardById),
                new { id = item.dashboard_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Dashboard/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutDashboard(
            int id,
            Dashboard item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.dashboard_id))
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
                var exists = await _context.Dashboard
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.dashboard_id,
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
        // DELETE: api/Dashboard/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDashboard(
            int id)
        {
            var item = await _context.Dashboard.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Dashboard.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
