# ?? Script de Execu��o Autom�tica - SetPar Store
# Execute este script para iniciar o projeto automaticamente

Write-Host "?? Iniciando SetPar Store..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Verificar se est� no diret�rio correto
if (!(Test-Path "testeSetPar.csproj")) {
    Write-Host "? Erro: Execute este script a partir do diret�rio testeSetPar/" -ForegroundColor Red
    Write-Host "?? Diret�rio atual: $(Get-Location)" -ForegroundColor Yellow
    Write-Host "?? Solu��o: Execute: cd testeSetPar" -ForegroundColor Yellow
    exit 1
}

# Verificar pr�-requisitos
Write-Host "?? Verificando pr�-requisitos..." -ForegroundColor Yellow

# Verificar .NET
try {
    $dotnetVersion = dotnet --version
    Write-Host "? .NET instalado: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host "? .NET n�o encontrado. Instale .NET 9.0 SDK" -ForegroundColor Red
    exit 1
}

# Verificar Node.js (opcional)
try {
    $nodeVersion = node --version
    Write-Host "? Node.js instalado: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "??  Node.js n�o encontrado (opcional para frontend integrado)" -ForegroundColor Yellow
}

# Limpar portas em uso
Write-Host "?? Limpando portas em uso..." -ForegroundColor Yellow
$portsToClean = @(5000, 5001)

foreach ($port in $portsToClean) {
    $process = (netstat -ano | Select-String ":$port\s+LISTENING" | ForEach-Object { $_.ToString().Split(' ')[-1] } | Select-Object -First 1)
    if ($process) {
        Write-Host "  ?? Finalizando processo $process na porta $port..." -ForegroundColor Yellow
        try {
            Stop-Process -Id $process -Force -ErrorAction Stop
            Write-Host "  ? Processo finalizado com sucesso." -ForegroundColor Green
        } catch {
            Write-Host "  ??  N�o foi poss�vel finalizar o processo $process" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ? Porta $port est� livre." -ForegroundColor Green
    }
}

# Restaurar depend�ncias
Write-Host "?? Restaurando depend�ncias..." -ForegroundColor Yellow
try {
    dotnet restore
    Write-Host "? Depend�ncias restauradas com sucesso." -ForegroundColor Green
} catch {
    Write-Host "? Erro ao restaurar depend�ncias." -ForegroundColor Red
    exit 1
}

# Compilar projeto
Write-Host "?? Compilando projeto..." -ForegroundColor Yellow
try {
    dotnet build
    Write-Host "? Projeto compilado com sucesso." -ForegroundColor Green
} catch {
    Write-Host "? Erro ao compilar projeto." -ForegroundColor Red
    exit 1
}

# Iniciar servidor
Write-Host "?? Iniciando servidor..." -ForegroundColor Yellow
Write-Host ""
Write-Host "?? URLs de acesso:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   API: http://localhost:5000/api/Products" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
Write-Host ""
Write-Host "??  Para parar o servidor, pressione Ctrl+C" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

# Executar o servidor
try {
    dotnet run
} catch {
    Write-Host ""
    Write-Host "? Erro ao iniciar o servidor." -ForegroundColor Red
    Write-Host "?? Verifique se o SQL Server est� rodando e acess�vel." -ForegroundColor Yellow
    exit 1
}
