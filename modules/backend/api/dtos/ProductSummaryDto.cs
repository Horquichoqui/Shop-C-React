namespace testeSetPar.Models.DTOs;

public class ProductSummaryDto
{
    public int ProductId { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal ListPrice { get; set; }
    public string? Color { get; set; }
    public string? ThumbnailPhotoFileName { get; set; }
    public int? ProductCategoryId { get; set; }
    public string? ProductCategoryName { get; set; }
    public int? ProductModelId { get; set; }
    public string? ProductModelName { get; set; }
}
