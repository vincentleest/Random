//Implement a function void reverse(char* str) in C or C++ which reverses 
//a null-terminated string.

#include <iostream>
using namespace std;

void swap(char* a, char*b){
	char temp = *a;
	*a = *b;
	*b = temp;
}

void reverse(char * str){
	int i,j,len;
	len = strlen(str);
	cout<<"strlen"<<len<<endl;
	for( i = 0 , j = len-1; i < len/2; i++, j--){
		swap(&str[i], &str[j]);
	}
}

int main (){
	char test1[] = "racecar";
	char test2[] = "testing";
	char test3[] = "";
	char test4[] = "testing1";
		
	cout<< "string is:"<< test1 <<endl;
	reverse(test1) ;
	cout<< "reverse string is:"<< test1 <<endl;

	cout<< "string is:"<< test2 <<endl;
	reverse(test2) ;
	cout<< "reverse string is:"<< test2 <<endl;

	cout<< "string is:"<< test3 <<endl;
	reverse(test3) ;
	cout<< "reverse string is:"<< test3 <<endl;

	cout<< "string is:"<< test4 <<endl;
	reverse(test4) ;
	cout<< "reverse string is:"<< test4 <<endl;
}
