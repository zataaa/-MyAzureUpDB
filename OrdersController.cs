using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrdersController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/Orders
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Orders>>> GetOrders()
        {
            var items = await _context.Orders.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/Orders/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<Orders>> GetOrdersById(
            int id)
        {
            var item = await _context.Orders.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/Orders
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<Orders>> PostOrders(
            Orders item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.Orders.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetOrdersById),
                new { id = item.order_id },
                item
            );
        }


        // =====================================================
        // PUT: api/Orders/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrders(
            int id,
            Orders item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.order_id))
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
                var exists = await _context.Orders
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.order_id,
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
        // DELETE: api/Orders/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrders(
            int id)
        {
            var item = await _context.Orders.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Orders.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
