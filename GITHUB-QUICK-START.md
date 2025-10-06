# ?? Quick Start - Subir para GitHub

## Método Rápido (Recomendado)

```bash
# 1. Navegar para o projeto
cd C:\Users\GABRIEL\Desktop\gabriel\pessoal\testes\testeSetPar\testeSetPar

# 2. Executar script automático
.\subir-github.ps1
```

## Método Manual

```bash
# 1. Inicializar Git
git init

# 2. Adicionar arquivos
git add .

# 3. Primeiro commit
git commit -m "Initial commit: SetPar Store - E-commerce API + React"

# 4. Conectar ao GitHub
git remote add origin https://github.com/Horquichoqui/Shop-C-React.git

# 5. Subir para GitHub
git branch -M main
git push -u origin main
```

## ? Checklist Pré-Upload

- [ ] ? Projeto funcionando localmente (`dotnet run`)
- [ ] ? README.md completo
- [ ] ? .gitignore configurado
- [ ] ? LICENSE adicionado
- [ ] ? Git configurado (nome e email)

## ?? URLs Finais

Após upload:
- **Repositório**: https://github.com/Horquichoqui/Shop-C-React
- **Clone**: `git clone https://github.com/Horquichoqui/Shop-C-React.git`
- **Issues**: https://github.com/Horquichoqui/Shop-C-React/issues

## ?? Comandos de Atualização

```bash
# Para futuras mudanças
git add .
git commit -m "Descrição da mudança"
git push origin main
```

---

**?? Objetivo**: Projeto demonstrativo da SetPar Store no GitHub
