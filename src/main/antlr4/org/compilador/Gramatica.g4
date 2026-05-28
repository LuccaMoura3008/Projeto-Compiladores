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

//Regras do Parser

prog     : PROGRAM IDENTIFIER PVIG decls cmdComp PONTO EOF ;

decls    : VAR listDecl
         |
         ;

listDecl : declTip
         | declTip listDecl
         ;

declTip  : listId DPONTOS tip PVIG ;

listId   : IDENTIFIER
         | IDENTIFIER VIG listId
         ;

tip      : INTEGER | BOOLEAN | STRING ;

cmdComp  : BEGIN listCmd END ;

listCmd  : cmd
         | cmd PVIG listCmd
         ;

cmd      : cmdIf | cmdWhile | cmdRead | cmdWrite | cmdAtrib | cmdComp ;

cmdIf    : IF expr THEN cmd
         | IF expr THEN cmd ELSE cmd
         ;

cmdWhile : WHILE expr DO cmd ;

cmdRead  : READ ABPAR listId FPAR ;

cmdWrite : WRITE ABPAR listW FPAR ;

listW    : elemW
         | elemW VIG listW
         ;

elemW    : expr
         | CADEIA
         ;

cmdAtrib : IDENTIFIER ATRIB expr ;

expr     : expr OPLOG exprRel
         | exprRel
         ;

exprRel  : exprRel OPREL termo
         | termo
         ;

termo    : termo OPAD fator
         | fator
         ;

fator    : fator OPMULT lego
         | lego
         ;

lego     : IDENTIFIER
         | CTE
         | TRUE
         | FALSE
         | ABPAR expr FPAR
         | OPNEG lego
         | OPAD lego
         ;

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