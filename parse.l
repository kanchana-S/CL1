%{
#include"y.tab.h"
#include<stdio.h>
extern int yylval; 
%}
%%
"main()" {printf("\nmain found");return MAIN;}
int |
char {printf("\n%s Keyword found",yytext);return type;}
for {printf("\n%s Keyword found",yytext);return FOR;}
printf {printf("\n%s Keyword found",yytext);return key;}
[a-zA-Z]+[a-zA-Z0-1]* {printf("\n%s identifier found",yytext);return id;}
[0-9]+ {printf("\nNumber found");return num;}
[ \t] ;
. {return yytext[0];}
%%

yywrap()
{}
