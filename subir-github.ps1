# ?? Script para Subir Projeto SetPar Store para o GitHub
# Execute este script para fazer upload automático do projeto

Write-Host "?? Subindo SetPar Store para o GitHub..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Verificar se está no diretório correto
if (!(Test-Path "testeSetPar.csproj")) {
    Write-Host "? Erro: Execute este script a partir do diretório testeSetPar/" -ForegroundColor Red
    Write-Host "?? Diretório atual: $(Get-Location)" -ForegroundColor Yellow
    Write-Host "?? Solução: Execute: cd testeSetPar" -ForegroundColor Yellow
    exit 1
}

# Verificar se Git está instalado
try {
    $gitVersion = git --version
    Write-Host "? Git instalado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "? Git não encontrado. Instale Git primeiro." -ForegroundColor Red
    Write-Host "?? Download: https://git-scm.com/downloads" -ForegroundColor Yellow
    exit 1
}

# Verificar se já é um repositório Git
if (!(Test-Path ".git")) {
    Write-Host "?? Inicializando repositório Git..." -ForegroundColor Yellow
    git init
    Write-Host "? Repositório Git inicializado." -ForegroundColor Green
} else {
    Write-Host "? Repositório Git já existe." -ForegroundColor Green
}

# Verificar configuração do Git
Write-Host "?? Verificando configuração do Git..." -ForegroundColor Yellow
$userName = git config user.name
$userEmail = git config user.email

if ([string]::IsNullOrEmpty($userName) -or [string]::IsNullOrEmpty($userEmail)) {
    Write-Host "??  Configuração do Git incompleta." -ForegroundColor Yellow
    Write-Host "?? Configure seu nome e email do Git:" -ForegroundColor Cyan
    Write-Host "   git config --global user.name 'Seu Nome'" -ForegroundColor White
    Write-Host "   git config --global user.email 'seu.email@exemplo.com'" -ForegroundColor White
    Write-Host ""
    $continue = Read-Host "Deseja continuar mesmo assim? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit 1
    }
} else {
    Write-Host "? Git configurado: $userName <$userEmail>" -ForegroundColor Green
}

# Adicionar todos os arquivos
Write-Host "?? Adicionando arquivos ao Git..." -ForegroundColor Yellow
git add .

# Verificar status
Write-Host "?? Status dos arquivos:" -ForegroundColor Yellow
git status --short

# Fazer commit
Write-Host "?? Fazendo commit..." -ForegroundColor Yellow
$commitMessage = @"
Initial commit: SetPar Store - E-commerce API + React Frontend

- ASP.NET Core Web API com endpoints paginados
- React frontend integrado
- Sistema de produtos com categorias e imagens  
- Swagger/OpenAPI documentation
- Scripts PowerShell para execução automática
- Banco AdventureWorksLT2022 integrado
- Interface moderna com busca e filtros
"@

git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host "? Commit realizado com sucesso." -ForegroundColor Green
} else {
    Write-Host "? Erro ao fazer commit. Verifique os arquivos." -ForegroundColor Red
    exit 1
}

# Configurar branch main
Write-Host "?? Configurando branch main..." -ForegroundColor Yellow
git branch -M main

# Adicionar remote origin
Write-Host "?? Configurando repositório remoto..." -ForegroundColor Yellow
$remoteExists = git remote get-url origin 2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "? Remote origin já configurado: $remoteExists" -ForegroundColor Green
} else {
    Write-Host "?? Adicionando remote origin..." -ForegroundColor Yellow
    git remote add origin https://github.com/Horquichoqui/Shop-C-React.git
    Write-Host "? Remote origin configurado." -ForegroundColor Green
}

# Fazer push para GitHub
Write-Host "?? Fazendo push para o GitHub..." -ForegroundColor Yellow
Write-Host "??  Certifique-se de estar logado no GitHub!" -ForegroundColor Yellow

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "?? PROJETO SUBIDO COM SUCESSO!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "?? Repositório: https://github.com/Horquichoqui/Shop-C-React" -ForegroundColor Cyan
    Write-Host "?? Clone: git clone https://github.com/Horquichoqui/Shop-C-React.git" -ForegroundColor White
    Write-Host "?? Issues: https://github.com/Horquichoqui/Shop-C-React/issues" -ForegroundColor White
    Write-Host ""
    Write-Host "?? Próximos passos:" -ForegroundColor Yellow
    Write-Host "   1. Verifique o repositório no GitHub" -ForegroundColor White
    Write-Host "   2. Configure GitHub Pages se necessário" -ForegroundColor White
    Write-Host "   3. Adicione screenshots ao README" -ForegroundColor White
    Write-Host "   4. Crie releases para versões" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "? Erro ao fazer push para o GitHub." -ForegroundColor Red
    Write-Host "?? Possíveis soluções:" -ForegroundColor Yellow
    Write-Host "   1. Verifique se está logado no GitHub" -ForegroundColor White
    Write-Host "   2. Confirme as credenciais: git config --list" -ForegroundColor White
    Write-Host "   3. Teste a conectividade: ping github.com" -ForegroundColor White
    Write-Host "   4. Verifique se o repositório existe no GitHub" -ForegroundColor White
}

Write-Host ""
Write-Host "?? Para futuras atualizações:" -ForegroundColor Cyan
Write-Host "   git add ." -ForegroundColor White
Write-Host "   git commit -m 'Descrição das mudanças'" -ForegroundColor White
Write-Host "   git push origin main" -ForegroundColor White
