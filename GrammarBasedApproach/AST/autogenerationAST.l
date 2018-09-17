letter [a-zA-Z]
digit [0-9]

%{                                            
     #include<stdio.h>
     #include<string.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
 
%}
%option yylineno
%%
"begin"    return BEG;
"end"    return END;
"int"    {yylval.dataType=strdup(yytext);return INT;}
"Integer" {yylval.dataType=strdup(yytext);return INT;}
"float"    {yylval.dataType=strdup(yytext);return FLOAT;}
"long"  {yylval.dataType=strdup(yytext);return LONG;}
"char"  {yylval.dataType=strdup(yytext);return CHAR;}
"character"    {yylval.dataType=strdup(yytext);return CHAR;}
"double"    {yylval.dataType=strdup(yytext);return DOUBLE;}
"assign" return INIT;
"initialize" return INIT;
"to"    return TO;
"if"    return IF;
"If" return IF;
"endwhile" return ENDWHILE;
"endif" return ENDIF;
"else" return ELSE;
"ELSE" return ELSE;
"then"    return THEN;
"while"    return WHILE;
"do" return DO;
"print" return PRINT;
"Print" return PRINT;
"read"    return READ;
"Read" return READ;
","  return COMMA;
"<=" {yylval.IdName=strdup(yytext); return LESS_E; }
">=" {yylval.IdName=strdup(yytext); return GREAT_E;}
"!=" {yylval.IdName=strdup(yytext); return NOT_EQUAL;}
"==" {yylval.IdName=strdup(yytext); return EQUAL; }
"<"  {yylval.IdName=strdup(yytext); return LESS;}
">"	 {yylval.IdName=strdup(yytext); return GREAT;}
"("	 {return OPEN_BRACKET;}
")"  {return CLOSE_BRACKET;}
"+"  {yylval.IdName=strdup(yytext); return PLUS;}
"-"  {yylval.IdName=strdup(yytext); return MINUS;}
"="	{yylval.IdName=strdup(yytext); return ASSIGN; }
"*"	 {yylval.IdName=strdup(yytext); return MUL;}
"/"	 {yylval.IdName=strdup(yytext); return DIV;}
"||" {yylval.IdName=strdup(yytext); return OR;}
"&&" {yylval.IdName=strdup(yytext); return AND;}
\n    {return NEWLINE;}
"start_procedure"    return START_PROCEDURE;
"end_procedure with return type"    return END_FUNCTION;
"return"    return RETURN;
"break"        return BREAK;
[0-9]+  {yylval.IdName=strdup(yytext);return NUM;}
[+-]?(([1-9]digit*)|(0))([.,]digit+)? {yylval.IdName=strdup(yytext);return FLOATING_NUMBER;}
{letter}({letter}|{digit})*/[(]    { yylval.IdName=strdup(yytext);return NAME_PROCEDURE;}
{letter}({letter}|{digit})*    {yylval.IdName=strdup(yytext); return ID;}   
\t      ;
.    ;
%%


