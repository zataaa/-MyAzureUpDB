using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WorkflowTasksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public WorkflowTasksController(AppDbContext context)
        {
            _context = context;
        }

        // =====================================================
        // GET: api/WorkflowTasks
        // =====================================================

        [HttpGet]
        public async Task<ActionResult<IEnumerable<WorkflowTasks>>> GetWorkflowTasks()
        {
            var items = await _context.WorkflowTasks.ToListAsync();

            return Ok(items);
        }


        // =====================================================
        // GET: api/WorkflowTasks/5
        // =====================================================

        [HttpGet("{id}")]
        public async Task<ActionResult<WorkflowTasks>> GetWorkflowTasksById(
            int id)
        {
            var item = await _context.WorkflowTasks.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }


        // =====================================================
        // POST: api/WorkflowTasks
        // =====================================================

        [HttpPost]
        public async Task<ActionResult<WorkflowTasks>> PostWorkflowTasks(
            WorkflowTasks item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            _context.WorkflowTasks.Add(item);

            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetWorkflowTasksById),
                new { id = item.TaskID },
                item
            );
        }


        // =====================================================
        // PUT: api/WorkflowTasks/5
        // =====================================================

        [HttpPut("{id}")]
        public async Task<IActionResult> PutWorkflowTasks(
            int id,
            WorkflowTasks item)
        {
            if (item == null)
            {
                return BadRequest("Item is null");
            }

            if (!EqualityComparer<int>.Default.Equals(
                id,
                item.TaskID))
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
                var exists = await _context.WorkflowTasks
                    .AnyAsync(e => EqualityComparer<int>.Default.Equals(
                        e.TaskID,
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
        // DELETE: api/WorkflowTasks/5
        // =====================================================

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWorkflowTasks(
            int id)
        {
            var item = await _context.WorkflowTasks.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.WorkflowTasks.Remove(item);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
