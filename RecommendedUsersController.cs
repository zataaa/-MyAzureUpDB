using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecommendedUsersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RecommendedUsersController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/RecommendedUsers
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RecommendedUsers>>> GetRecommendedUsers()
        {
            var items = await _context.RecommendedUsers.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/RecommendedUsers/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<RecommendedUsers>> GetRecommendedUsersById(
            int id)
        {
            var item = await _context.RecommendedUsers.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/RecommendedUsers
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<RecommendedUsers>> PostRecommendedUsers(
            RecommendedUsers item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.RecommendedUsers.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetRecommendedUsersById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/RecommendedUsers/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecommendedUsers(
            int id,
            RecommendedUsers item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.UserID))
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
                var exists = await _context.RecommendedUsers
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.UserID,
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
        // DELETE: api/RecommendedUsers/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRecommendedUsers(
            int id)
        {
            var item = await _context.RecommendedUsers.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.RecommendedUsers.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
