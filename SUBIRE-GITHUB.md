# ?? Como Subir o Projeto SetPar Store para o GitHub

## ?? Pr�-requisitos

Antes de subir o projeto, certifique-se de ter:
- ? **Git instalado** - [Download aqui](https://git-scm.com/downloads)
- ? **Conta GitHub** criada e logada
- ? **Projeto SetPar Store** funcionando localmente

## ?? Configura��o Inicial do Git

### 1. Inicializar o Reposit�rio Git
```bash
# Navegar para o diret�rio do projeto
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar

# Inicializar reposit�rio Git
git init

# Verificar status
git status
```

### 2. Configurar Git (se necess�rio)
```bash
# Configurar nome de usu�rio
git config --global user.name "Seu Nome"

# Configurar email
git config --global user.email "seu.email@exemplo.com"
```

## ?? Criar .gitignore

Crie um arquivo `.gitignore` para ignorar arquivos desnecess�rios:

```bash
# Criar arquivo .gitignore
New-Item -Path ".gitignore" -ItemType File
```

Adicione o seguinte conte�do ao `.gitignore`:
```gitignore
# .NET
bin/
obj/
*.user
*.suo
*.cache
*.dll
*.pdb
*.exe
*.log
*.tmp

# Visual Studio
.vs/
*.sln.docstates

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
build/
dist/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log

# Database
*.mdf
*.ldf

# Temporary files
*.tmp
*.temp
```

## ?? Adicionar Arquivos ao Git

### 1. Adicionar todos os arquivos
```bash
# Adicionar todos os arquivos ao staging
git add .

# Verificar arquivos adicionados
git status
```

### 2. Fazer o primeiro commit
```bash
# Fazer commit inicial
git commit -m "Initial commit: SetPar Store - E-commerce API + React Frontend

- ASP.NET Core Web API com endpoints paginados
- React frontend integrado
- Sistema de produtos com categorias e imagens
- Swagger/OpenAPI documentation
- Scripts PowerShell para execu��o autom�tica"
```

## ?? Conectar com o Reposit�rio GitHub

### 1. Adicionar remote origin
```bash
# Adicionar reposit�rio remoto
git remote add origin https://github.com/Horquichoqui/Shop-C-React.git

# Verificar remotes configurados
git remote -v
```

### 2. Fazer push para o GitHub
```bash
# Fazer push da branch main
git branch -M main
git push -u origin main
```

## ?? Melhorar a Documenta��o no GitHub

### 1. Atualizar README.md para GitHub
O README.md j� est� completo, mas voc� pode adicionar badges:

```markdown
# ?? SetPar Store - E-commerce API + Frontend

[![.NET](https://img.shields.io/badge/.NET-9.0-purple.svg)](https://dotnet.microsoft.com/)
[![React](https://img.shields.io/badge/React-19.2.0-blue.svg)](https://reactjs.org/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-red.svg)](https://www.microsoft.com/sql-server)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Um sistema completo de e-commerce desenvolvido com **ASP.NET Core Web API** e **React**, integrado com banco de dados **SQL Server** usando **Entity Framework Core**.

## ?? Demonstra��o R�pida

```bash
# Clone o reposit�rio
git clone https://github.com/Horquichoqui/Shop-C-React.git
cd Shop-C-React

# Execute o projeto
dotnet run

# Acesse: http://localhost:5000
```

## ?? Screenshots

<!-- Adicione screenshots aqui quando dispon�veis -->

## ?? Links �teis

- **Demo**: http://localhost:5000 (ap�s executar localmente)
- **API Docs**: https://localhost:5001/swagger
- **Issues**: [Reportar problemas](https://github.com/Horquichoqui/Shop-C-React/issues)

<!-- Resto do README existente -->
```

### 2. Criar arquivo LICENSE
```bash
# Criar arquivo LICENSE
New-Item -Path "LICENSE" -ItemType File
```

Adicione uma licen�a MIT:
```text
MIT License

Copyright (c) 2025 SetPar Store

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## ?? Comandos de Atualiza��o

Para futuras atualiza��es do projeto:

```bash
# Verificar status
git status

# Adicionar mudan�as
git add .

# Fazer commit
git commit -m "Descri��o das mudan�as"

# Fazer push
git push origin main
```

## ?? Checklist Final

Antes de finalizar, verifique se:

- [ ] ? Reposit�rio Git inicializado
- [ ] ? .gitignore configurado
- [ ] ? README.md completo e atualizado
- [ ] ? LICENSE adicionado
- [ ] ? Todos os arquivos importantes commitados
- [ ] ? Push realizado para GitHub
- [ ] ? Reposit�rio p�blico e acess�vel
- [ ] ? Links funcionando no README

## ?? URLs Finais

Ap�s o upload, seu projeto estar� dispon�vel em:

- **Reposit�rio**: https://github.com/Horquichoqui/Shop-C-React
- **Clone**: `git clone https://github.com/Horquichoqui/Shop-C-React.git`
- **Issues**: https://github.com/Horquichoqui/Shop-C-React/issues
- **Releases**: https://github.com/Horquichoqui/Shop-C-React/releases

## ?? Suporte

Se encontrar problemas durante o upload:

1. Verifique se est� logado no Git: `git config --list`
2. Confirme as credenciais do GitHub
3. Verifique a conectividade: `ping github.com`
4. Consulte a [documenta��o do Git](https://git-scm.com/doc)

---

**?? Pronto!** Seu projeto SetPar Store agora est� no GitHub e pronto para demonstra��o!
