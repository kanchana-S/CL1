%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>    

  int Index=0;
  int temp_var=0;
  
  void addQuadruple(char [],char [],char [],char []);
  void display_Quadruple();
  void push(char*);
  char* pop();
  
  struct Quadruple
  {
    char operator[5];
    char operand1[10];
    char operand2[10];
    char result[10];
  }QUAD[25];

 struct Stack
  {
    char *items[10];
    int top;
  }Stk;
%}

%union 
{
  int ival;
  char string[10];
}

%token <ival> NUMBER
%token <string> TYPE
%token <string> ID
%type <string> varlist
%type <string> expr
%token MAIN
%left '+' '-'
%left '*' '/'

%%
program:MAIN '('')''{' body '}';

body: varstmt stmtlist ;

varstmt: vardecl varstmt|;

vardecl:TYPE varlist ';' ;

varlist: varlist ',' ID 

| ID'='NUMBER            

|varlist ',' ID '=' NUMBER 

|ID ;

stmtlist: stmt stmtlist| ;

stmt : ID '=' NUMBER ';' {
                       char temp[10];
                       sprintf(temp,"%d",(int)$3);
                       addQuadruple("=","",temp,$1);}                   
| ID '=' ID ';'{addQuadruple("=","",$3,$1);}
| ID '=' expr ';'   { addQuadruple("=","",pop(),$1); } ;

expr :expr '+' expr {
                    char str[5],str1[5]="t";
                    sprintf(str, "%d", temp_var);    
                    strcat(str1,str);
                    temp_var++;
                    addQuadruple("+",pop(),pop(),str1);                                
                    push(str1);}
|expr '-' expr {
                    char str[5],str1[5]="t";
                    sprintf(str, "%d", temp_var);    
                    strcat(str1,str);
                    temp_var++;
                    addQuadruple("-",pop(),pop(),str1);
                    push(str1);}   

|expr '*' expr {
                char str[5],str1[5]="t";
                sprintf(str, "%d", temp_var);        
                strcat(str1,str);
                temp_var++;
                addQuadruple("*",pop(),pop(),str1);
                push(str1);}       
|expr '/' expr {
                char str[5],str1[5]="t";
                sprintf(str, "%d", temp_var);        
                strcat(str1,str);
                temp_var++;
                addQuadruple("/",pop(),pop(),str1);
                push(str1);}        
|ID {push($1);}
|NUMBER {  char temp[10];
           sprintf(temp,"%d",$1);    
           push(temp);};

%%
extern FILE *yyin;
int main()
{ 
  Stk.top = -1;
  yyin = fopen("a5","r");
  yyparse();
  display_Quadruple();
  printf("\n");
  return(0);
}

void display_Quadruple()
{
  int i;
  printf("The INTERMEDIATE CODE Is:\n");
  printf("The Quadruple Table\n");
  printf("\nResult \t Operator \t Operand1 \t Operand2  ");
  for(i=0;i<Index;i++)
    printf("\n  %s \t    %s   \t   %s  \t\t    %s",QUAD[i].result,QUAD[i].operator,QUAD[i].operand1,QUAD[i].operand2);
}
void yyerror()
{
   printf("\nERROR!!\n");
}

void push(char *str)
{
  Stk.top++;
    Stk.items[Stk.top]=(char *)malloc(strlen(str)+1);
  strcpy(Stk.items[Stk.top],str);
}

char * pop()
{
  int i;
  if(Stk.top==-1)
  {
     printf("\nStack Empty!! \n");
     exit(0);
  }
  char *str=(char *)malloc(strlen(Stk.items[Stk.top])+1);
  strcpy(str,Stk.items[Stk.top]);
  Stk.top--;
  return(str);
}
 void addQuadruple(char op[10],char op2[10],char op1[10],char res[10])
{
strcpy(QUAD[Index].operator,op);
strcpy(QUAD[Index].operand2,op2);
strcpy(QUAD[Index].operand1,op1);
strcpy(QUAD[Index].result,res);
Index++;
}
