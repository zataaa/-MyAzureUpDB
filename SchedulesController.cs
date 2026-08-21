using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SchedulesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SchedulesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Schedules
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Schedules>>> GetSchedules()
        {
            var items = await _context.Schedules.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Schedules/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Schedules>> GetSchedulesById(
            int id)
        {
            var item = await _context.Schedules.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Schedules
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Schedules>> PostSchedules(
            Schedules item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Schedules.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetSchedulesById),
                new { id = item.ScheduleID },
                item
            );
        }


        // =====================================================
        // PUT: api/Schedules/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutSchedules(
            int id,
            Schedules item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.ScheduleID))
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
                var exists = await _context.Schedules
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.ScheduleID,
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
        // DELETE: api/Schedules/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSchedules(
            int id)
        {
            var item = await _context.Schedules.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Schedules.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
