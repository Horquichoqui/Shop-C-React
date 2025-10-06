namespace testeSetPar.Models.DTOs;

public class ProductDetailDto
{
    public int ProductId { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal ListPrice { get; set; }
    public string? Color { get; set; }
    public string? Size { get; set; }
    public decimal? Weight { get; set; }
    public string? ThumbnailPhotoFileName { get; set; }
    public int? ProductCategoryId { get; set; }
    public string? CategoryName { get; set; }
    public int? ProductModelId { get; set; }
    public string? ModelName { get; set; }
    public string? Description { get; set; }
}
