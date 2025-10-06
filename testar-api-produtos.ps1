# Script para testar a API de produtos
Write-Host "?? Testando API de produtos..." -ForegroundColor Yellow

try {
    # Testar endpoint de produtos
    $response = Invoke-WebRequest -Uri "http://localhost:5000/api/Products" -UseBasicParsing
    Write-Host "? API de produtos funcionando!" -ForegroundColor Green
    Write-Host "?? Status Code: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "?? Content Length: $($response.Content.Length) caracteres" -ForegroundColor Cyan
    
    # Tentar converter para JSON
    $jsonData = $response.Content | ConvertFrom-Json
    Write-Host "?? Total de produtos encontrados: $($jsonData.Count)" -ForegroundColor Green
    
    if ($jsonData.Count -gt 0) {
        Write-Host "?? Primeiro produto:" -ForegroundColor Cyan
        Write-Host "   ID: $($jsonData[0].productId)" -ForegroundColor White
        Write-Host "   Nome: $($jsonData[0].name)" -ForegroundColor White
        Write-Host "   Número: $($jsonData[0].productNumber)" -ForegroundColor White
        Write-Host "   Preço: R$ $($jsonData[0].listPrice)" -ForegroundColor White
        Write-Host "   Cor: $($jsonData[0].color)" -ForegroundColor White
        
        # Testar endpoint de imagem
        Write-Host "??? Testando endpoint de imagem..." -ForegroundColor Yellow
        try {
            $imageResponse = Invoke-WebRequest -Uri "http://localhost:5000/api/Products/$($jsonData[0].productId)/image" -UseBasicParsing
            Write-Host "? Imagem disponível para produto ID: $($jsonData[0].productId)" -ForegroundColor Green
            Write-Host "?? Tamanho da imagem: $($imageResponse.Content.Length) bytes" -ForegroundColor Cyan
        } catch {
            Write-Host "?? Imagem não disponível para produto ID: $($jsonData[0].productId)" -ForegroundColor Yellow
        }
    }
    
} catch {
    Write-Host "? Erro ao testar API: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "?? Verifique se o backend está rodando na porta 5000" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "?? URLs para testar manualmente:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   API: http://localhost:5000/api/Products" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
