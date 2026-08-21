using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TeamAssignmentsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TeamAssignmentsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/TeamAssignments
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TeamAssignments>>> GetTeamAssignments()
        {
            var items = await _context.TeamAssignments.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/TeamAssignments/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<TeamAssignments>> GetTeamAssignmentsById(
            int id)
        {
            var item = await _context.TeamAssignments.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/TeamAssignments
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<TeamAssignments>> PostTeamAssignments(
            TeamAssignments item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.TeamAssignments.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetTeamAssignmentsById),
                new { id = item.assignment_id },
                item
            );
        }


        // =====================================================
        // PUT: api/TeamAssignments/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTeamAssignments(
            int id,
            TeamAssignments item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.assignment_id))
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
                var exists = await _context.TeamAssignments
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.assignment_id,
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
        // DELETE: api/TeamAssignments/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTeamAssignments(
            int id)
        {
            var item = await _context.TeamAssignments.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.TeamAssignments.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
