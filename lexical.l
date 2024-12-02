%{
#include "syntax.tab.h"
int nb_ligne=1;
%}

%%
"int"          { return INT; }
"if"           { return IF; }
"else"         { return ELSE; }
"while"        { return WHILE; }

[a-zA-Z][a-zA-Z0-9]* { return ID; }

[0-9]+         { return NUM; }

"=="           { return "=="; }
"!="           { return "!="; }
">"            { return '>'; }
"<"            { return '<'; }
"+"            { return '+'; }
"-"            { return '-'; }
"*"            { return '*'; }
"/"            { return '/'; }
"="            { return '='; }
";"            { return ';'; }
","            { return ','; }
"("            { return '('; }
")"            { return ')'; }
"{"            { return '{'; }
"}"            { return '}'; }

[ \t]        { /* Ignorer les espaces */ }
\n {nb_ligne++; }

.              { printf("Caractère inattendu : %s\n", yytext); }

%%
int yywrap() {
    return 1;
}
