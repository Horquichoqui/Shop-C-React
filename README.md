# SetPar Store - E-commerce API + Frontend 

Um sistema completo de e-commerce desenvolvido com **ASP.NET Core Web API** e **React**, integrado com banco de dados **SQL Server** usando **Entity Framework Core**.

## Tutorial Completo - Como Fazer o Sistema Funcionar

### Pré-requisitos

Antes de começar, certifique-se de ter instalado:

1. **.NET 9.0 SDK** - [Download aqui](https://dotnet.microsoft.com/download/dotnet/9.0)
2. **SQL Server** - [Download aqui](https://www.microsoft.com/sql-server/sql-server-downloads)
3. **Node.js** (opcional) - [Download aqui](https://nodejs.org/)
4. **Git** (opcional) - [Download aqui](https://git-scm.com/downloads)

### Passo 1: Obter o Projeto

```bash
# Clone o repositório (se usando Git)
git clone https://github.com/Horquichoqui/Shop-C-React.git
cd Shop-C-React

# OU baixe o projeto e extraia para uma pasta
# Navegue para a pasta do projeto
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar
```

###  Passo 2: Configurar o Banco de Dados

#### 2.1 Instalar SQL Server
- Instale o SQL Server Express ou Developer Edition
- Durante a instalação, anote a senha do usuário `sa`
- Certifique-se de que o SQL Server está rodando

#### 2.2 Configurar Connection String
Edite o arquivo `modules/backend/config/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost,1433;Database=AdventureWorksLT2022;User Id=sa;Password=SUA_SENHA_AQUI;TrustServerCertificate=True"
  }
}
```

** Importante:** Substitua `SUA_SENHA_AQUI` pela senha do seu SQL Server.

#### 2.3 Importar o Banco de Dados AdventureWorksLT2022
O projeto utiliza o banco de dados de exemplo **AdventureWorksLT2022** da Microsoft:

1. **Download do banco**: Baixe o arquivo `AdventureWorksLT2022.bak` da [Microsoft](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure)
2. **Restaurar no SQL Server**:
   ```sql
   -- Conectar ao SQL Server Management Studio e executar:
   RESTORE DATABASE AdventureWorksLT2022 
   FROM DISK = 'C:\caminho\para\AdventureWorksLT2022.bak'
   WITH REPLACE;
   ```

**⚠️ Alternativa**: Se você não tiver o banco AdventureWorksLT2022, pode usar qualquer banco SQL Server existente, apenas ajuste a connection string no `appsettings.json`.

### Passo 3: Configurar e Executar o Projeto

#### 3.1 Navegar para o Diretório
```bash
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar
```

#### 3.2 Método Automático (RECOMENDADO)

**Script Unificado com Parâmetros:**
```bash
# Execução normal (pergunta se quer abrir navegador)
.\executar.ps1

# Execução com navegador automático
.\executar.ps1 -AutoBrowser

# Execução sem navegador
.\executar.ps1 -NoBrowser

# Execução inteligente (abre navegador apenas quando servidor estiver rodando)
.\executar-inteligente.ps1 -AutoBrowser
```

**🎯 Este script faz tudo automaticamente:**
- ✅ Verifica pré-requisitos (.NET, Node.js)
- ✅ Limpa portas em uso
- ✅ Verifica arquivos essenciais
- ✅ Restaura dependências
- ✅ Compila o projeto
- ✅ Testa conexão com banco
- ✅ Inicia o servidor
- ✅ **Opção inteligente**: Pergunta se quer abrir navegador ou usa parâmetros

#### 3.3 Método Manual
```bash
# Verificar arquivos essenciais
dir *.csproj, Program.cs, appsettings.json

# Restaurar dependências
dotnet restore

# Compilar projeto
dotnet build

# Executar o sistema
dotnet run
```

#### 3.4 Testar a API (Opcional)
```bash
# Teste completo da API
.\testar-api.ps1

# Teste rápido (apenas endpoints essenciais)
.\testar-api.ps1 -Quick

# Mostrar ajuda
.\testar-api.ps1 -Help
```

### Passo 4: Acessar o Sistema

Após executar `dotnet run`, o sistema estará disponível em:

| Serviço | URL | Descrição |
|---------|-----|-----------|
| ** Loja (Frontend)** | http://localhost:5000 | Interface principal da loja |
| ** API Produtos** | http://localhost:5000/api/Products | Endpoint da API |
| ** Documentação** | https://localhost:5001/swagger | Swagger UI |

###  Passo 5: Verificar se Está Funcionando

#### 5.1 Testar o Frontend
1. Abra o navegador em `http://localhost:5000`
2. Você deve ver a interface da "SetPar Store"
3. Produtos devem aparecer automaticamente
4. Teste a busca e filtros

#### 5.2 Testar a API
```bash
# Usar o script de teste
.\scripts\testing\testar-api-CORRIGIDO.ps1

# OU testar manualmente
curl http://localhost:5000/api/Products
```

### Solução de Problemas Comuns

####  Erro: "Cannot connect to database"
**Solução:**
1. Verifique se o SQL Server está rodando
2. Confirme se o banco AdventureWorksLT2022 foi importado corretamente
3. Confirme a connection string em `modules/backend/config/appsettings.json`
4. Teste a conexão:
```bash
sqlcmd -S localhost,1433 -U sa -P SUA_SENHA -d AdventureWorksLT2022
```

####  Erro: "Port 5000 is already in use"
**Solução:**
```bash
# Usar o script para limpar portas
.\scripts\execution\limpar-portas.ps1

# OU manualmente
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

####  Erro: "dotnet command not found"
**Solução:**
1. Instale o .NET 9.0 SDK
2. Reinicie o terminal
3. Verifique: `dotnet --version`

####  Frontend não carrega
**Solução:**
1. Verifique se o backend está rodando
2. Confirme que está acessando `http://localhost:5000` (não https)
3. Verifique o console do navegador para erros

### Funcionalidades do Sistema

####  Para Usuários
- **Navegar por produtos** - Visualizar catálogo completo
- **Buscar produtos** - Por nome ou cor
- **Filtrar por categoria** - Mountain Bikes, Road Bikes, etc.
- **Ver detalhes** - Clique em "Ver Detalhes" para abrir modal
- **Visualizar imagens** - Imagens automáticas dos produtos
- **Paginação** - Navegar entre páginas de produtos

#### Para Desenvolvedores
- **API RESTful** - Endpoints documentados
- **Swagger UI** - Teste da API em tempo real
- **Logs detalhados** - Para debugging
- **Estrutura modular** - Fácil manutenção

## Estrutura do Projeto

```
testeSetPar/
 modules/                    # Módulos organizados
     backend/               # Backend ASP.NET Core
       api/controllers/       # Controllers da API
       api/dtos/             # Data Transfer Objects
       data/models/          # Modelos de entidades
       data/context/         # DbContext do EF Core
       config/               # Configurações
    frontend/              # Frontend React
        pages/                # Páginas principais
        services/             # Serviços HTTP
        styles/               # Arquivos CSS
 scripts/                   # Scripts de automação
    execution/                # Scripts de execução
    testing/                  # Scripts de teste
    deployment/               # Scripts de deployment
 documentation/             # Documentação organizada
    setup/                    # Guias de configuração
    guides/                   # Guias de uso
    api/                      # Documentação da API
 testeSetPar.csproj            # Projeto .NET
 package.json                  # Dependências React
 README.md                     # Este arquivo
```

## Métodos de Execução

### Método 1: Automação Completa (RECOMENDADO)

**Script Unificado com Parâmetros:**
```bash
# Navegar para o diretório do projeto
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar

# Execução normal (pergunta se quer abrir navegador)
.\executar.ps1

# Execução com navegador automático
.\executar.ps1 -AutoBrowser

# Execução sem navegador
.\executar.ps1 -NoBrowser
```

### Método 2: Execução Manual
```bash
# Navegar para o diretório do projeto
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar

# Verificar se os arquivos essenciais estão presentes
dir *.csproj, Program.cs, appsettings.json

# Executar o projeto
dotnet run
```

### Método 3: Teste da API
```bash
# Testar todos os endpoints automaticamente
.\testar-api-automatico.ps1
```

### Método 4: Solução de Problemas
Se encontrar erros, siga esta sequência:

```bash
# 1. Limpar e restaurar dependências
dotnet clean
dotnet restore

# 2. Compilar o projeto
dotnet build

# 3. Executar novamente
dotnet run
```

##  Tecnologias

### Backend
- **.NET 9.0** - Framework principal
- **ASP.NET Core Web API** - API RESTful
- **Entity Framework Core** - ORM para banco de dados
- **SQL Server** - Banco de dados

### Frontend
- **React 19.2.0** - Biblioteca JavaScript
- **Axios** - Cliente HTTP para API calls
- **CSS3** - Estilização moderna

## Links Úteis

- **Demo**: http://localhost:5000 (após executar localmente)
- **API Docs**: https://localhost:5001/swagger
- **Repositório**: https://github.com/Horquichoqui/Shop-C-React

---
