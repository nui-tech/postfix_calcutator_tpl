%{
    #include <stdio.h>
	#include <math.h>
    void yyerror(char *);
    int yylex(void);
    int sym[26];
%}

%token INT VAR
%token SIN COS TAN
%left '+' '-'
%left '*' '/'

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        expr		{ printf("= %d\n", $1); }
        | VAR '=' expr      { sym[$1] = $3; }
		|INT SIN	{									
					double j = sin($2);
					printf("= %.2f\n",j); $$=j;
								}
		|INT COS 	{									
					double j = cos($2);
					printf("= %.2f\n",j); $$=j;
					}
		|INT TAN	{									
					double j = tan($2);
					printf("= %.2f\n",j); $$=j;
					}
		;

expr:
        INT
        | VAR	           { $$ = sym[$1]; }
        | expr expr '+'    { $$ = $1 + $2; }
        | expr expr '-'    { $$ = $1 - $2; }
        | expr expr '*'    { $$ = $1 * $2; }
        | expr expr '/'    { $$ = $1 / $2; }
        | '(' expr ')'     { $$ = $2; }		
        ;

	
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
	printf("Postfix Calculator\n");
	printf("___________________________\n");
    yyparse();
}
