package org.compilador;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;

import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Erro: Por favor, informe o caminho do arquivo de codigo fonte.");
            return;
        }

        String arquivoOrigem = args[0];

        try {
            CharStream cs = CharStreams.fromFileName(arquivoOrigem);

            GramaticaLexer lexer = new GramaticaLexer(cs);

            System.out.println("--- INICIANDO ANALISE LEXICA ---");

            Token t = lexer.nextToken();
            while (t.getType() != Token.EOF) {
                String nomeToken = GramaticaLexer.VOCABULARY.getSymbolicName(t.getType());

                System.out.printf("[Linha %02d, Coluna %02d] -> Tipo: %-12s | Valor/Atributo: '%s'%n",
                        t.getLine(),
                        t.getCharPositionInLine(),
                        nomeToken,
                        t.getText());

                t = lexer.nextToken(); // Pega o próximo token
            }

            System.out.println("--- ANALISE LEXICA CONCLUIDA COM SUCESSO ---");

        } catch (IOException e) {
            System.err.println("Erro ao ler o arquivo: " + e.getMessage());
        } catch (RuntimeException e) {
            System.err.println(e.getMessage());
        }
    }
}