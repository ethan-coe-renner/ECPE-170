#include <stdio.h>
#include "ship.h"
#include "board.h"

int main()
{
  struct ship *ships = readShipsFromFile("demo_file.txt", 4);

  for (int i = 0; i < 4; i++) {
    printShip(ships[i]);
  }

  struct board board = newboard(9);
  addShipsToBoard(&board, ships, 4);

  printBoard(board);

  return 0;
}
