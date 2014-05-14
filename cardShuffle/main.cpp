#include <stdlib.h>
#include <iostream>
#define DECK_SIZE 52

using namespace std;

void swap(int* a, int* b){
	int temp = *a;
	*a = *b;
	*b = temp;	
}

void shuffle( int* deck){
	int cardsLeft = DECK_SIZE;
	int pickIndex, cardsShuffled;
	
	for(cardsShuffled = 0; cardsShuffled < DECK_SIZE ;cardsLeft--, ++cardsShuffled){
		pickIndex = rand()%cardsLeft;
		swap(&deck[pickIndex], &deck[cardsShuffled]);
	}
	
}


void printDeck(int* deck){
	cout<<"Deck is ";
	for(int i = 0; i < DECK_SIZE ; ++i){
		cout<< deck[i]<<" ";
	}	
	cout<<endl;
}

int main (){
	int deck[DECK_SIZE];
	int i;

	for(int i = 0; i < DECK_SIZE ; ++i){
		deck[i] = i;
	}	
	
	printDeck(deck);
	shuffle(deck);
	printDeck(deck);
	shuffle(deck);
	printDeck(deck);
	shuffle(deck);
	printDeck(deck);
}
