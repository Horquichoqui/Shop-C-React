# ?? SetPar Store - E-commerce API + Frontend

Um sistema completo de e-commerce desenvolvido com **ASP.NET Core Web API** e **React**, integrado com banco de dados **SQL Server** usando **Entity Framework Core**.

## ?? �ndice

- [?? �ndice](#-�ndice)
- [?? Funcionalidades](#-funcionalidades)
- [??? Tecnologias Utilizadas](#?-tecnologias-utilizadas)
- [?? Estrutura do Projeto](#-estrutura-do-projeto)
- [?? Pr�-requisitos](#?-pr�-requisitos)
- [??? Configura��o do Banco de Dados](#?-configura��o-do-banco-de-dados)
- [?? Como Executar](#-como-executar)
  - [M�todo 1: Execu��o Autom�tica (Recomendado)](#m�todo-1-execu��o-autom�tica-recomendado)
  - [M�todo 2: Execu��o Manual](#m�todo-2-execu��o-manual)
- [?? URLs de Acesso](#-urls-de-acesso)
- [?? API Endpoints](#-api-endpoints)
- [?? Configura��es](#-configura��es)
- [?? Frontend](#-frontend)
- [??? Desenvolvimento](#?-desenvolvimento)
- [?? Solu��o de Problemas](#-solu��o-de-problemas)
- [?? Funcionalidades Implementadas](#-funcionalidades-implementadas)

## ?? Funcionalidades

### Backend (API)
- ? **API RESTful** completa com endpoints paginados
- ? **Filtros por categoria** de produtos
- ? **Sistema de pagina��o** robusto
- ? **Upload e exibi��o de imagens** dos produtos
- ? **DTOs estruturados** para responses padronizadas
- ? **Swagger/OpenAPI** para documenta��o da API
- ? **CORS configurado** para desenvolvimento

### Frontend (React)
- ? **Interface moderna** estilo loja virtual
- ? **Busca din�mica** por nome e cor dos produtos
- ? **Filtros por categoria** em tempo real
- ? **Sistema de pagina��o** visual
- ? **Exibi��o de imagens** com fallback
- ? **Design responsivo** e intuitivo
- ? **Loading states** e tratamento de erros

## ??? Tecnologias Utilizadas

### Backend
- **.NET 9.0** - Framework principal
- **ASP.NET Core Web API** - API RESTful
- **Entity Framework Core** - ORM para banco de dados
- **SQL Server** - Banco de dados
- **Swagger/OpenAPI** - Documenta��o da API
- **CORS** - Cross-Origin Resource Sharing

### Frontend
- **React 19.2.0** - Biblioteca JavaScript
- **Axios** - Cliente HTTP para API calls
- **CSS3** - Estiliza��o moderna
- **JavaScript ES6+** - Linguagem de programa��o

### Ferramentas
- **PowerShell** - Scripts de automa��o
- **Docker** - Containeriza��o (SQL Server)

## ?? Estrutura do Projeto

```
testeSetPar/
??? Controllers/           # Controllers da API
?   ??? ProductsController.cs
?   ??? CategoriesController.cs
?   ??? CustomersController.cs
??? Models/               # Modelos de dados
?   ??? DTOs/            # Data Transfer Objects
?   ?   ??? ProductSummaryDto.cs
?   ?   ??? ProductDetailDto.cs
?   ?   ??? CategoryDto.cs
?   ?   ??? PaginatedResponse.cs
?   ??? Product.cs
?   ??? ProductCategory.cs
?   ??? ProductModel.cs
?   ??? ExercicioContext.cs
??? src/                 # C�digo fonte React
?   ??? js/
?   ?   ??? App.js      # Componente principal
?   ?   ??? services/
?   ?       ??? api.js  # Configura��o Axios
?   ??? App.css         # Estilos principais
?   ??? index.js        # Entry point React
??? wwwroot/            # Arquivos est�ticos servidos
??? build/              # Build de produ��o React
??? Program.cs          # Configura��o da aplica��o
??? appsettings.json    # Configura��es
??? README.md          # Este arquivo
```

## ?? Pr�-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

### Obrigat�rios
- **.NET 9.0 SDK** - [Download aqui](https://dotnet.microsoft.com/download/dotnet/9.0)
- **Node.js 18+** - [Download aqui](https://nodejs.org/)
- **SQL Server** (local ou Docker) - [Download SQL Server](https://www.microsoft.com/sql-server/sql-server-downloads)

### Opcionais (Recomendados)
- **Docker Desktop** - Para executar SQL Server em container
- **Visual Studio 2022** ou **VS Code** - IDEs para desenvolvimento
- **PowerShell 7+** - Para scripts de automa��o

## ??? Configura��o do Banco de Dados

### Op��o 1: SQL Server Local
1. Instale o SQL Server
2. Configure um servidor local na porta 1433
3. Crie um usu�rio `sa` com senha `SetParJ2!`
4. Restaure o banco `AdventureWorksLT2022`

### Op��o 2: Docker (Recomendado)
```bash
# Executar SQL Server em container
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=SetParJ2!" \
  -p 1433:1433 --name sqlserver \
  -d mcr.microsoft.com/mssql/server:2022-latest
```

### Configura��o da Connection String
O arquivo `appsettings.json` j� est� configurado:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost,1433;Database=AdventureWorksLT2022;User Id=sa;Password=SetParJ2!;TrustServerCertificate=True"
  }
}
```

## ?? Como Executar

### M�todo 1: Execu��o Autom�tica (Recomendado)

1. **Navegue para o diret�rio do projeto:**
   ```bash
   cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar
   ```

2. **Execute o servidor:**
   ```bash
   dotnet run
   ```

3. **Acesse a aplica��o:**
   - Frontend: http://localhost:5000
   - API: http://localhost:5000/api/Products
   - Swagger: https://localhost:5001/swagger

### M�todo 2: Execu��o Manual

#### Backend
```bash
# Navegar para o diret�rio do projeto
cd testeSetPar

# Restaurar depend�ncias
dotnet restore

# Compilar o projeto
dotnet build

# Executar o servidor
dotnet run
```

#### Frontend (se necess�rio)
```bash
# Instalar depend�ncias
npm install

# Executar em modo desenvolvimento
npm start

# Ou compilar para produ��o
npm run build
```

## ?? URLs de Acesso

| Servi�o | URL | Descri��o |
|---------|-----|-----------|
| **Frontend** | http://localhost:5000 | Interface da loja |
| **API Produtos** | http://localhost:5000/api/Products | Lista paginada de produtos |
| **API Categorias** | http://localhost:5000/api/Categories | Lista de categorias |
| **Swagger** | https://localhost:5001/swagger | Documenta��o da API |
| **Produto Individual** | http://localhost:5000/api/Products/{id} | Detalhes de um produto |
| **Imagem do Produto** | http://localhost:5000/api/Products/{id}/image | Imagem do produto |

## ?? API Endpoints

### GET /api/Products
**Funcionalidade:** Lista paginada de produtos

**Par�metros:**
- `page` (int, opcional, default: 1) - N�mero da p�gina
- `pageSize` (int, opcional, default: 10) - Itens por p�gina  
- `categoryId` (int, opcional) - Filtrar por categoria

**Exemplo:**
```bash
GET /api/Products?page=1&pageSize=5&categoryId=5
```

**Resposta:**
```json
{
  "page": 1,
  "pageSize": 5,
  "totalPages": 59,
  "totalRecords": 295,
  "data": [
    {
      "productId": 771,
      "name": "Mountain-100 Silver, 38",
      "listPrice": 3399.99,
      "color": "Silver",
      "thumbnailPhotoFileName": "superlight_silver_small.gif",
      "productCategoryId": 5,
      "productCategoryName": "Mountain Bikes",
      "productModelId": 19,
      "productModelName": "Mountain-100"
    }
  ]
}
```

### GET /api/Products/{id}
**Funcionalidade:** Detalhes completos de um produto

**Resposta:**
```json
{
  "productId": 771,
  "name": "Mountain-100 Silver, 38",
  "listPrice": 3399.99,
  "color": "Silver",
  "size": "38",
  "weight": 9230.56,
  "thumbnailPhotoFileName": "superlight_silver_small.gif",
  "productCategoryId": 5,
  "categoryName": "Mountain Bikes",
  "productModelId": 19,
  "modelName": "Mountain-100",
  "description": "XML content with product description..."
}
```

### GET /api/Categories
**Funcionalidade:** Lista todas as categorias

**Resposta:**
```json
[
  {
    "productCategoryId": 1,
    "name": "Bikes"
  },
  {
    "productCategoryId": 2,
    "name": "Components"
  }
]
```

### GET /api/Products/{id}/image
**Funcionalidade:** Retorna a imagem do produto

**Resposta:** Arquivo bin�rio da imagem

## ?? Configura��es

### Portas
- **Frontend/API:** 5000 (HTTP)
- **Swagger:** 5001 (HTTPS)
- **SQL Server:** 1433

### CORS
Configurado para aceitar requisi��es de:
- http://localhost:3000
- http://localhost:3001

### Arquivos Est�ticos
O servidor serve automaticamente os arquivos React compilados da pasta `wwwroot`.

## ?? Frontend

### Funcionalidades da Interface
- **?? Header:** Logo da SetPar Store
- **?? Busca:** Campo de busca din�mica por nome/cor
- **??? Filtros:** Dropdown de categorias
- **?? Produtos:** Grid responsivo com cards dos produtos
- **??? Imagens:** Exibi��o com fallback para produtos sem imagem
- **?? Pagina��o:** Controles de navega��o entre p�ginas
- **?? Estat�sticas:** Contador de produtos e p�ginas

### Componentes Principais
- **App.js:** Componente principal da aplica��o
- **ProductImage:** Componente para exibi��o de imagens com fallback
- **api.js:** Configura��o do cliente HTTP Axios

## ??? Desenvolvimento

### Estrutura de Dados
O projeto utiliza o banco **AdventureWorksLT2022** com as seguintes tabelas principais:
- **Products:** Produtos da loja
- **ProductCategory:** Categorias dos produtos  
- **ProductModel:** Modelos dos produtos

### DTOs (Data Transfer Objects)
- **ProductSummaryDto:** Resumo do produto para listagens
- **ProductDetailDto:** Detalhes completos do produto
- **CategoryDto:** Informa��es da categoria
- **PaginatedResponse<T>:** Resposta paginada gen�rica

### Padr�es Utilizados
- **Repository Pattern** (via Entity Framework)
- **DTO Pattern** para transfer�ncia de dados
- **RESTful API** design
- **Component-based** frontend (React)

## ?? Solu��o de Problemas

### Erro: "Imposs�vel conectar-se ao servidor remoto"
**Causa:** Servidor n�o est� rodando ou porta ocupada

**Solu��o:**
```bash
# Verificar processos na porta 5000
netstat -ano | findstr :5000

# Finalizar processo se necess�rio
taskkill /PID <PID> /F

# Reiniciar o servidor
dotnet run
```

### Erro: "Couldn't find a project to run"
**Causa:** N�o est� no diret�rio correto

**Solu��o:**
```bash
cd testeSetPar
dotnet run
```

### Erro: "Database connection failed"
**Causa:** SQL Server n�o est� rodando ou credenciais incorretas

**Solu��o:**
1. Verificar se SQL Server est� rodando
2. Testar conex�o com SQL Server Management Studio
3. Verificar connection string em `appsettings.json`

### Erro: "Port already in use"
**Causa:** Porta 5000 ou 5001 j� est� sendo usada

**Solu��o:**
```bash
# Usar PowerShell para limpar portas
.\limpar-portas.ps1

# Ou finalizar processo manualmente
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

## ?? Funcionalidades Implementadas

### ? Backend Completo
- [x] API RESTful com todos os endpoints
- [x] Pagina��o e filtros
- [x] Upload e exibi��o de imagens
- [x] DTOs estruturados
- [x] Swagger/OpenAPI
- [x] CORS configurado
- [x] Entity Framework Core
- [x] Tratamento de erros

### ? Frontend Completo  
- [x] Interface moderna de loja
- [x] Busca din�mica
- [x] Filtros por categoria
- [x] Sistema de pagina��o
- [x] Exibi��o de imagens
- [x] Design responsivo
- [x] Loading states
- [x] Tratamento de erros

### ? Integra��o
- [x] Frontend integrado com backend
- [x] Arquivos est�ticos servidos pelo ASP.NET
- [x] CORS configurado
- [x] API calls funcionais
- [x] Fallbacks para imagens

---

## ?? Suporte

Para d�vidas ou problemas:
1. Verifique a se��o [Solu��o de Problemas](#-solu��o-de-problemas)
2. Consulte os logs do servidor no terminal
3. Teste os endpoints diretamente no Swagger
4. Verifique a configura��o do banco de dados

---

**?? Pronto para usar!** Execute `dotnet run` e acesse http://localhost:5000 para come�ar a usar a SetPar Store!
