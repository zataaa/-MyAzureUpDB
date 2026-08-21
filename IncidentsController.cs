using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IncidentsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public IncidentsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Incidents
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Incidents>>> GetIncidents()
        {
            var items = await _context.Incidents.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Incidents/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Incidents>> GetIncidentsById(
            int id)
        {
            var item = await _context.Incidents.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Incidents
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Incidents>> PostIncidents(
            Incidents item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Incidents.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetIncidentsById),
                new { id = item.incident_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Incidents/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncidents(
            int id,
            Incidents item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.incident_id))
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
                var exists = await _context.Incidents
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.incident_id,
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
        // DELETE: api/Incidents/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncidents(
            int id)
        {
            var item = await _context.Incidents.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Incidents.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
