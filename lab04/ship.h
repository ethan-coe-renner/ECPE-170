#ifndef SHIP_H
#define SHIP_H

#include <stdbool.h>

struct ship {
  char type;
  int size;
  int row;
  int col;
  bool vert;
};
void assignSize(struct ship *s);
struct ship * readShipsFromFile(char *file, int size);

#endif
