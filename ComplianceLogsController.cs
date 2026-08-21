using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ComplianceLogsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ComplianceLogsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/ComplianceLogs
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ComplianceLogs>>> GetComplianceLogs()
        {
            var items = await _context.ComplianceLogs.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/ComplianceLogs/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<ComplianceLogs>> GetComplianceLogsById(
            int id)
        {
            var item = await _context.ComplianceLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/ComplianceLogs
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<ComplianceLogs>> PostComplianceLogs(
            ComplianceLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.ComplianceLogs.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetComplianceLogsById),
                new { id = item.ComplianceID },
                item
            );
        }


        // =====================================================
        // PUT: api/ComplianceLogs/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutComplianceLogs(
            int id,
            ComplianceLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.ComplianceID))
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
                var exists = await _context.ComplianceLogs
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.ComplianceID,
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
        // DELETE: api/ComplianceLogs/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteComplianceLogs(
            int id)
        {
            var item = await _context.ComplianceLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.ComplianceLogs.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
