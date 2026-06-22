%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s);
%}

%token NUMBER

%left '+' '-'
%left '*' '/' '%'

%%

calc:
      /* empty */
    | calc expr '\n'   { printf("Result = %d\n", $2); }
    | calc expr        { printf("Result = %d\n", $2); }
    ;

expr:
      expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | expr '%' expr { $$ = $1 % $3; }
    | '(' expr ')'  { $$ = $2; }
    | NUMBER        { $$ = $1; }
    ;

%%

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf("Syntax Error: %s\n", s);
}
