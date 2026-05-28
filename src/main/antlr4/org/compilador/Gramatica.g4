grammar Gramatica;

options {
    caseInsensitive = true;
}

@lexer::members {
    private void reportarErroLexico() {
        throw new RuntimeException(
            "Erro Lexico! Linha " + getLine() + ", Coluna " + getCharPositionInLine() + " -> Token nao reconhecido: " + getText()
        );
    }
}

prog : EOF ;

//Regras do Lexer

PROGRAM : 'program' ;

INTEGER : 'integer' ;
BOOLEAN : 'boolean' ;

BEGIN   : 'begin' ;

END     : 'end' ;

WHILE   : 'while' ;

DO      : 'do' ;

READ    : 'read' ;

VAR     : 'var' ;

FALSE   : 'false' ;

TRUE    : 'true' ;

WRITE   : 'write' ;

OPAD    : '+' | '-' ;

OPMULT  : '*' | '/' ;

OPREL   : '>=' | '<=' | '==' | '<>' | '>' | '<' ;

OPLOG   : 'OR' | 'AND' ;

OPNEG   : '~' ;

PVIG    : ';' ;

PONTO   : '.' ;

DPONTOS : ':' ;

VIG     : ',' ;

ABPAR   : '(' ;

FPAR    : ')' ;

ATRIB   : ':=' ;

//Identificadores

IDENTIFIER : [a-z][a-z0-9]* {
        if (getText().length() > 16) {
            setText(getText().substring(0, 16));
        }
    }
;

CTE : [0-9]+
    {
        try {
            int valor = Integer.parseInt(getText());
            if (valor > 32767) {
                throw new RuntimeException("Erro Lexico! Linha " + getLine() + ": Constante inteira excedeu o limite de 2 bytes (32767): " + getText());
            }
        } catch (NumberFormatException e) {
            throw new RuntimeException("Erro Lexico! Linha " + getLine() + ": Constante inteira absurdamente grande: " + getText());
        }
    }
;

//Erros

CADEIA : '"' ~["]* '"' ;

ESPACO     : [ \t\n\r]+ -> skip ;

COMENTARIO : '/' ~[/]* '/' -> skip ;

ERRO : . { reportarErroLexico(); } ;