using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReportsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ReportsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Reports
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Reports>>> GetReports()
        {
            var items = await _context.Reports.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Reports/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Reports>> GetReportsById(
            int id)
        {
            var item = await _context.Reports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Reports
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Reports>> PostReports(
            Reports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Reports.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetReportsById),
                new { id = item.report_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Reports/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutReports(
            int id,
            Reports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.report_id))
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
                var exists = await _context.Reports
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.report_id,
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
        // DELETE: api/Reports/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReports(
            int id)
        {
            var item = await _context.Reports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Reports.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
