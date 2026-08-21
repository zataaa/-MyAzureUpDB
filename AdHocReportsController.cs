using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AdHocReportsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AdHocReportsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/AdHocReports
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdHocReports>>> GetAdHocReports()
        {
            var items = await _context.AdHocReports.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/AdHocReports/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<AdHocReports>> GetAdHocReportsById(
            int id)
        {
            var item = await _context.AdHocReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/AdHocReports
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<AdHocReports>> PostAdHocReports(
            AdHocReports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.AdHocReports.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAdHocReportsById),
                new { id = item.Id },
                item
            );
        }


        // =====================================================
        // PUT: api/AdHocReports/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAdHocReports(
            int id,
            AdHocReports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.Id))
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
                var exists = await _context.AdHocReports
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.Id,
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
        // DELETE: api/AdHocReports/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAdHocReports(
            int id)
        {
            var item = await _context.AdHocReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.AdHocReports.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
