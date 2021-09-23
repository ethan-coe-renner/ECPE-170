#include <stdio.h>
#include "ship.h"
#include "board.h"
#include "game.h"

int setup();

int main()
{
  int size = setup();
  struct ship *ships = readShipsFromFile("demo_file.txt", 4);

  struct board board = newboard(size);
  addShipsToBoard(&board, ships, 4);

  gameLoop(&board, ships);
  return 0;
}

int setup() { // gets the grid size from the user
  int size;
  printf("Welcome to Frigate!\n\nHow large should I make the grid? ");
  scanf("%d", &size);
  if (size < 5) {
    printf("The minimum grid size is 5... I'll create one that size.");
    size = 5;
  }
  return size;
}
