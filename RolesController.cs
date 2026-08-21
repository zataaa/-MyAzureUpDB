using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RolesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RolesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Roles
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Roles>>> GetRoles()
        {
            var items = await _context.Roles.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Roles/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Roles>> GetRolesById(
            int id)
        {
            var item = await _context.Roles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Roles
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Roles>> PostRoles(
            Roles item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Roles.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetRolesById),
                new { id = item.RoleID },
                item
            );
        }


        // =====================================================
        // PUT: api/Roles/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRoles(
            int id,
            Roles item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.RoleID))
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
                var exists = await _context.Roles
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.RoleID,
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
        // DELETE: api/Roles/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRoles(
            int id)
        {
            var item = await _context.Roles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Roles.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
