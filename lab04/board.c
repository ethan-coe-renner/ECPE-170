#include "board.h"
#include <stdlib.h>
#include <stdio.h>

struct board newboard(int size) {
  struct board b;
  b.size = size;
  b.matrix = malloc(b.size * sizeof(char*));
  for (int i = 0; i< size; i++) {
    b.matrix[i] = malloc(b.size * sizeof(char));
    for (int j = 0; j < size; j++) {
      b.matrix[i][j] = '~';
    }
  }
  return b;
};

void printBoard(struct board b) {
  printf("\n    ");
  for(int i = 0; i < b.size; i++) {
    printf("%c ",65+i);
  }
  printf("\n  +----------\n");
  for (int i = 0; i< b.size; i++) {
    printf("%d |",i+1);
    for (int j = 0; j < b.size; j++) {
      printf(" %c",b.matrix[i][j]);
    }
    printf("\n");
  }
}

void addShipsToBoard(struct board *b, struct ship ships[], int n) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < ships[i].size; j++) {
      if (ships[i].vert)
	b->matrix[ships[i].row+j-1][ships[i].col-1] = ships[i].type;
      else
	b->matrix[ships[i].row-1][ships[i].col+j-1] = ships[i].type;
    }
  }
}
