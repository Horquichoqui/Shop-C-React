using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using testeSetPar.Models;
using testeSetPar.Models.DTOs;

namespace testeSetPar.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ExercicioContext _context;

        public CategoriesController(ExercicioContext context)
        {
            _context = context;
        }

        // GET: api/Categories
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CategoryDto>>> GetCategories()
        {
            var categories = await _context.ProductCategories
                .Select(c => new CategoryDto
                {
                    ProductCategoryId = c.ProductCategoryId,
                    Name = c.Name
                })
                .ToListAsync();

            return categories;
        }
    }
}
