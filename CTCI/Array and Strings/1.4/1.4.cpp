#include <iostream>
#include <string>

using namespace std;

void remove_space(string str){


}

int main(){

	string a = "lol%20";
	string b = "%20";
	string c = "";
	string d = "this is a test string";
	string e = "this%20is%20a%20test%20string";

	cout<< "sting is:"<< a<< " result is "<< remove_space(a);
	cout<< "sting is:"<< b<< " result is "<< remove_space(b);
	cout<< "sting is:"<< c<< " result is "<< remove_space(c);
	cout<< "sting is:"<< d<< " result is "<< remove_space(d);
	cout<< "sting is:"<< e<< " result is "<< remove_space(e);

}
