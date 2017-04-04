//Precedence of data types
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
char* data_type(int num,...) 
{

   
   va_list arguments;
   char *a;
   char *w="int";
   int i;

   /* initialize valist for num number of arguments */
   va_start(arguments, num);

   /* access all the arguments assigned to valist */
   for (i = 0; i < num; i++) 
   {
        //sum += va_arg(valist, int);
   		a=va_arg(arguments,char*);
   		if(a=="double")
   			return a;
   		if(a=="float")
   			w="float";
    }
	
   /* clean memory reserved for valist */
   va_end(arguments);

   return w;
}

int main() 
{
   //test
   printf("Data type = %s\n", data_type(5,"float","float","int","int","int"));
  
}
