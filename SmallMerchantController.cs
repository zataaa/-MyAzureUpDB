using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SmallMerchantController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SmallMerchantController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/SmallMerchant
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SmallMerchant>>> GetSmallMerchant()
        {
            var items = await _context.SmallMerchant.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/SmallMerchant/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<SmallMerchant>> GetSmallMerchantById(
            int id)
        {
            var item = await _context.SmallMerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/SmallMerchant
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<SmallMerchant>> PostSmallMerchant(
            SmallMerchant item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.SmallMerchant.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetSmallMerchantById),
                new { id = item.Id },
                item
            );
        }


        // =====================================================
        // PUT: api/SmallMerchant/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutSmallMerchant(
            int id,
            SmallMerchant item)
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
                var exists = await _context.SmallMerchant
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
        // DELETE: api/SmallMerchant/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSmallMerchant(
            int id)
        {
            var item = await _context.SmallMerchant.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.SmallMerchant.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
