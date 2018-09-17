Overview:
Given a pseudo code, convert it to C Code Using Lex and Yacc Tool

This repo consists of 2 folders:
ICG - Converts pseudo code to C Code
AST - Abstract Syntax Tree REpresentation for the pseudo code

Requirements:
gcc compiler
lex and yacc compiler
-install using commands:
	* sudo apt-get install flex
	* sudo apt-get install bison

Commands to be executed for compilation and execution of Lex and Yacc Files:
->lex lex_file.l
->yacc yacc_file.y
->gcc lex.yy.c y.tab.h -ll 
->./a.out


