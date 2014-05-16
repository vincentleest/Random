//Implement an algorithm to determin if a string has all unique characters
//What if you cannot use additional data structures? 

#include <iostream>
#include <string>
#include <bitset>

using namespace std;

// Check in n^2 method.
// Assume ASCII Strings


bool check_unique(string s){
	if( s.length() > 256)
		return false;

	bitset<256> char_set;
	
	for( std::string::iterator it = s.begin(); it != s.end(); it++){
		if(char_set[(int) *it] == 1 )
			return false;
		else 
			char_set.set((int) *it);
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
