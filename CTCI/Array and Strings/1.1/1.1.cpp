//Implement an algorithm to determin if a string has all unique characters
//What if you cannot use additional data structures? 
#include <iostream>
#include <string>

using namespace std;

// Check in n^2 method.

bool check_unique(string s){
	if( s.length()==0)
		return false;

	for(std::string::iterator it = s.begin(); it !=s.end(); ++it){
		std::string::iterator temp = it+1;
		for( ; temp != s.end(); ++temp){
			if( *it == *temp)	
				return false;
		}	
	}	
	

	return true;
}

int main (){
	string s = "testings123";

	if(check_unique(s))
		cout<<"true"<<endl;
	else
		cout<<"false"<<endl;

	s = "asdf";
	if(check_unique(s))
		cout<<"true"<<endl;
	else
		cout<<"false"<<endl;

	s = "";
	if(check_unique(s))
		cout<<"true"<<endl;
	else
		cout<<"false"<<endl;
}
