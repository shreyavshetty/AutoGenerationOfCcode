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
	extern int yylineno;
    typedef struct AST
    {
	char lexeme[100];
	int NumChild;
	struct AST **child;
    }AST_node;
        
	
	struct AST * make_node(char*, AST_node*, AST_node*);
	struct AST* make_leaf(char* root);
	void AST_print(struct AST *t);
%}
%union {char* dataType; char* IdName; struct AST *node;}
%token BEG END  INIT TO IF THEN WHILE DO PRINT READ FLOATING_NUMBER BREAK END_FUNCTION START_PROCEDURE NEWLINE CLOSE_BRACKET  OPEN_BRACKET ELSE ENDIF COMMA ENDWHILE

%token <dataType> INT FLOAT CHAR DOUBLE LONG
%token <IdName> ID DIV MUL  MINUS PLUS GREAT_E GREAT LESS_E NOT OR LESS  EQUAL NOT_EQUAL AND NUM EXP ASSIGN NAME_PROCEDURE
%token <node> RETURN
%type <dataType> datatype
%type <node> program code Stmt  F T E function_call Expr print_stmt read_stmt RelExpr LogExpr assign_stmt initialize_stmt relOp logOp datatypelist namelist parameter_list function
//%left ASSIGN
//%left GREAT_E GREAT LESS_E NOT  LESS  EQUAL NOT_EQUAL
//%left PLUS MINUS
//%left  MUL DIVISON

%%
  program : BEG NEWLINE code END NEWLINE  {$$=$3;AST_print($$);YYACCEPT;}
          | code      { yyerror("please enter in the format begin <code> end <newline");}
          ;

   code:Stmt {$$=$1;}
       | code Stmt {$$=make_node("Code",$1,$2);} 
       ;

  Stmt  : Expr NEWLINE{$$=$1;}
        | RETURN Expr NEWLINE{$1=make_leaf("Return");$$=make_node("Stmt",$1,$2);} 
        | assign_stmt NEWLINE{$$=$1;}
        | initialize_stmt NEWLINE{$$=$1;}
        | read_stmt NEWLINE{$$=$1;}
        | print_stmt NEWLINE {$$=$1;}
        | BREAK {$$=make_leaf("Break");}
        | IF Expr NEWLINE THEN NEWLINE Stmt ENDIF NEWLINE{$$=make_node("If",$2,$6);} 
        //| IF Expr THEN Stmt ELSE Stmt ENDIF {$$=make_ifelse_node("IfElse",$2,$4,$6);} 
        | WHILE Expr THEN Stmt ENDWHILE NEWLINE{$$=make_node("While",$2,$4);}
        | DO Stmt WHILE Expr NEWLINE{$$=make_node("DoWhile",$2,$4);}                
        | function NEWLINE{$$=$1;}
        | function_call {$$=$1;}
         ;
        
function_call : NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET {$$=make_node("Function Call",$1,$3);}
	;


  Expr : RelExpr {$$=$1;}
       | LogExpr {$$=$1;}
       | E {$$=$1;}
       ;

print_stmt : PRINT datatypelist COMMA Expr {$$=make_node("Print",$2,$4);}
           | PRINT Expr COMMA datatypelist  { yyerror("the format is  PRINT Expr COMMA datatypelist  ");}
           ;

read_stmt : READ datatypelist COMMA namelist {$$=make_node("Read",$2,$4);}
          ;
        
RelExpr : E relOp E {$$=make_node($2,$1,$3);}
        ;

LogExpr : E logOp E {$$=make_node($2,$1,$3);}
        ;

assign_stmt : INIT ID TO E {$2=make_leaf($2);$$=make_node("Assign",$2,$4);}
            | ID ASSIGN E {$1=make_leaf($1);$$=make_node("Assign",$1,$3);}
            ; 
initialize_stmt : INIT OPEN_BRACKET ID datatype CLOSE_BRACKET  {$3=make_leaf($3);$4=make_leaf($4);$$=make_node("Init",$3,$4);updateSymTab($<dataType>4,$3,yylineno);}
                ; 

//function : START_PROCEDURE NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET Stmt END_FUNCTION datatype {$2=make_leaf($2);$8=make_leaf($8);$$=make_node($2,$4,$6,$8);updateSymTab($<dataType>4,$3,yylineno);}
      //   ;
function : START_PROCEDURE NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET Stmt END_FUNCTION datatype {$$=make_node("FUNCTION",$4,$6);}
         | "start" NAME_PROCEDURE OPEN_BRACKET parameter_list CLOSE_BRACKET Stmt { yyerror("the format is start_procedure <function-name>(<id name> <data type> ) <stmt> end_procedure with return type <datatype > end");}
        ;
            
            

parameter_list : ID datatype  {$1=make_leaf($1);$$=make_node("Parameter",$1,$2);}
               | parameter_list COMMA ID  datatype {$3=make_leaf($3);$$=make_node("Parameter",$1,$3);}
               | datatype ID { yyerror("the format is ID datatype or parameter_list COMMA ID  datatype");}
               ;
E : E PLUS T {$$=make_node($2,$1,$3);}
    | E MINUS T {$$=make_node($2,$1,$3);}
    | T {$$=$1;}
    ;

T : T MUL F {$$=make_node($2,$1,$3);}
   | T DIV F {$$=make_node($2,$1,$3);}
   | F {$$=$1;}
   ;

F : ID {$$=make_leaf($1);} 
   | NUM {$$=make_leaf($1);}
   | OPEN_BRACKET E CLOSE_BRACKET {$$=$2;}
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



datatypelist : datatype {$$=make_leaf($1);}
             | datatypelist COMMA datatype {$3=make_leaf($3);$$=make_node("DataTypeList",$1,$3);}
             ;

namelist : ID				{$$=make_leaf($1);updateSymTab($<dataType>0,$1,yylineno);}
         | namelist COMMA ID  		{$3=make_leaf($3);$$=make_node("NameList",$1,$3);updateSymTab($<dataType>0,$3,yylineno);}		
	   
         ;

datatype : CHAR	{$$ = $1;}
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
}symTab[100];
int yywrap()
{
  return 1;
}
void yyerror(const char* arg)
{
	printf("%s\n",arg);
        exit(0);
}


//struct symbolTable symTab[100];
int ctr1=0;
void updateSymTab(char* data_type, char* id_name,int lineNo)
{
	strcpy(symTab[ctr1].name,id_name);
	strcpy(symTab[ctr1].type,data_type);
	if(strcmp(data_type,"int")==0|| strcmp(data_type,"integer")==0)
		symTab[ctr1].width=4;
	else if(strcmp(data_type,"float")==0)
		symTab[ctr1].width=4;
	else if(strcmp(data_type,"char")==0 || strcmp(data_type,"character")==0)
		symTab[ctr1].width=1;
	else if	(strcmp(data_type,"double")==0)
		symTab[ctr1].width=8;
	else if(strcmp(data_type,"long")==0)
		symTab[ctr1].width=10;

	symTab[ctr1].line=lineNo;
	ctr1++;
	printf("\n");


	
}
void printSymTab()
{
	int j;
	printf("Symbol Table: \n");
	printf("ID  Type  Size LineNo.\n");
	for(j=0;j<ctr1;j++)
	{	
		printf("%s ",symTab[j].name);
		printf("  %s ",symTab[j].type);
		printf("  %d ",symTab[j].width);
		printf("  %d ",symTab[j].line);
		printf("\n");
	}
}

void AST_print(struct AST *t){
	static int ctr=0;
	//printf("inside print tree\n");
	int i;
	if(t->NumChild==0) 
		return;

	struct AST *t2=t;
	printf("\n%s  -->",t2->lexeme);
	for(i=0;i<t2->NumChild;++i) 
	{
		printf("%s ",t2->child[i]->lexeme);
	}
	for(i=0;i<t2->NumChild;++i)
	{
		AST_print(t->child[i]);
	}
	
}
struct AST* make_node(char* root, AST_node* child1, AST_node* child2)
{
	//printf("Creating new node\n");
	struct AST * node = (struct AST*)malloc(sizeof(struct AST));
	node->child = (struct AST**)malloc(2*sizeof(struct AST *));
	node->NumChild = 2;//
	strcpy(node->lexeme,root);
	//printf("Copied lexeme\n");
	//printf("%s\n",node->lexeme);
	node->child[0] = child1;
	node->child[1] = child2;
	return node;
}



struct AST* make_leaf(char* root)
{
	//printf("Creating new leaf ");
	struct AST * node = (struct AST*)malloc(sizeof(struct AST));
	strcpy(node->lexeme,root);
	//printf("%s\n",node->lexeme);
	node->NumChild = 0;
	node->child = NULL;
	return node;
}
int main()
{
 int yydebug=1;
 printf("Algorithm\n");
	if(!yyparse())
	{	
		printf("\nSuccess\n");
		
	}
	return 0;
}

