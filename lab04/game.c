#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "game.h"

int stringToInt(char s[]) {
  // from https://www.quora.com/How-do-I-extract-an-integer-from-the-string-in-C?share=1
  if (strlen(s) == 1) {
    return (int)s[0] - '0';
  }
  char c; 
  int digit,number=0; 
  for(unsigned long i=0;i<strlen(s)-1;i++) 
    { 
      c = s[i]; 
      if(isdigit(c)) //to confirm it's a digit 
	{ 
	  digit = c - '0'; 
	  number = number*10 + digit; 
	} 
    } 
  return number;
}

struct coordinate askForCoordinate(int remainingShots) {
  char coordinate[10];
  struct coordinate coordinates;
  printf("Enter the coordinate for your shot (%d shots remaining): ",remainingShots);
  scanf("%s", coordinate);

  int i = 0;
  char row[10];
  while (coordinate[i] != '\n') {
    if (isalpha(coordinate[i])) {
      coordinates.col = (int)coordinate[i];
    }
    else if (isdigit(coordinate[i])){
      char r = coordinate[i];
      strcat(row,&r);
    }
    i++;
  }
    coordinates.row = stringToInt(row);
  return coordinates;
}


int getRow(struct coordinate c) {
  return c.row-1;
}

int getCol(struct coordinate c) {
  return c.col - 97; // shift from ascii to index in array
}

int coordinateInBounds(struct coordinate c, struct board b) {
  return getRow(c) >= 0 && getRow(c) < b.size && getCol(c) >= 0 && getCol(c) < b.size;
}

int checkCoordinates(struct coordinate c, struct board *b) { // returns 1 if a shot was fired, returns 0 if no shot was fired
  if (!coordinateInBounds(c, *b)) {
    printf("Coordinate out of bounds, no shot fired\n");
    return 0;
  }
  if (b->matrix[getRow(c)][getCol(c)] == '~') {
    printf("%c%d is a MISS\n", c.col, c.row);
    b->matrix[getRow(c)][getCol(c)] = 'm';
    return 1;
  }
  if (b->matrix[getRow(c)][getCol(c)] == 'm' || b->matrix[getRow(c)][getCol(c)] == 'h') {
    printf("you already fired there.\n");
    return 0;
  }
  printf("%c%d is a HIT\n", c.col, c.row);
  b->matrix[getRow(c)][getCol(c)] = 'h';
  return 1;
}

int checkIfShipSunk(struct board b, struct ship s) {
  int hits = 0;
  for (int j = 0; j < s.size; j++) {
    if (s.vert)
      hits += b.matrix[s.row+j-1][s.col-1] == 'h';
    else
      hits += b.matrix[s.row-1][s.col+j-1] == 'h';
  }
  return hits / (float)s.size > 0.7;
}

int handleSunkShips(struct board *b, struct ship ships[]) { // returns 1 if ship sunk, 0 otherwise
  for (int i = 0; i < 4; i++) {
    if (checkIfShipSunk(*b, ships[i])) {
      makeShipSunk(b, ships[i]);
      return 1; // only one ship can be sunk on each turn, logically
    }
  }
  return 0;
}

void printCoordinate(struct coordinate c) {
  printf("row %d, col %d\n",getRow(c),getCol(c));
}

int gameLoop(struct board *b, struct ship ships[]) { // returns 1 if win, 0 otherwise
  int shots = 11 + 0.1 * b->size * b->size;
  int shipsSunk = 0;

  while (shots > 0 && shipsSunk < 4) {
    printBoard(*b);
    struct coordinate c = askForCoordinate(shots);
    shots -= checkCoordinates(c,b);
    shipsSunk += handleSunkShips(b, ships);
  }
  if (shipsSunk >= 4) {
    printf("\nYou sunk all the ships, you win!\n");
    return 1;
  }
  else {
    printf("\nYou failed to sink all the ships, you lose!\n");
    return 0;
  }
}
