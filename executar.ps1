# ?? Script Unificado de Execução - SetPar Store
# Execute este script para iniciar o projeto automaticamente
# Parâmetros disponíveis:
#   -AutoBrowser : Abre automaticamente o navegador
#   -NoBrowser   : Não abre o navegador (padrão)

param(
    [switch]$AutoBrowser,
    [switch]$NoBrowser
)

Write-Host "?? Iniciando SetPar Store..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Encontrar o diretório do projeto automaticamente
$projectPath = $null
$currentPath = Get-Location

Write-Host "?? Procurando projeto..." -ForegroundColor Yellow

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

# Função para abrir o navegador em background
function Start-BrowserWithDelay {
    param([string]$Url, [int]$DelaySeconds = 3)
    
    Start-Job -ScriptBlock {
        param($Url, $Delay)
        Start-Sleep -Seconds $Delay
        try {
            Start-Process $Url
            Write-Host "?? Navegador aberto automaticamente!" -ForegroundColor Green
        } catch {
            Write-Host "??  Não foi possível abrir o navegador automaticamente." -ForegroundColor Yellow
            Write-Host "?? Acesse manualmente: $Url" -ForegroundColor Yellow
        }
    } -ArgumentList $Url, $DelaySeconds
}

# Iniciar servidor
Write-Host "?? Iniciando servidor..." -ForegroundColor Yellow
Write-Host ""
Write-Host "?? URLs de acesso:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5000" -ForegroundColor White
Write-Host "   API: http://localhost:5000/api/Products" -ForegroundColor White
Write-Host "   Swagger: https://localhost:5001/swagger" -ForegroundColor White
Write-Host ""

# Função para verificar se o servidor está rodando
function Test-ServerRunning {
    param([string]$Url, [int]$MaxAttempts = 30, [int]$DelaySeconds = 2)
    
    Write-Host "?? Verificando se o servidor está rodando..." -ForegroundColor Yellow
    
    for ($i = 1; $i -le $MaxAttempts; $i++) {
        try {
            $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
            if ($response.StatusCode -eq 200) {
                Write-Host "? Servidor está rodando! (tentativa $i/$MaxAttempts)" -ForegroundColor Green
                return $true
            }
        } catch {
            Write-Host "? Aguardando servidor iniciar... (tentativa $i/$MaxAttempts)" -ForegroundColor Yellow
        }
        
        if ($i -lt $MaxAttempts) {
            Start-Sleep -Seconds $DelaySeconds
        }
    }
    
    Write-Host "??  Servidor não respondeu após $MaxAttempts tentativas." -ForegroundColor Yellow
    return $false
}

# Configurar abertura do navegador baseado nos parâmetros
$shouldOpenBrowser = $false

if ($AutoBrowser) {
    $shouldOpenBrowser = $true
    Write-Host "?? Navegador será aberto automaticamente quando o servidor estiver pronto..." -ForegroundColor Cyan
} elseif (!$NoBrowser) {
    # Se não especificou parâmetros, perguntar ao usuário
    Write-Host "?? Deseja abrir o navegador automaticamente quando o servidor estiver pronto?" -ForegroundColor Yellow
    $response = Read-Host "Digite 's' para sim ou 'n' para não (pressione Enter para sim)"
    
    if ($response -eq "" -or $response.ToLower() -eq "s" -or $response.ToLower() -eq "sim") {
        $shouldOpenBrowser = $true
        Write-Host "?? Navegador será aberto automaticamente quando o servidor estiver pronto..." -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "??  Para parar o servidor, pressione Ctrl+C" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

# Executar o servidor em background
Write-Host "?? Iniciando servidor em background..." -ForegroundColor Yellow

try {
    # Iniciar o servidor em background
    $serverJob = Start-Job -ScriptBlock {
        Set-Location $using:projectPath
        dotnet run
    }
    
    # Se deve abrir o navegador, verificar se o servidor está rodando
    if ($shouldOpenBrowser) {
        $serverRunning = Test-ServerRunning -Url "http://localhost:5000" -MaxAttempts 30 -DelaySeconds 2
        
        if ($serverRunning) {
            Open-Browser -Url "http://localhost:5000"
        } else {
            Write-Host "??  Não foi possível verificar se o servidor está rodando." -ForegroundColor Yellow
            Write-Host "?? Acesse manualmente: http://localhost:5000" -ForegroundColor Yellow
        }
    }
    
    # Aguardar o job do servidor
    Wait-Job $serverJob
    
    # Verificar se houve erro no servidor
    if ($serverJob.State -eq "Failed") {
        Write-Host ""
        Write-Host "? Erro ao iniciar o servidor." -ForegroundColor Red
        Write-Host "?? Verifique se o SQL Server está rodando e acessível." -ForegroundColor Yellow
        Write-Host "?? Consulte o README.md para soluções de problemas comuns." -ForegroundColor Yellow
        Receive-Job $serverJob
        Remove-Job $serverJob
        exit 1
    }
    
    Remove-Job $serverJob
    
} catch {
    Write-Host ""
    Write-Host "? Erro ao iniciar o servidor." -ForegroundColor Red
    Write-Host "?? Verifique se o SQL Server está rodando e acessível." -ForegroundColor Yellow
    Write-Host "?? Consulte o README.md para soluções de problemas comuns." -ForegroundColor Yellow
    exit 1
}
