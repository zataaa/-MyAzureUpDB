using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersForecastController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersForecastController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/UsersForecast
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UsersForecast>>> GetUsersForecast()
        {
            var items = await _context.UsersForecast.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/UsersForecast/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<UsersForecast>> GetUsersForecastById(
            int id)
        {
            var item = await _context.UsersForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/UsersForecast
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<UsersForecast>> PostUsersForecast(
            UsersForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.UsersForecast.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetUsersForecastById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/UsersForecast/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsersForecast(
            int id,
            UsersForecast item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.forecast_id))
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
                var exists = await _context.UsersForecast
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.forecast_id,
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
        // DELETE: api/UsersForecast/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsersForecast(
            int id)
        {
            var item = await _context.UsersForecast.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.UsersForecast.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
