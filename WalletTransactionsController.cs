using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WalletTransactionsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public WalletTransactionsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/WalletTransactions
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<WalletTransactions>>> GetWalletTransactions()
        {
            var items = await _context.WalletTransactions.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/WalletTransactions/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<WalletTransactions>> GetWalletTransactionsById(
            int id)
        {
            var item = await _context.WalletTransactions.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/WalletTransactions
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<WalletTransactions>> PostWalletTransactions(
            WalletTransactions item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.WalletTransactions.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetWalletTransactionsById),
                new { id = item.TransactionID },
                item
            );
        }


        // =====================================================
        // PUT: api/WalletTransactions/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutWalletTransactions(
            int id,
            WalletTransactions item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.TransactionID))
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
                var exists = await _context.WalletTransactions
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.TransactionID,
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
        // DELETE: api/WalletTransactions/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWalletTransactions(
            int id)
        {
            var item = await _context.WalletTransactions.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.WalletTransactions.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
