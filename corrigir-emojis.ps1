# ?? Script para Corrigir Emojis nos Arquivos
# Este script corrige todos os emojis que estão aparecendo como códigos

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
        
        # Correções de emojis
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
        Write-Host "?? Arquivo $file não encontrado" -ForegroundColor Yellow
    }
}

Write-Host "?? Correção de emojis concluída!" -ForegroundColor Green
