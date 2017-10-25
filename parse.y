%{
#include<stdio.h>
extern FILE *yyin;
%}
%token type
%token id
%token key
%token MAIN
%token num
%token FOR

%%
PROG : MAIN '{' CODE '}' {printf("\nsyntactically correct");}
;
CODE : CODE S 
;
CODE : S
;
S : D | LFOR | ASS | ARITH
;
D : T L ';'
;
T : type
;
L : id
;
L : L ',' id
;
ASS : id '=' num ';' | id '=' id ';'
;
CON : id OP id
;
OP : '<' | '>' |'=''=' | '<''=' |'>''=' |'!''='
;
STMT : STMT STMT1 | STMT1
;
STMT1 : ASS  | key'(''"' S1 '"'')'';' | LFOR | ARITH
; 
S1 : S1 id  | id
;
LFOR :  FOR '(' ASS CON ';' ID1 ')' '{' STMT '}'
;
ID1 : id '+''+' | id '-''-'
;
ARITH : id '=' OPER1 ';'
;
OPER1:  OPER | OPER OPER2
;
OPER2 : OPER2 op id | OPER2 op num |op num |op id
;
OPER : id op id |num op num |id op num |num op id
;
op : '+' | '*' | '/' | '-' |'%'
;
%%
int main()
{
	
		FILE *f;
		f = fopen("parse.c","r");
		if(f==NULL)
		{
		}
                else
		{
		 yyin=f;
		 yyparse();
		}
	
	
	return 0;
}
yyerror()
{
  printf("Syntax Error!");
}
