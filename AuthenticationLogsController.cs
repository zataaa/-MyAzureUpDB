using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthenticationLogsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AuthenticationLogsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/AuthenticationLogs
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AuthenticationLogs>>> GetAuthenticationLogs()
        {
            var items = await _context.AuthenticationLogs.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/AuthenticationLogs/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<AuthenticationLogs>> GetAuthenticationLogsById(
            int id)
        {
            var item = await _context.AuthenticationLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/AuthenticationLogs
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<AuthenticationLogs>> PostAuthenticationLogs(
            AuthenticationLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.AuthenticationLogs.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAuthenticationLogsById),
                new { id = item.ID },
                item
            );
        }


        // =====================================================
        // PUT: api/AuthenticationLogs/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAuthenticationLogs(
            int id,
            AuthenticationLogs item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.ID))
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
                var exists = await _context.AuthenticationLogs
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.ID,
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
        // DELETE: api/AuthenticationLogs/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAuthenticationLogs(
            int id)
        {
            var item = await _context.AuthenticationLogs.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.AuthenticationLogs.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
