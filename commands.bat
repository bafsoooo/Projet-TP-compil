flex lexical.l
bison -d syntaxique.y
gcc lex.yy.c syntaxique.tab.c -lfl -ly -o compiler
compiler.exe<test2.txt >outputsynt.txt
