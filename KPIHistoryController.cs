using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KPIHistoryController : ControllerBase
    {
        private readonly AppDbContext _context;

        public KPIHistoryController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/KPIHistory
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KPIHistory>>> GetKPIHistory()
        {
            var items = await _context.KPIHistory.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/KPIHistory/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<KPIHistory>> GetKPIHistoryById(
            int id)
        {
            var item = await _context.KPIHistory.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/KPIHistory
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<KPIHistory>> PostKPIHistory(
            KPIHistory item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.KPIHistory.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetKPIHistoryById),
                new { id = item.history_id },
                item
            );
        }


        // =====================================================
        // PUT: api/KPIHistory/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutKPIHistory(
            int id,
            KPIHistory item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.history_id))
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
                var exists = await _context.KPIHistory
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.history_id,
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
        // DELETE: api/KPIHistory/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKPIHistory(
            int id)
        {
            var item = await _context.KPIHistory.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.KPIHistory.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
