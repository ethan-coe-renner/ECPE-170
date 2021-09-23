#include "board.h"

struct coordinate {
  int row;
  int col;
};

struct coordinate askForCoordinate(int remainingShots);
int checkCoordinates(struct coordinate c, struct board *b);
void printCoordinate(struct coordinate c);
void gameLoop(struct board *b, struct ship ships[]);
