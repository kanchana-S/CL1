
%{

#include<stdio.h>
#include<stdlib.h>

typedef struct node
{
  int id;
  char name[10];
  char type[10];
  int size;
}node;

node a[20];
int top = 0,on;
char ty[7],var[10];

int getSize(char* t)
{
      if (strcmp(t, "int") == 0)
            return 2;
      else if (strcmp(t, "float") == 0)
            return 4;
      else if (strcmp(t, "char") == 0)
            return 1;
      else if (strcmp(t, "long") == 0)
            return 4;
      else if (strcmp(t, "double") == 0)
            return 8;
}

void push()
{
      a[top].id = top+1;
      strcpy(a[top].name, var);
      strcpy(a[top].type, ty);
      a[top].size = getSize(ty);
      top++;
}

void print()
{
      int i = 0;
      printf("\n\n---------------------------------------------");
  printf("\nSNO\t SYMBOL NAME\tDATA TYPE\tSIZE\n");
  printf("---------------------------------------------\n");
      for (i; i < top;i++)
      {
            printf(" %d\t\t%s\t%s\t\t%d\n", a[i].id, a[i].name, a[i].type, a[i].size);
      }
}

%}

%% 
printf printf("\nKeyword\t\t%s",yytext);

stmt printf("");

scanf  printf("\nKeyword\t\t%s",yytext);

if | 
else | 
while |
do |
switch | 
case |
for |
return printf("\nKeyword\t\t%s",yytext);

"void main" printf("\nKeyword\t\t%s",yytext);

\"[^"]*\" printf("\nQuoted string found");

#include |
#include<stdio.h> printf("\nHeader Files\t%s",yytext);

int |
float |
char |
double |
long |
void {on = 1;strcpy(ty,yytext);}
\{ {on = 0;}
[a-zA-Z][a-zA-Z0-9]* {if (on == 1){strcpy(var,yytext);}}
\, {if (on == 1){push();}}
\; {if (on == 1){push();} on = 0;}
. {}
\n {}

[0-9][a-z]+ printf("\nUnrecognized lexime\t%s\t",yytext);

%%

void main()
{
  FILE *fp;
  fp=fopen("sample.c","r");
  yyin=fp;
  yylex();
  print();
}

int yywrap()
{
      return 1;
}

