using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BigMerchantRolesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BigMerchantRolesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/BigMerchantRoles
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<BigMerchantRoles>>> GetBigMerchantRoles()
        {
            var items = await _context.BigMerchantRoles.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/BigMerchantRoles/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<BigMerchantRoles>> GetBigMerchantRolesById(
            int id)
        {
            var item = await _context.BigMerchantRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/BigMerchantRoles
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<BigMerchantRoles>> PostBigMerchantRoles(
            BigMerchantRoles item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.BigMerchantRoles.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetBigMerchantRolesById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/BigMerchantRoles/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutBigMerchantRoles(
            int id,
            BigMerchantRoles item)
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
                var exists = await _context.BigMerchantRoles
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
        // DELETE: api/BigMerchantRoles/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBigMerchantRoles(
            int id)
        {
            var item = await _context.BigMerchantRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.BigMerchantRoles.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
