/*
  Frigate Game
  Ethan Coe-Renner
  e_coerenner@u.pacific.edu
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ship.h"
#include "board.h"
#include "game.h"

int setup();
char askPlayAgain();

int main(int argc, char *argv[])
{
  int size = setup(); // get board size
  int games = 0;
  int gamesWon = 0;
  char playAgain = 'y';
  struct ship *ships;
  if (argc == 2)
    ships = readShipsFromFile(argv[1], 4); // read ship location from file if provided
  else
    ships = generateRandomShips(size);

  struct board board = newboard(size);
  while (playAgain == 'y') {
    while (addShipsToBoard(&board,ships,4) == -1) { // regenerate ships if they overlap or extend outside the size of the board
      free(ships);
      ships = generateRandomShips(size);
      clearBoard(&board);
    }   

    gamesWon += gameLoop(&board, ships);
    games++;
    playAgain = askPlayAgain();
  }

  printf("\nYou won %d out of %d games\n", gamesWon, games);
  printf("\nThanks for playing!\n");
  /* free(board.matrix); */
  /* free(ships); */
  return 0;
}

char askPlayAgain(){
  printf("Play again (y/N)?");
  char response[5] = "n";
  scanf("%s",response);
  if (strstr(response, "y"))
    return 'y';
  return 'N';
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
