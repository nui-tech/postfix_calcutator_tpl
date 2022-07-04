%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[a-z]       {
                yylval = *yytext - 'a';
                return VAR;
                }

[0-9]+      {
                yylval = atoi(yytext);
                return INT;
            }

[-+()=/*\n]     { return *yytext; }
(sin)			{return SIN;}
(cos)			{return COS;}
(tan)			{return TAN;}

[ \t]   ;       /* skip whitespace */

.               yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
