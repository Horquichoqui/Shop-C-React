# ?? Script de Execução com Abertura Automática do Navegador - SetPar Store
# Execute este script para iniciar o projeto e abrir automaticamente no navegador

Write-Host "?? Iniciando SetPar Store..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Encontrar o diretório do projeto automaticamente
$projectPath = $null
$currentPath = Get-Location

# Procurar pelo arquivo .csproj em diretórios pai
$searchPath = $currentPath
$maxDepth = 5
$depth = 0

while ($depth -lt $maxDepth -and !$projectPath) {
    if (Test-Path "$searchPath\testeSetPar.csproj") {
        $projectPath = $searchPath
        break
    }
    $searchPath = Split-Path $searchPath -Parent
    $depth++
}

# Se não encontrou, tentar o caminho padrão
if (!$projectPath) {
    $defaultPath = "C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar"
    if (Test-Path "$defaultPath\testeSetPar.csproj") {
        $projectPath = $defaultPath
    }
}

if (!$projectPath) {
    Write-Host "? Erro: Não foi possível encontrar o projeto testeSetPar.csproj" -ForegroundColor Red
    Write-Host "?? Diretório atual: $currentPath" -ForegroundColor Yellow
    Write-Host "?? Solução: Execute este script a partir do diretório do projeto ou ajuste o caminho no script" -ForegroundColor Yellow
    exit 1
}

Write-Host "?? Projeto encontrado em: $projectPath" -ForegroundColor Green
Set-Location $projectPath

# Verificar pré-requisitos
Write-Host "?? Verificando pré-requisitos..." -ForegroundColor Yellow

# Verificar .NET
try {
    $dotnetVersion = dotnet --version
    Write-Host "? .NET instalado: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host "? .NET não encontrado. Instale .NET 9.0 SDK" -ForegroundColor Red
    Write-Host "?? Download: https://dotnet.microsoft.com/download/dotnet/9.0" -ForegroundColor Yellow
    exit 1
}

# Verificar Node.js (opcional)
try {
    $nodeVersion = node --version
    Write-Host "? Node.js instalado: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "??  Node.js não encontrado (opcional para frontend integrado)" -ForegroundColor Yellow
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
            Write-Host "  ??  Não foi possível finalizar o processo $process" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ? Porta $port está livre." -ForegroundColor Green
    }
}

# Verificar arquivos essenciais
Write-Host "?? Verificando arquivos essenciais..." -ForegroundColor Yellow
$essentialFiles = @("testeSetPar.csproj", "Program.cs", "appsettings.json")
$missingFiles = @()

foreach ($file in $essentialFiles) {
    if (Test-Path $file) {
        Write-Host "  ? $file encontrado" -ForegroundColor Green
    } else {
        Write-Host "  ? $file não encontrado" -ForegroundColor Red
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "? Arquivos essenciais não encontrados: $($missingFiles -join ', ')" -ForegroundColor Red
    Write-Host "?? Execute o script a partir do diretório correto do projeto." -ForegroundColor Yellow
    exit 1
}

# Restaurar dependências
Write-Host "?? Restaurando dependências..." -ForegroundColor Yellow
try {
    dotnet restore
    Write-Host "? Dependências restauradas com sucesso." -ForegroundColor Green
} catch {
    Write-Host "? Erro ao restaurar dependências." -ForegroundColor Red
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

# Verificar conexão com banco de dados
Write-Host "??? Verificando conexão com banco de dados..." -ForegroundColor Yellow
try {
    # Tentar conectar ao SQL Server
    $connectionString = "Server=localhost,1433;Database=AdventureWorksLT2022;User Id=sa;Password=SetParJ2!;TrustServerCertificate=True;Connection Timeout=5;"
    $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    $connection.Open()
    $connection.Close()
    Write-Host "? Conexão com banco de dados estabelecida com sucesso." -ForegroundColor Green
} catch {
    Write-Host "??  Aviso: Não foi possível conectar ao banco de dados." -ForegroundColor Yellow
    Write-Host "?? Certifique-se de que o SQL Server está rodando e o banco AdventureWorksLT2022 está importado." -ForegroundColor Yellow
    Write-Host "?? Consulte o README.md para instruções de configuração do banco." -ForegroundColor Yellow
}

# Iniciar servidor
Write-Host "?? Iniciando servidor..." -ForegroundColor Yellow
Write-Host ""
Write-Host "?? URLs de acesso:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   API: http://localhost:5000/api/Products" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
Write-Host ""

# Função para abrir o navegador
function Open-Browser {
    param([string]$Url)
    
    try {
        Write-Host "?? Abrindo navegador..." -ForegroundColor Cyan
        Start-Process $Url
        Write-Host "? Navegador aberto com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "??  Não foi possível abrir o navegador automaticamente." -ForegroundColor Yellow
        Write-Host "?? Acesse manualmente: $Url" -ForegroundColor Yellow
    }
}

# Abrir navegador após um delay
Write-Host "? Aguardando servidor iniciar..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Abrir o frontend no navegador
Open-Browser -Url "http://localhost:5000"

Write-Host ""
Write-Host "??  Para parar o servidor, pressione Ctrl+C" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

# Executar o servidor
try {
    dotnet run
} catch {
    Write-Host ""
    Write-Host "? Erro ao iniciar o servidor." -ForegroundColor Red
    Write-Host "?? Verifique se o SQL Server está rodando e acessível." -ForegroundColor Yellow
    Write-Host "?? Consulte o README.md para soluções de problemas comuns." -ForegroundColor Yellow
    exit 1
}
