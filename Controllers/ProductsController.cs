using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using testeSetPar.Models;
using testeSetPar.Models.DTOs;

namespace testeSetPar.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly ExercicioContext _context;

        public ProductsController(ExercicioContext context)
        {
            _context = context;
        }

        // GET: api/Products
        [HttpGet]
        public async Task<ActionResult<PaginatedResponse<ProductSummaryDto>>> GetProducts(
            int page = 1, 
            int pageSize = 10, 
            int? categoryId = null)
        {
            var query = _context.Products.AsQueryable();

            // Filtrar por categoria se especificado
            if (categoryId.HasValue)
            {
                query = query.Where(p => p.ProductCategoryId == categoryId.Value);
            }

            var totalRecords = await query.CountAsync();
            var totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var products = await query
                .Include(p => p.ProductCategory)
                .Include(p => p.ProductModel)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(p => new ProductSummaryDto
                {
                    ProductId = p.ProductId,
                    Name = p.Name,
                    ListPrice = p.ListPrice,
                    Color = p.Color,
                    ThumbnailPhotoFileName = p.ThumbnailPhotoFileName,
                    ProductCategoryId = p.ProductCategoryId,
                    ProductCategoryName = p.ProductCategory != null ? p.ProductCategory.Name : null,
                    ProductModelId = p.ProductModelId,
                    ProductModelName = p.ProductModel != null ? p.ProductModel.Name : null
                })
                .ToListAsync();

            var response = new PaginatedResponse<ProductSummaryDto>
            {
                Page = page,
                PageSize = pageSize,
                TotalPages = totalPages,
                TotalRecords = totalRecords,
                Data = products
            };

            return Ok(response);
        }

        // GET: api/Products/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProductDetailDto>> GetProduct(int id)
        {
            var product = await _context.Products
                .Include(p => p.ProductCategory)
                .Include(p => p.ProductModel)
                .FirstOrDefaultAsync(p => p.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }

            var productDetail = new ProductDetailDto
            {
                ProductId = product.ProductId,
                Name = product.Name,
                ListPrice = product.ListPrice,
                Color = product.Color,
                Size = product.Size,
                Weight = product.Weight,
                ThumbnailPhotoFileName = product.ThumbnailPhotoFileName,
                ProductCategoryId = product.ProductCategoryId,
                CategoryName = product.ProductCategory?.Name,
                ProductModelId = product.ProductModelId,
                ModelName = product.ProductModel?.Name,
                Description = product.ProductModel?.CatalogDescription
            };

            return Ok(productDetail);
        }

        // PUT: api/Products/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduct(int id, Product product)
        {
            if (id != product.ProductId)
            {
                return BadRequest();
            }

            _context.Entry(product).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Products
        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct(Product product)
        {
            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProduct", new { id = product.ProductId }, product);
        }

        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // GET: api/Products/{id}/image
        [HttpGet("{id}/image")]
        public async Task<IActionResult> GetProductImage(int id)
        {
            try
            {
                var product = await _context.Products.FindAsync(id);
                if (product == null)
                {
                    return NotFound();
                }

                if (product.ThumbNailPhoto == null || product.ThumbNailPhoto.Length == 0)
                {
                    return NotFound();
                }

                // Determinar o tipo de conteúdo baseado no nome do arquivo ou usar JPEG como padrão
                var contentType = "image/jpeg";
                if (!string.IsNullOrEmpty(product.ThumbnailPhotoFileName))
                {
                    var extension = Path.GetExtension(product.ThumbnailPhotoFileName).ToLowerInvariant();
                    contentType = extension switch
                    {
                        ".png" => "image/png",
                        ".gif" => "image/gif",
                        ".bmp" => "image/bmp",
                        _ => "image/jpeg"
                    };
                }

                return File(product.ThumbNailPhoto, contentType);
            }
            catch (Exception ex)
            {
                // Log do erro (em produção, use um logger adequado)
                Console.WriteLine($"Erro ao carregar imagem do produto {id}: {ex.Message}");
                return NotFound();
            }
        }

        private bool ProductExists(int id)
        {
            return _context.Products.Any(e => e.ProductId == id);
        }
    }
}
