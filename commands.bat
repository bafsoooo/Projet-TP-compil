flex lexical.l
bison -d syntaxique.y
gcc -std=c99 lex.yy.c syntaxique.tab.c -lfl -ly -o compiler
compiler.exe<test.txt >output.txt
