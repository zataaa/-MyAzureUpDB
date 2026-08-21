using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SmallMerchantRolesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SmallMerchantRolesController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/SmallMerchantRoles
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SmallMerchantRoles>>> GetSmallMerchantRoles()
        {
            var items = await _context.SmallMerchantRoles.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/SmallMerchantRoles/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<SmallMerchantRoles>> GetSmallMerchantRolesById(
            int id)
        {
            var item = await _context.SmallMerchantRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/SmallMerchantRoles
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<SmallMerchantRoles>> PostSmallMerchantRoles(
            SmallMerchantRoles item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.SmallMerchantRoles.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetSmallMerchantRolesById),
                new { id = item.UserID },
                item
            );
        }


        // =====================================================
        // PUT: api/SmallMerchantRoles/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutSmallMerchantRoles(
            int id,
            SmallMerchantRoles item)
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
                var exists = await _context.SmallMerchantRoles
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
        // DELETE: api/SmallMerchantRoles/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSmallMerchantRoles(
            int id)
        {
            var item = await _context.SmallMerchantRoles.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.SmallMerchantRoles.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
