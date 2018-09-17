#include<stdio.h>
#include<string.h>
#define N 50
#define M 100
//Tokenization by eliminating leading and trailing whitespaces
char* trimwhitespace(char *str)
{
    char *end;
    int space_count=0;
    // Trim leading space
    while(isspace((unsigned char)*str))
    {
      str++;
      space_count=space_count+1;
    }
    // All spaces?
    if(*str == 0)
      return str;
    // Trim trailing space
    end = str + strlen(str) - 1;
    while(end > str && isspace((unsigned char)*end))
      end--;
    // Write new null terminator
    *(end+1) = 0;
    return str;
}
//Input : Algorithm stored as a 2D character array and
// the number of lines in the algorithm
// void type (char a[N][M],int len)
// {
//     int i,j,k,m;
//     char para[N][M];
//     i=0;
//     j=0;
//     while(a[i][j] != 'M')
//     {
//       j++;
//     }
//     j=j+2;
//     while(a[i][j] != ')')
//     {
//       printf("%c",a[i][j]);
//       j++;
//     }
//     printf("%s\n","){");
//     j=0;
//     while(a[i][j] != '(')
//     {
//       j++;
//     }
//     j=j+1;
//     m=j;
//     int count;
//     while(a[i][j] != ')')
//     {
//       j=j+1;
//     }
//     j=j-1;
//     k=0;//para variables para[k][p]
//     int l;//for loop variables
//     int p=0;
//     for(l=m;l<=j;l++)
//     {
//       if(a[i][l] != ',')
//       {
//          para[k][p]=a[i][l];
//          p++;
//       }
//       else
//       {   count=count+1;
//           para[k][p]='\0';
//           k++;
//           p=0;
//       }
//     }
// }
char *replace_str(char *str, char *orig, char *rep)
{
    static char buffer[4096];
    char *p;

    if(!(p = strstr(str, orig)))
    return str;

    strncpy(buffer, str, p-str);
    buffer[p-str] = '\0';

    sprintf(buffer+(p-str), "%s%s", rep, p+strlen(orig));
    return buffer;
}
//Input : Opens the text file containing the algorithm
//Output : Returns the number of lines in the algorithm
int input_to_array(char array[][M])
{
    char for_line[50];
    char line[500];
    char word[90];
    char first[4];
    FILE *file;
    FILE *fptr;
    int n=0;
    int len=0;
    int j=0;
    file=fopen("input.txt","r");
    if(file!=NULL)
    {
        while(fgets(line,sizeof line,file)!=NULL)
        {
          while(line[j]!='\n')
          {
            array[len][j]=line[j];
            j=j+1;
          }
          len=len+1;
          j=0;
        }
        fclose(file);
    }
    return len;
}
//Input : Algorithm as a 2-D Character Array, Number of lines in the algorithm
void replace_for(char array[][M],int len)
{
    int k,l,j;
    char * pch;
    char key[] = "for";
    char str[100]="for (a=b;a<=n;a++)";
    char array_copy[100];
    char str1[100];
    int c=0;
    int count=0;
    for(k=0;k<len-1;k++)
    {
        strcpy(str1,str);
        strcpy(array_copy,array[k]);
        pch = strtok (array_copy," ");//gives only first word
        if(strcmp (key,pch)== 0)//if the first word is for
        {
            while (pch != NULL)//extarct all words in the for statement
            {
                count =count+1;//to extract only the expected words
                if(count==2)//replace a
                {
                    for(l=0;l<3;l++)
                    {
                         strcpy(str1, replace_str(str1,"a",pch));
                    }
                }
                if(count==5)//replace downto
                {
                    char random1[10]="downto";
                    if(strcmp (random1,pch)== 0)
                    {
                        strcpy(str1, replace_str(str1,"++","--"));
                        strcpy(str1, replace_str(str1,"<=",">="));
                    }
                }
                if(count==4)//replace b
                {
                    strcpy(str1, replace_str(str1,"b",pch));
                }
                if(count==6)//replace n
                {
                    strcpy(str1, replace_str(str1,"n",pch));
                }
                pch = strtok (NULL, " ");
                strcpy(array[k],str1);
            }
            count=0;
        }
    }
}
//Input : Algorithm as a 2-D Character Array, Number of lines in the algorithm
void addsplchar(char P[][M],int n)
{
    int i;
    for(i=3;i<n-1;i++)
    {
       char *p = P[i];
       char FirstWord[M]=" ";
       int j;
       for(j = 0; (p[j] != '\0') ; j++)
       {
          if(p[j]==' ') break;
          FirstWord[j] = p[j];
       }
       if ((strcmp(FirstWord, "for")==0) || (strcmp(FirstWord, "if")==0) || (strcmp(FirstWord, "while")==0) || (strcmp(FirstWord, "else")==0) || (strcmp(FirstWord, "else if")==0) )
       {
          char* flowerbracket="{";
          int len = strlen(P[i]);
          strcat(P[i],flowerbracket);
       }
      else if(strcmp(FirstWord, "}")==0)
      		continue;
      else
      {
        char* semicolon=";";
        int len = strlen(P[i]);
        strcat(P[i],semicolon);
      }
    }
    for(i=3;i<n;i++)
    {
      char *p = P[i];
      while (*p != '\0')
      {
        if (*p == '<' && (*(p+1))=='-')
        {
          *p = '=';
          *(p+1)=' ';
        }
        p++;
      }
    }
   for(i=3;i<n;i++)
   {
      printf("%s\n",P[i]);
   }

}
//Input : Algorithm as a 2-D Character Array, Number of lines in the algorithm
void replace_if_else_if(char array[][M],int len)
{
    int k,l,j;
    char * pch;
    char key[] = "if";
    char str[100]="if (";
    char key1[] = "elseif";
    char str1[100]="else if (";
    char array_copy[100];
    int c=0;
    int count=0;
    int if_checked=0;
    for(k=0;k<len-1;k++)
    {
        strcpy(array_copy,array[k]);
        pch = strtok (array_copy," ");//gives only first word
        strcpy(pch,trimwhitespace(pch));
        if(strcmp (key,pch)== 0)//if the first word is if
        {
          while (pch != NULL)//extarct all words in the for statement
          {
            if(strcmp ("if",pch)!= 0)
            {
              strcat(str,pch);
            }
            pch = strtok (NULL," ");
          }
          strcat(str,")");
          strcpy(array[k],str);
          strcpy(str,"if (");
          if_checked=1;
        }
        else if(strcmp(key1,pch)==0)
        {
          while (pch != NULL)//extarct all words in the for statement
          {
               if(strcmp ("elseif",pch)!= 0)
               {
                  strcat(str1,pch);
               }
               pch = strtok (NULL," ");
          }
          strcat(str1,")");
          strcpy(array[k],str1);
          strcpy(str1,"else if (");
        }
        else if(strcmp("else",pch)==0)
        {
             strcpy(array[k],"else ");
        }
      }
}
//Input : Algorithm as a 2-D Character Array, Number of lines in the algorithm
void replace_while(char array[][M],int len)
{

    int k,l,j;
    char * pch;
    char key[] = "while";
    char str[100]="while (";
    char array_copy[100];
    char str1[100];
    int c=0;
    int count=0;
    for(k=0;k<len-1;k++)
    {
        strcpy(array_copy,array[k]);
        pch = strtok (array_copy," ");//gives only first word
        if(strcmp (key,pch)== 0)//if the first word is if
        {
            while (pch != NULL)//extarct all words in the for statement
            {
                if(strcmp ("while",pch)!= 0)
                {
                    strcat(str,pch);
                }
                pch = strtok (NULL," ");
            }
            strcat(str,")");
            strcpy(array[k],str);
            strcpy(str,"while (");
        }
    }
}


void main()
{
    char array[N][M];
    int len;
    len=input_to_array(array);
    replace_for(array,len);
    replace_if_else_if(array,len);
    replace_while(array,len);
    addsplchar(array,len);
}
