using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecommendedBigmerchantController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RecommendedBigmerchantController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/RecommendedBigmerchant
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RecommendedBigmerchant>>> GetRecommendedBigmerchant()
        {
            var items = await _context.RecommendedBigmerchant.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/RecommendedBigmerchant/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<RecommendedBigmerchant>> GetRecommendedBigmerchantById(
            int id)
        {
            var item = await _context.RecommendedBigmerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/RecommendedBigmerchant
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<RecommendedBigmerchant>> PostRecommendedBigmerchant(
            RecommendedBigmerchant item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.RecommendedBigmerchant.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetRecommendedBigmerchantById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/RecommendedBigmerchant/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecommendedBigmerchant(
            int id,
            RecommendedBigmerchant item)
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
                var exists = await _context.RecommendedBigmerchant
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
        // DELETE: api/RecommendedBigmerchant/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRecommendedBigmerchant(
            int id)
        {
            var item = await _context.RecommendedBigmerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.RecommendedBigmerchant.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
