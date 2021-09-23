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

int checkCoordinates(struct coordinate c, struct board *b) { // returns 0 if a shot was fired, returns 1 if no shot was fired
  if (!coordinateInBounds(c, *b)) {
    printf("Coordinate out of bounds, no shot fired\n");
    return 1;
  }
  if (b->matrix[getRow(c)][getCol(c)] == '~') {
    printf("%c%d is a MISS\n", c.col, c.row);
    b->matrix[getRow(c)][getCol(c)] = 'm';
    return 0;
  }
  if (b->matrix[getRow(c)][getCol(c)] == 'm' || b->matrix[getRow(c)][getCol(c)] == 'h') {
    printf("you already fired there.\n");
    return 1;
  }
  printf("%c%d is a HIT\n", c.col, c.row);
  b->matrix[getRow(c)][getCol(c)] = 'h';
  return 0;
}


void printCoordinate(struct coordinate c) {
  printf("row %d, col %d\n",getRow(c),getCol(c));
}
