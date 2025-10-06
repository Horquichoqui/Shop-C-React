# ?? Script de Teste da API - SetPar Store
# Execute este script para testar todos os endpoints da API

Write-Host "?? Testando API da SetPar Store..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Função para testar endpoint
function Test-Endpoint {
    param(
        [string]$Url,
        [string]$Description
    )
    
    Write-Host "?? Testando: $Description" -ForegroundColor Yellow
    Write-Host "   URL: $Url" -ForegroundColor Gray
    
    try {
        $response = Invoke-RestMethod -Uri $Url -UseBasicParsing -TimeoutSec 10
        Write-Host "   ? Sucesso!" -ForegroundColor Green
        
        # Mostrar informações básicas da resposta
        if ($response -is [array]) {
            Write-Host "   ?? Total de itens: $($response.Count)" -ForegroundColor Cyan
        } elseif ($response.data) {
            Write-Host "   ?? Total de itens: $($response.data.Count)" -ForegroundColor Cyan
        }
        
        return $true
    } catch {
        Write-Host "   ? Erro: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Verificar se o servidor está rodando
Write-Host "?? Verificando se o servidor está rodando..." -ForegroundColor Yellow
try {
    $healthCheck = Invoke-RestMethod -Uri "http://localhost:5000/api/Products?page=1&pageSize=1" -UseBasicParsing -TimeoutSec 5
    Write-Host "? Servidor está rodando!" -ForegroundColor Green
} catch {
    Write-Host "? Servidor não está rodando ou não está acessível." -ForegroundColor Red
    Write-Host "?? Execute primeiro: .\executar-projeto-automatico.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Testar endpoints
$endpoints = @(
    @{
        Url = "http://localhost:5000/api/Products?page=1&pageSize=3"
        Description = "Lista paginada de produtos"
    },
    @{
        Url = "http://localhost:5000/api/Products?page=1&pageSize=3&categoryId=5"
        Description = "Produtos filtrados por categoria (Mountain Bikes)"
    },
    @{
        Url = "http://localhost:5000/api/Products/771"
        Description = "Detalhes do produto ID 771"
    },
    @{
        Url = "http://localhost:5000/api/Categories"
        Description = "Lista de categorias"
    },
    @{
        Url = "http://localhost:5000/api/Products/771/image"
        Description = "Imagem do produto ID 771"
    }
)

$successCount = 0
$totalTests = $endpoints.Count

foreach ($endpoint in $endpoints) {
    if (Test-Endpoint -Url $endpoint.Url -Description $endpoint.Description) {
        $successCount++
    }
    Write-Host ""
}

# Resumo dos testes
Write-Host "?? Resumo dos Testes:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "? Sucessos: $successCount/$totalTests" -ForegroundColor Green
Write-Host "? Falhas: $($totalTests - $successCount)/$totalTests" -ForegroundColor Red

if ($successCount -eq $totalTests) {
    Write-Host "?? Todos os testes passaram! API funcionando perfeitamente!" -ForegroundColor Green
} else {
    Write-Host "??  Alguns testes falharam. Verifique o servidor e a configuração." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "?? URLs para teste manual:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
Write-Host "   API Docs: http://localhost:5000/api/Products" -ForegroundColor White
