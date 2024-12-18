flex lexical.l
bison -d syntaxique.y
gcc -std=c99 lex.yy.c syntaxique.tab.c TS.h -lfl -ly -o compiler
compiler.exe<test3.txt >outputsynt.txt
