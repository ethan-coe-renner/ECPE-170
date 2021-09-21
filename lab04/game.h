#include "board.h"

struct coordinate {
  int row;
  int col;
};

struct coordinate askForCoordinate(int remainingShots);
void checkCoordinates(struct coordinate c, struct board *b);
