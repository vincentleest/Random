//Given two strings, write a mthod to decided if one is a permutation of
//the other. 

#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

bool if_permutate(string a, string b){
	if( a.length() != b.length())
		return false;
	
	std::sort( a.begin(), a.end());
	std::sort( b.begin(), b.end());

	if( a.compare(b) == 0)	
		return true;
	
	return false;
}

int main (){
	string a = "best";
	string b = "bets";
	string c = "bees";
	string d = "asd";
	
	cout<< "string a "<< a << "string b "<< b<< endl;
	cout<< "is permutation?" << if_permutate(a, b)<<endl;

	cout<< "string a "<< a << "string b "<< b<< endl;
	cout<< "is permutation?" << if_permutate(c, b)<<endl;

	cout<< "string a "<< a << "string b "<< b<< endl;
	cout<< "is permutation?" << if_permutate(c, d)<<endl;

	return 0;
}
