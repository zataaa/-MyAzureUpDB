using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ComplianceReportsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ComplianceReportsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/ComplianceReports
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ComplianceReports>>> GetComplianceReports()
        {
            var items = await _context.ComplianceReports.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/ComplianceReports/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<ComplianceReports>> GetComplianceReportsById(
            int id)
        {
            var item = await _context.ComplianceReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/ComplianceReports
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<ComplianceReports>> PostComplianceReports(
            ComplianceReports item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.ComplianceReports.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetComplianceReportsById),
                new { id = item.report_id },
                item
            );
        }


        // =====================================================
        // PUT: api/ComplianceReports/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutComplianceReports(
            int id,
            ComplianceReports item)
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
                var exists = await _context.ComplianceReports
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
        // DELETE: api/ComplianceReports/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteComplianceReports(
            int id)
        {
            var item = await _context.ComplianceReports.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.ComplianceReports.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
