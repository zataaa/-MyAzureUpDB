using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CustomReportsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CustomReportsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/CustomReports
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomReports>>> GetCustomReports()
        {
            var items = await _context.CustomReports.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/CustomReports/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<CustomReports>> GetCustomReportsById(
            int id)
        {
            var item = await _context.CustomReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/CustomReports
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<CustomReports>> PostCustomReports(
            CustomReports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.CustomReports.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetCustomReportsById),
                new { id = item.report_id },
                item
            );
        }


        // =====================================================
        // PUT: api/CustomReports/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomReports(
            int id,
            CustomReports item)
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
                var exists = await _context.CustomReports
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
        // DELETE: api/CustomReports/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomReports(
            int id)
        {
            var item = await _context.CustomReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.CustomReports.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
