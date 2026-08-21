using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecommendedSmllmerchantController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RecommendedSmllmerchantController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/RecommendedSmllmerchant
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RecommendedSmllmerchant>>> GetRecommendedSmllmerchant()
        {
            var items = await _context.RecommendedSmllmerchant.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/RecommendedSmllmerchant/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<RecommendedSmllmerchant>> GetRecommendedSmllmerchantById(
            int id)
        {
            var item = await _context.RecommendedSmllmerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/RecommendedSmllmerchant
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<RecommendedSmllmerchant>> PostRecommendedSmllmerchant(
            RecommendedSmllmerchant item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.RecommendedSmllmerchant.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetRecommendedSmllmerchantById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/RecommendedSmllmerchant/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecommendedSmllmerchant(
            int id,
            RecommendedSmllmerchant item)
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
                var exists = await _context.RecommendedSmllmerchant
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
        // DELETE: api/RecommendedSmllmerchant/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRecommendedSmllmerchant(
            int id)
        {
            var item = await _context.RecommendedSmllmerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.RecommendedSmllmerchant.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
