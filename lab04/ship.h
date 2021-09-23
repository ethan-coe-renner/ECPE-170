#ifndef SHIP_H
#define SHIP_H

#include <stdbool.h>

struct ship {
  char type;
  char hiddenType;
  int size;
  int row;
  int col;
  bool vert;
};
void assignSize(struct ship *s);
void assignHiddenType(struct ship *s);
char mapHiddenTypeToType(char c);
struct ship * readShipsFromFile(char *file, int size);
struct ship * generateRandomShips(int size);

#endif
