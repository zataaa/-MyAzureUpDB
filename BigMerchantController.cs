using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BigMerchantController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BigMerchantController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/BigMerchant
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<BigMerchant>>> GetBigMerchant()
        {
            var items = await _context.BigMerchant.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/BigMerchant/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<BigMerchant>> GetBigMerchantById(
            int id)
        {
            var item = await _context.BigMerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/BigMerchant
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<BigMerchant>> PostBigMerchant(
            BigMerchant item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.BigMerchant.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetBigMerchantById),
                new { id = item.Id },
                item
            );
        }


        // =====================================================
        // PUT: api/BigMerchant/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutBigMerchant(
            int id,
            BigMerchant item)
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
                var exists = await _context.BigMerchant
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
        // DELETE: api/BigMerchant/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBigMerchant(
            int id)
        {
            var item = await _context.BigMerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.BigMerchant.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
