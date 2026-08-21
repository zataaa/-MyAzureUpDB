using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserForecastTableController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserForecastTableController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/UserForecastTable
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserForecastTable>>> GetUserForecastTable()
        {
            var items = await _context.UserForecastTable.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/UserForecastTable/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<UserForecastTable>> GetUserForecastTableById(
            int id)
        {
            var item = await _context.UserForecastTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/UserForecastTable
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<UserForecastTable>> PostUserForecastTable(
            UserForecastTable item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.UserForecastTable.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetUserForecastTableById),
                new { id = item.forecast_id },
                item
            );
        }


        // =====================================================
        // PUT: api/UserForecastTable/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUserForecastTable(
            int id,
            UserForecastTable item)
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
                var exists = await _context.UserForecastTable
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
        // DELETE: api/UserForecastTable/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserForecastTable(
            int id)
        {
            var item = await _context.UserForecastTable.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.UserForecastTable.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
