using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserTableController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserTableController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/UserTable
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserTable>>> GetUserTable()
        {
            var items = await _context.Users.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/UserTable/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<UserTable>> GetUserTableById(
            int id)
        {
            var item = await _context.Users.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/UserTable
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<UserTable>> PostUserTable(
            UserTable item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Users.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetUserTableById),
                new { id = item.user_id },
                item
            );
        }


        // =====================================================
        // PUT: api/UserTable/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUserTable(
            int id,
            UserTable item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.user_id))
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
                var exists = await _context.Users
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.user_id,
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
        // DELETE: api/UserTable/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserTable(
            int id)
        {
            var item = await _context.Users.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Users.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
