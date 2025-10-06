# ?? Script para Corrigir Emojis nos Arquivos
# Este script corrige todos os emojis que est�o aparecendo como c�digos

Write-Host "?? Corrigindo emojis nos arquivos..." -ForegroundColor Cyan

$files = @(
    "README.md",
    "executar-projeto.ps1",
    "testar-api.ps1",
    "subir-github.ps1",
    "SUBIRE-GITHUB.md",
    "GITHUB-QUICK-START.md"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "?? Corrigindo $file..." -ForegroundColor Yellow
        
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # Corre��es de emojis
        $content = $content -replace '\\?\?\?', '???'
        $content = $content -replace '\\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '???'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '?'
        $content = $content -replace '\\?\?\?', '?'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        $content = $content -replace '\\?\?\?', '??'
        
        Set-Content $file -Value $content -Encoding UTF8
        Write-Host "? $file corrigido!" -ForegroundColor Green
    } else {
        Write-Host "?? Arquivo $file n�o encontrado" -ForegroundColor Yellow
    }
}

Write-Host "?? Corre��o de emojis conclu�da!" -ForegroundColor Green
