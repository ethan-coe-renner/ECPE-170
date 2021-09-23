#include "ship.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void assignSize(struct ship *s) {
  if (s[0].type == 'b')
    s[0].size = 4;
  else if (s[0].type == 'f')
    s[0].size = 2;
  else if (s[0].type == 'c')
    s[0].size = 5;
}

void assignHiddenType(struct ship *s) {
  if (s->type == 'b') {
    s->hiddenType = 'a';
  }
  else if (s-> type == 'c') {
    s-> hiddenType = 'd';
  }
  else if (s-> type == 'f') {
    s-> hiddenType = 'g';
  }
}

struct ship * readShipsFromFile(char *file, int size) {
  FILE *ptr_file;
  char buf[1000];
  ptr_file = fopen(file,"r");
  if (!ptr_file)
    return NULL;

  struct ship *ships = malloc(sizeof(struct ship) * size);

  int i = 0;
  while (fgets(buf,1000, ptr_file)!= NULL) {
    if (buf[0] == '#') {
      continue;
    }
    struct ship newship;
    newship.type = buf[0];
    newship.vert = buf[2] == 'r';
    newship.col = (int)buf[4] - 96;
    newship.row = (int)buf[5] - 48;
    assignSize(&newship);
    assignHiddenType(&newship);
    ships[i] = newship;
    i++;
  }
  fclose(ptr_file);

  return ships;

}

struct ship * generateRandomShips(int size) {
  char shipTypes[] = {'c','b','f','f'};
  struct ship *ships = malloc(sizeof(struct ship) * 4);
  // for i in range 4
  // generate ship of type shipTypes[i]
  // figure out if ship should be vertical or horizontal
  // generate random number in range of possible values given the size of the matrix and length of current ship
  srand(time(0));
  for (int i = 0; i<4;i++) {
    struct ship newship;
    newship.type = shipTypes[i];
    assignHiddenType(&newship);
    newship.vert = rand() % 2 == 0; // randomly decide if vertical
    assignSize(&newship);
    if (newship.vert) {
      newship.row = rand() % (size-newship.size + 1) + 1;
      newship.col = rand() % size + 1;
    }
    else {
      newship.row = rand() % size + 1;
      newship.col = rand() % (size - newship.size + 1) + 1;
    }
    ships[i] = newship;
  }
  return ships;
}
