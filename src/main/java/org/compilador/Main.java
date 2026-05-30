package org.compilador;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Erro: Por favor, informe o caminho do arquivo de codigo fonte.");
            return;
        }

        String arquivoOrigem = args[0];

        try {
            CharStream cs = CharStreams.fromFileName(arquivoOrigem);
            GramaticaLexer lexer = new GramaticaLexer(cs);
            CommonTokenStream tokens = new CommonTokenStream(lexer);

            System.out.println("--- INICIANDO COMPILAÇÃO ---");

            GramaticaParser parser = new GramaticaParser(tokens);
            ParseTree tree = parser.prog();

            if (parser.getNumberOfSyntaxErrors() == 0) {
                System.out.println("Analises Lexica e Sintática concluidas com sucesso!");
                System.out.println("O codigo fonte está respeitando todas as regras da gramática.");
            } else {
                System.out.println("Falha na compilacao: Foram encontrados " + parser.getNumberOfSyntaxErrors() + " erro(s) de sintaxe.");
            }

        } catch (IOException e) {
            System.out.println("Erro ao ler o arquivo: " + e.getMessage());
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
        }
    }
}