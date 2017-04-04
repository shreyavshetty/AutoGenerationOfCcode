#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define N 50
#define M 100
int main()
{
	
	char line[500];
	char array[N][M];
	char word[90];
	FILE *file;
	FILE *fptr;
	int n=0;
	int i=0;
	int j=0;
	file=fopen("input.txt","r");
	if(file!=NULL)
	{
		
		while(fgets(line,sizeof line,file)!=NULL)
		{
			
			while(line[j]!='\n')
			{
				array[i][j]=line[j];
				j=j+1;
			}
			
			i=i+1;
			j=0;



		}
		fclose(file);
	}
	
}
