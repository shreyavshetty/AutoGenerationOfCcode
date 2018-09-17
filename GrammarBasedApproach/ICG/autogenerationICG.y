%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include <stdarg.h>
	int yylex();
	void yyerror(const char *s);
	extern char yytext[];
	#define YYDEBUG_LEXER_TEXT yytext
	void updateSymTab(char* data_type, char* id_name,int lineNo);
	void printSymTab();
	void tostring(char str[], int num);
	char* new_temp();
	int lookUpSymTab(char* nam);
	char* code_gen(int arg_count,...);
	char* code_concatenate(int arg_count,...);
	char* gen_addr(char* string);
	char* get_specifier(char *type);
	int t=0;
	extern int yylineno;
%}
%token BEG END  INIT TO IF THEN WHILE DO PRINT READ ASSIGN FLOATING_NUMBER BREAK RETURN  END_FUNCTION START_PROCEDURE  CLOSE_BRACKET  OPEN_BRACKET EXP DIV MUL MINUS PLUS  NOT ELSE ENDIF COMMA NEWLINE ENDWHILE

%union {char* dataType; char* IdName; struct attributes{
	char* code; 
	char* addr;
	char* specifier;
}A;}

%token <dataType> INT FLOAT CHAR DOUBLE LONG
%token <IdName> ID NUM LESS GREAT LESS_E GREAT_E NOT_EQUAL EQUAL OR AND NAME_PROCEDURE 
%type <dataType> datatype
%type <IdName> relOp logOp 
%type<A> F T E assign_stmt initialize_stmt Stmt codes program Expr RelExpr LogExpr parameter_list function_call function read_stmt print_stmt 
%type<A> datatypelist namelist
//%left ASSIGN
//%left GREAT_E GREAT LESS_E NOT  LESS  EQUAL NOT_EQUAL
//%left PLUS MINUS
//%left  MUL DIVISON
 
%%
  program: BEG codes END NEWLINE {$$=$2;printSymTab(); printf("\n C code: \n%s",$$.code);  YYACCEPT;}
          ;

   codes:Stmt	{$$.code=$1.code;}
       | codes Stmt	{$$.code=code_concatenate(2,$1.code,$2.code);}
       ;

  Stmt:Expr			{$$=$1;}
        | RETURN Expr		{$$.code=code_concatenate(3,"return ",$2.code," ; ");}
        | assign_stmt		{$$.code=$1.code;}
        | initialize_stmt	{$$.code=$1.code;}
        | read_stmt		{$$.code=$1.code;}		
        | print_stmt		{$$.code=$1.code;}
        | BREAK			{$$.code=code_gen(1,"break;");}
        | IF  Expr THEN Stmt ENDIF   {$$.code=code_concatenate(5,"If( ",$2.code,") { ",$4.code," } " );}
        | IF Expr THEN Stmt ELSE Stmt ENDIF	{$$.code=code_concatenate(7,"If( ",$2.code,")  {",$4.code," } else {",$6.code," }");}
        | WHILE Expr THEN Stmt ENDWHILE  {$$.code=code_concatenate(5,"While (",$2.code,")  {",$4.code," } ");}
        | DO Stmt WHILE Expr   {$$.code=code_concatenate(5,"do{",$2.code,"} while(",$4.code,");");}                
        | function		{$$=$1;}
        | function_call		{$$=$1;}
          ;
        
function_call: NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET { $$.code=code_gen(4,$1,"(",$3.code,");");}
              ;

  Expr:RelExpr	{$$=$1;}	
       | LogExpr	{$$=$1;}
       | E			{$$=$1;}
       ;

print_stmt: PRINT datatypelist COMMA Expr  {$$.code=code_gen(5,"printf(\" ",$2.code,"\" ,",$4.code,");");}
	  | PRINT datatypelist COMMA ID  {$$.code=code_gen(5,"printf(\" ",$2.code,"\" ,",$4,");");}
          ;

read_stmt: READ datatypelist COMMA namelist  {$$.code=code_gen(5,"scanf(\"",$2.code,"\",",$4.code,");");}
          ;
        
RelExpr:E relOp E		{$$.code = code_concatenate(4,$1.code,$3.code,code_gen(3,$1.addr,$2,$3.addr)," ; ");}
        ;

LogExpr:E logOp E		{$$.code = code_concatenate(4,$1.code,$3.code,code_gen(3,$1.addr,$2,$3.addr)," ; ");}
        ;

assign_stmt: INIT ID TO E { $$.addr = gen_addr($2); 
																									$$.code = code_concatenate(3,$4.code,code_gen(3,$$.addr," = ",$4.addr)," ; ");}
            | ID ASSIGN E	{ $$.addr = gen_addr($1);  
																										          							$$.code = code_concatenate(3,$3.code,code_gen(3,$$.addr," = ",$3.addr)," ; ");}
            ; 
initialize_stmt: INIT OPEN_BRACKET ID datatype CLOSE_BRACKET  {updateSymTab($<dataType>4,$3,yylineno); $$.code=code_concatenate(2,code_gen(3,$4," ",$3)," ; ");}
                ; 

function: START_PROCEDURE NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET Stmt END_FUNCTION datatype  { $$.code = code_gen(8,$8," ",$2,"(",$4.code,"){ ",$6.code,"}");}
         ;
            

parameter_list: ID datatype {updateSymTab($<dataType>2,$1,yylineno);$$.code=code_gen(3,$2," ",$1);}
               | parameter_list COMMA ID datatype {updateSymTab($<dataType>4,$3,yylineno);$$.code=code_concatenate(5,$1.code,",",$4," ",$3);}
               ;
E: E PLUS T   {$$.addr = new_temp(); $$.code = code_concatenate(4,$1.code,$3.code,code_gen(5,$$.addr," = ",$1.addr," + ",$3.addr)," ; "); }
	| E MINUS T  {$$.addr = new_temp(); $$.code = code_concatenate(4,$1.code,$3.code,code_gen(5,$$.addr," = ",$1.addr," - ",$3.addr)," ; ");}
    | T	  {$$.addr = $1.addr; $$.code = $1.code;}
    ;

T: T MUL F    {$$.addr = new_temp(); $$.code = code_concatenate(4,$1.code,$3.code,code_gen(5,$$.addr," = ",$1.addr," * ",$3.addr)," ; "); }
   | T DIV F       {$$.addr = new_temp(); $$.code = code_concatenate(4,$1.code,$3.code,code_gen(5,$$.addr," = ",$1.addr," / ",$3.addr)," ; "); }
   | F {$$.addr = $1.addr; $$.code = $1.code;}
   ;

F: ID		{$$.addr = gen_addr($1); $$.code = code_gen(1," ");} 
   | NUM	{$$.addr = gen_addr($1); $$.code = code_gen(1," ");;} 
   | OPEN_BRACKET E CLOSE_BRACKET	{$$=$2;}
   ;


relOp:LESS_E     {$$=$1;}
     |GREAT_E     {$$=$1;}
     |NOT_EQUAL     {$$=$1;} 
     |EQUAL      {$$=$1;}
   |LESS      {$$=$1;}
   |GREAT    {$$=$1;}
   ;

logOp:AND {$$=$1;}
      |OR {$$=$1;}
      ;


datatypelist: datatype { $$.specifier=get_specifier($1);$$.code=code_gen(1,$$.specifier);} 
             | datatypelist COMMA datatype { $$.specifier=get_specifier($3);$$.code=code_gen(3,$1.code,",",$$.specifier);}
             ;

namelist: ID			{$$.code=code_gen(1,$1);}	
         | namelist COMMA ID 	{$$.code=code_gen(3,$1.code,",",$3);}		
	   
         ;

datatype: CHAR	{$$ = $1;}
      | INT	{$$ = $1;}
      | DOUBLE	{$$ = $1;}
      | FLOAT	{$$ = $1;}
      | LONG	{$$ = $1;}
      ;
             

%%
struct symbolTable
{
	char name[30];
	char type[10];
	int width;
	int line;
};
int yywrap()
{
  return 1;
}
void yyerror(const char* arg)
{
	printf("%s\n",arg);
}


struct symbolTable symTab[100];
int ctr=0;
void updateSymTab(char* data_type, char* id_name,int lineNo)
{
	strcpy(symTab[ctr].name,id_name);
	strcpy(symTab[ctr].type,data_type);
	if(strcmp(data_type,"int")==0|| strcmp(data_type,"integer")==0)
		symTab[ctr].width=4;
	else if(strcmp(data_type,"float")==0)
		symTab[ctr].width=4;
	else if(strcmp(data_type,"char")==0 || strcmp(data_type,"character")==0)
		symTab[ctr].width=1;
	else if	(strcmp(data_type,"double")==0)
		symTab[ctr].width=8;
	else if(strcmp(data_type,"long")==0)
		symTab[ctr].width=10;
	symTab[ctr].line=lineNo;
	ctr++;
	printf("\n");


	
}
void printSymTab()
{
	int j;
	printf("Symbol Table: \n");
	printf("ID  Type  Size LineNo.\n");
	for(j=0;j<ctr;j++)
	{	
		printf("%s ",symTab[j].name);
		printf("  %s ",symTab[j].type);
		printf("  %d ",symTab[j].width);
		printf("  %d ",symTab[j].line);
		printf("\n");
	}
}
int lookUpSymTab(char* nam)
{
	int i; 
	for(i=0;i<ctr;i++)
	{
		if(strcmp(symTab[i].name,nam)==0)
		{
			return 1;
		}
	}
	return 0;
}
char* gen_addr(char* string)
{
	char* addr = (char*)malloc(sizeof(string));
	strcpy(addr, string);
	return addr;
}

char* code_gen(int arg_count,...)
{
	int i;
	va_list ap;
	va_start(ap, arg_count);
	char* temp = malloc(1000);
	for (i = 1; i <= arg_count; i++)
    {   
     	char* a = va_arg(ap, char*);
     	temp = (char*)realloc(temp,(strlen(temp)+strlen(a)+10));
     	strcat(temp,a);
    }
    strcat(temp,"   ");
     return temp;  
}
char* code_concatenate(int arg_count,...)
{
	int i;
	va_list ap;
	va_start(ap, arg_count);
	char* temp = malloc(1000);
	for (i = 1; i <= arg_count; i++)
    {   
     	char* a = va_arg(ap, char*);
     	temp = (char*)realloc(temp,(strlen(temp)+strlen(a)+10));
     	strcat(temp,a);
     }
     return temp;     
}
void tostring(char str[], int num)
{
    int i, rem, len = 0, n;
 
    n = num;
    while (n != 0)
    {
        len++;
        n /= 10;
    }
    for (i = 0; i < len; i++)
    {
        rem = num % 10;
        num = num / 10;
        str[len - (i + 1)] = rem + '0';
    }
    str[len] = '\0';
}
char* new_temp()
{
	t++;
	char* num = (char*)malloc(sizeof(int));
	tostring(num,t);
	char* temp = (char*)malloc(sizeof(int));
	strcat(temp,"t");
	strcat(temp,num);
	return temp;
}

char* get_specifier(char *type){
	char* data;
	if(strcmp(type,"int")==0|| strcmp(type,"integer")==0)
		data="%d";
	else if(strcmp(type,"float")==0)
		data="%f";
	else if(strcmp(type,"char")==0 || strcmp(type,"character")==0)
		data="%c";
	else if	(strcmp(type,"double")==0)
		data="%f";
	else if(strcmp(type,"long")==0)
		data="%ld";
	return data;
}	

int main()
{
	extern FILE *yyin;
	yyin=fopen("Input_nonopt.txt","r");
	printf("Opened file\n");
	int yydebug=1;
	printf("Algorithm\n");
	if(!yyparse())
	{	
		printf("\nSuccess\n");
		
	}
	fclose(yyin);
	return 0;
}

