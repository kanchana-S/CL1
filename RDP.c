#include<stdio.h> 
#include<ctype.h> 

int error=0; 
int ip=0; 
char input[50]; 

void E(); 
void EPrime(); 
void T(); 
void TPrime(); 
void F(); 

int main() 
{ 
	 
	printf("Enter the input string:"); 
	scanf("%s",input);		 
	E(); 
	int null=0; 

	if((input[ip]==null)&&(error==0)) 
	{ 
		printf("Successful parsing\n"); 
	} 
	else 
	{ 
		printf("Unsucessful Parsing\n"); 
	} 
} 

void E() 
{ 
printf("\nE->TE'"); 
	T(); 
	 
	EPrime(); 
	 
} 
void EPrime() 
{ 
	if(input[ip]=='+') 
	{ 
	  ip++; 
	  printf("\nE'->+TE'\n"); 
	  T(); 
	  EPrime(); 
	} 
	else 
	{ 
	  printf("\nE'->NULL\n"); 
	} 
} 
void T() 
{printf("\nT->FT'\n"); 
	F(); 
	TPrime(); 
	 
} 
void TPrime() 
{ 
	if(input[ip]=='*') 
	{ 
	  ip++; 
	  printf("\nT'->*FT'\n"); 
	  F(); 
	  TPrime(); 
	} 
	else 
	{ 
	  printf("\nT'->NULL\n"); 
	} 
} 
void F() 
{ 
	printf("%c",input[ip]);	 
	if(isalpha(input[ip])) 
	{ 
		ip++; 
		printf("\nF->id\n"); 
	} 
	else if(isdigit(input[ip])) 
	{ 
		ip++; 
		printf("\nF->num\n"); 
	} 
	else if(input[ip]=='(') 
	{ 
		ip++; 
		printf("\nF->(E)\n"); 
		E(); 
	 
	if(input[ip]==')') 
	{ 
		ip++; 
	} 
	else 
		error=1; 
	} 

}
