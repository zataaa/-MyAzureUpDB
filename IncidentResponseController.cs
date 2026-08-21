using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IncidentResponseController : ControllerBase
    {
        private readonly AppDbContext _context;

        public IncidentResponseController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/IncidentResponse
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncidentResponse>>> GetIncidentResponse()
        {
            var items = await _context.IncidentResponse.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/IncidentResponse/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<IncidentResponse>> GetIncidentResponseById(
            int id)
        {
            var item = await _context.IncidentResponse.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/IncidentResponse
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<IncidentResponse>> PostIncidentResponse(
            IncidentResponse item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.IncidentResponse.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetIncidentResponseById),
                new { id = item.IncidentID },
                item
            );
        }


        // =====================================================
        // PUT: api/IncidentResponse/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncidentResponse(
            int id,
            IncidentResponse item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.IncidentID))
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
                var exists = await _context.IncidentResponse
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.IncidentID,
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
        // DELETE: api/IncidentResponse/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncidentResponse(
            int id)
        {
            var item = await _context.IncidentResponse.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.IncidentResponse.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
