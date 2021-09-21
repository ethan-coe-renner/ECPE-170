#include "ship.h"
#include <stdio.h>
#include <stdlib.h>

void assignSize(struct ship *s) {
  if (s[0].type == 'b')
    s[0].size = 4;
  else if (s[0].type == 'f')
    s[0].size = 2;
  else if (s[0].type == 'c')
    s[0].size = 5;
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
    ships[i] = newship;
    i++;
  }
  fclose(ptr_file);

  return ships;

}
