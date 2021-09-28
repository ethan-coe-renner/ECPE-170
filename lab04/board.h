#ifndef BOARD_H
#define BOARD_H

#include "ship.h"

struct board {
  char ** matrix;
  int size;
};

struct board newboard(int size);
void clearBoard(struct board *b);
void freeBoard(struct board *b);
void printBoard(struct board b);
int addShipsToBoard(struct board *b, struct ship ships[], int n);
void makeShipSunk(struct board *b,struct ship s);

#endif
