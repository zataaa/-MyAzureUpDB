using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TeamsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TeamsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Teams
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Teams>>> GetTeams()
        {
            var items = await _context.Teams.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Teams/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Teams>> GetTeamsById(
            int id)
        {
            var item = await _context.Teams.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Teams
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Teams>> PostTeams(
            Teams item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Teams.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetTeamsById),
                new { id = item.team_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Teams/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTeams(
            int id,
            Teams item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.team_id))
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
                var exists = await _context.Teams
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.team_id,
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
        // DELETE: api/Teams/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTeams(
            int id)
        {
            var item = await _context.Teams.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Teams.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
