using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DigitalWalletsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DigitalWalletsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/DigitalWallets
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<DigitalWallets>>> GetDigitalWallets()
        {
            var items = await _context.DigitalWallets.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/DigitalWallets/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<DigitalWallets>> GetDigitalWalletsById(
            int id)
        {
            var item = await _context.DigitalWallets.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/DigitalWallets
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<DigitalWallets>> PostDigitalWallets(
            DigitalWallets item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.DigitalWallets.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetDigitalWalletsById),
                new { id = item.WalletID },
                item
            );
        }


        // =====================================================
        // PUT: api/DigitalWallets/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutDigitalWallets(
            int id,
            DigitalWallets item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.WalletID))
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
                var exists = await _context.DigitalWallets
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.WalletID,
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
        // DELETE: api/DigitalWallets/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDigitalWallets(
            int id)
        {
            var item = await _context.DigitalWallets.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.DigitalWallets.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
