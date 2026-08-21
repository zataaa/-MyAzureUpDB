using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public PaymentsController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Payments
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Payments>>> GetPayments()
        {
            var items = await _context.Payments.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Payments/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Payments>> GetPaymentsById(
            int id)
        {
            var item = await _context.Payments.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Payments
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Payments>> PostPayments(
            Payments item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Payments.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetPaymentsById),
                new { id = item.PaymentID },
                item
            );
        }


        // =====================================================
        // PUT: api/Payments/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutPayments(
            int id,
            Payments item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.PaymentID))
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
                var exists = await _context.Payments
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.PaymentID,
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
        // DELETE: api/Payments/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePayments(
            int id)
        {
            var item = await _context.Payments.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Payments.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
