# Projeto-Compiladores

### 🛠️ Tecnologias e Dependências

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![ANTLR4](https://img.shields.io/badge/ANTLR_4-DC3545?style=for-the-badge&logoColor=white)

Alunos:
  - `Lucca Brito Moura`:
  - `Anthony Magalhães Andrade da Costa`:
  
Professora:
  - `Layse Santos Souza`:

## 📖 Sobre o Projeto
Este projeto é um **Analisador Léxico e Sintático** construído do zero para uma linguagem de programação acadêmica, desenvolvido como requisito da disciplina de Linguagens Formais e Compiladores da UNIT. 

O compilador é capaz de ler um arquivo fonte, gerar uma cadeia de tokens, montar a Árvore Sintática e validar estritamente as regras da gramática, acusando erros estruturais de forma clara e amigável.

## 🚀 Como Executar e Testar
Para facilitar a validação, nós disponibilizamos dois arquivos de teste na raiz do projeto: um com a sintaxe perfeita e outro projetado para quebrar o compilador.

1. Clone o repositório.
2. Abra o projeto na sua IDE.
3. Na classe `Main.java`, passe o caminho absoluto de um dos arquivos de texto como argumento de execução (`args[0]`):
   - Rode com o `teste.txt` para visualizar a mensagem de **Sucesso** no console.
   - Rode com o `teste_erros.txt` para ver o compilador capturando múltiplos erros sintáticos de propósito.

## 🗂️ Estrutura do Código
* `src/main/antlr4/.../Gramatica.g4`: O coração do compilador. Contém todas as regras Léxicas, Sintáticas e injeções de código Java para limites de tokens.
* `src/main/java/.../Main.java`: A classe orquestradora. Lê o arquivo, passa pelo Lexer, entrega para o Parser e audita a contagem de erros finais.
