using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IncidentSolutionsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public IncidentSolutionsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/IncidentSolutions
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncidentSolutions>>> GetIncidentSolutions()
        {
            var items = await _context.IncidentSolutions.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/IncidentSolutions/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<IncidentSolutions>> GetIncidentSolutionsById(
            int id)
        {
            var item = await _context.IncidentSolutions.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/IncidentSolutions
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<IncidentSolutions>> PostIncidentSolutions(
            IncidentSolutions item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.IncidentSolutions.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetIncidentSolutionsById),
                new { id = item.solution_id },
                item
            );
        }


        // =====================================================
        // PUT: api/IncidentSolutions/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncidentSolutions(
            int id,
            IncidentSolutions item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.solution_id))
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
                var exists = await _context.IncidentSolutions
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.solution_id,
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
        // DELETE: api/IncidentSolutions/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncidentSolutions(
            int id)
        {
            var item = await _context.IncidentSolutions.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.IncidentSolutions.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
