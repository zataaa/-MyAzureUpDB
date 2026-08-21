using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Users
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Users>>> GetUsers()
        {
            var items = await _context.UsersTable.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Users/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Users>> GetUsersById(
            int id)
        {
            var item = await _context.UsersTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Users
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Users>> PostUsers(
            Users item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.UsersTable.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetUsersById),
                new { id = item.Id },
                item
            );
        }


        // =====================================================
        // PUT: api/Users/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsers(
            int id,
            Users item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.Id))
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
                var exists = await _context.UsersTable
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.Id,
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
        // DELETE: api/Users/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsers(
            int id)
        {
            var item = await _context.UsersTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.UsersTable.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
