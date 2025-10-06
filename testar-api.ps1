# ?? Script Unificado de Teste da API - SetPar Store
# Execute este script para testar todos os endpoints da API
# Parâmetros disponíveis:
#   -Quick    : Teste rápido (apenas endpoints essenciais)
#   -Full     : Teste completo (todos os endpoints)
#   -Help     : Mostra ajuda

param(
    [switch]$Quick,
    [switch]$Full,
    [switch]$Help
)

if ($Help) {
    Write-Host "?? Script de Teste da API - SetPar Store" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "?? Parâmetros disponíveis:" -ForegroundColor Yellow
    Write-Host "   -Quick    : Teste rápido (apenas endpoints essenciais)" -ForegroundColor White
    Write-Host "   -Full     : Teste completo (todos os endpoints)" -ForegroundColor White
    Write-Host "   -Help     : Mostra esta ajuda" -ForegroundColor White
    Write-Host ""
    Write-Host "?? Exemplos de uso:" -ForegroundColor Yellow
    Write-Host "   .\testar-api.ps1           # Teste padrão (completo)" -ForegroundColor White
    Write-Host "   .\testar-api.ps1 -Quick    # Teste rápido" -ForegroundColor White
    Write-Host "   .\testar-api.ps1 -Full     # Teste completo" -ForegroundColor White
    Write-Host "   .\testar-api.ps1 -Help     # Mostrar ajuda" -ForegroundColor White
    exit 0
}

Write-Host "?? Testando API da SetPar Store..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Função para testar endpoint
function Test-Endpoint {
    param(
        [string]$Url,
        [string]$Description,
        [bool]$Essential = $false
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
    Write-Host "?? Execute primeiro: .\executar.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Definir endpoints baseado no tipo de teste
if ($Quick) {
    Write-Host "? Executando teste rápido..." -ForegroundColor Cyan
    $endpoints = @(
        @{
            Url = "http://localhost:5000/api/Products?page=1&pageSize=3"
            Description = "Lista paginada de produtos (essencial)"
            Essential = $true
        },
        @{
            Url = "http://localhost:5000/api/Categories"
            Description = "Lista de categorias (essencial)"
            Essential = $true
        }
    )
} else {
    Write-Host "?? Executando teste completo..." -ForegroundColor Cyan
    $endpoints = @(
        @{
            Url = "http://localhost:5000/api/Products?page=1&pageSize=3"
            Description = "Lista paginada de produtos"
            Essential = $true
        },
        @{
            Url = "http://localhost:5000/api/Products?page=1&pageSize=3&categoryId=5"
            Description = "Produtos filtrados por categoria (Mountain Bikes)"
            Essential = $false
        },
        @{
            Url = "http://localhost:5000/api/Products/771"
            Description = "Detalhes do produto ID 771"
            Essential = $false
        },
        @{
            Url = "http://localhost:5000/api/Categories"
            Description = "Lista de categorias"
            Essential = $true
        },
        @{
            Url = "http://localhost:5000/api/Products/771/image"
            Description = "Imagem do produto ID 771"
            Essential = $false
        }
    )
}

$successCount = 0
$totalTests = $endpoints.Count
$essentialTests = ($endpoints | Where-Object { $_.Essential }).Count
$essentialSuccess = 0

foreach ($endpoint in $endpoints) {
    $result = Test-Endpoint -Url $endpoint.Url -Description $endpoint.Description -Essential $endpoint.Essential
    if ($result) {
        $successCount++
        if ($endpoint.Essential) {
            $essentialSuccess++
        }
    }
    Write-Host ""
}

# Resumo dos testes
Write-Host "?? Resumo dos Testes:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "? Sucessos: $successCount/$totalTests" -ForegroundColor Green
Write-Host "? Falhas: $($totalTests - $successCount)/$totalTests" -ForegroundColor Red

if ($essentialTests -gt 0) {
    Write-Host "?? Testes Essenciais: $essentialSuccess/$essentialTests" -ForegroundColor Cyan
}

if ($successCount -eq $totalTests) {
    Write-Host "?? Todos os testes passaram! API funcionando perfeitamente!" -ForegroundColor Green
} elseif ($essentialSuccess -eq $essentialTests) {
    Write-Host "? Testes essenciais passaram! API funcional." -ForegroundColor Green
    Write-Host "??  Alguns testes opcionais falharam." -ForegroundColor Yellow
} else {
    Write-Host "? Alguns testes essenciais falharam. Verifique o servidor e a configuração." -ForegroundColor Red
}

Write-Host ""
Write-Host "?? URLs para teste manual:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
Write-Host "   API Docs: http://localhost:5000/api/Products" -ForegroundColor White

Write-Host ""
Write-Host "?? Comandos úteis:" -ForegroundColor Cyan
Write-Host "   .\testar-api.ps1 -Quick    # Teste rápido" -ForegroundColor White
Write-Host "   .\testar-api.ps1 -Full     # Teste completo" -ForegroundColor White
Write-Host "   .\testar-api.ps1 -Help     # Mostrar ajuda" -ForegroundColor White
