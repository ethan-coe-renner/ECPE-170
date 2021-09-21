#include <stdio.h>
#include <ctype.h>
#include "game.h"


struct coordinate askForCoordinate(int remainingShots) {
  char coordinate1;
  char coordinate2;
  struct coordinate coordinates;
  printf("Enter the coordinate for your shot (%d shots remaining): ",remainingShots);
  scanf("%c%c", &coordinate1,&coordinate2);

  if (isdigit(coordinate1)) {
    coordinates.row = (int)coordinate1-49; 
    coordinates.col = (int)tolower(coordinate2)-97; 
  }
  else {
    coordinates.row = (int)tolower(coordinate2)-97;
    coordinates.col = (int)coordinate1-49;
  }
  
  return coordinates;
}

void checkCoordinates(struct coordinate c, struct board *b) {
  if (b->matrix[c.row][c.col] != '~') {
    printf("%d%d is a HIT", c.col, c.row+1);
    b->matrix[c.row][c.col] = 'h';
  }
  else {
    printf("%d%d is a MISS", c.col, c.row+1);
    b->matrix[c.row][c.col] = 'm';
  }
}

