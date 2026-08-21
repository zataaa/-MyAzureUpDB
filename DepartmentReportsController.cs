using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DepartmentReportsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DepartmentReportsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/DepartmentReports
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<DepartmentReports>>> GetDepartmentReports()
        {
            var items = await _context.DepartmentReports.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/DepartmentReports/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<DepartmentReports>> GetDepartmentReportsById(
            int id)
        {
            var item = await _context.DepartmentReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/DepartmentReports
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<DepartmentReports>> PostDepartmentReports(
            DepartmentReports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.DepartmentReports.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetDepartmentReportsById),
                new { id = item.report_id },
                item
            );
        }


        // =====================================================
        // PUT: api/DepartmentReports/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutDepartmentReports(
            int id,
            DepartmentReports item)
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
                var exists = await _context.DepartmentReports
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
        // DELETE: api/DepartmentReports/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDepartmentReports(
            int id)
        {
            var item = await _context.DepartmentReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.DepartmentReports.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
