using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersRolesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersRolesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/UsersRoles
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UsersRoles>>> GetUsersRoles()
        {
            var items = await _context.UsersRoles.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/UsersRoles/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<UsersRoles>> GetUsersRolesById(
            int id)
        {
            var item = await _context.UsersRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/UsersRoles
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<UsersRoles>> PostUsersRoles(
            UsersRoles item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.UsersRoles.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetUsersRolesById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/UsersRoles/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsersRoles(
            int id,
            UsersRoles item)
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
                var exists = await _context.UsersRoles
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
        // DELETE: api/UsersRoles/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsersRoles(
            int id)
        {
            var item = await _context.UsersRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.UsersRoles.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
