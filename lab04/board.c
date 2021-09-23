#include "board.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

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

void clearBoard(struct board *b) {
  for (int i = 0; i< b->size; i++) {
    b->matrix[i] = malloc(b->size * sizeof(char));
    for (int j = 0; j < b->size; j++) {
      b->matrix[i][j] = '~';
    }
  }
}

int numDigits(int n) {
  int digits = 0;
  while (n > 0) {
    ++digits;
    n = n / 10;
  }
  return digits;
}

void printBoard(struct board b) {
  int digits = numDigits(b.size);
  printf("\n  ");
  for (int i = 0; i< digits+1; i++) {
    printf(" ");
  }
  for(int i = 0; i < b.size; i++) {
    printf("%c ",65+i);
  }
  printf("\n");
  for (int i = 0; i< digits+1; i++) {
    printf(" ");
  }
  printf("+");
  for (int i = 0; i< b.size; i++) {
    printf("--");
  }
  printf("\n");
  for (int i = 0; i< b.size; i++) {
    printf("%d",i+1);
    for (int g = 0; g < digits-numDigits(i+1)+1; g++) {
      printf(" ");
      
    }
    printf("|");
    for (int j = 0; j < b.size; j++) {
      char c = b.matrix[i][j];
      if (c == '~' || c == 'a' || c == 'd' || c == 'g') // c is a hidden type or ocean
	printf(" %c",'~');
      else
	printf(" %c", c);
    }
    printf("\n");
  }
}

int addShipsToBoard(struct board *b, struct ship ships[], int size) { //returns 0 if succesful, -1 if need to re generate ships
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < ships[i].size; j++) {
      if (ships[i].vert) {
	if (b->matrix[ships[i].row+j-1][ships[i].col-1] == '~') {
	  b->matrix[ships[i].row+j-1][ships[i].col-1] = ships[i].hiddenType;
	  /* b->matrix[ships[i].row+j-1][ships[i].col-1] = ships[i].type; */
	}
	else return -1;
      }
      else {
	if (b->matrix[ships[i].row-1][ships[i].col+j-1] == '~') {
	  b->matrix[ships[i].row-1][ships[i].col+j-1] = ships[i].hiddenType;
	  /* b->matrix[ships[i].row-1][ships[i].col+j-1] = ships[i].type; */
	}
	else return -1;
      }
    }
  }
  return 0;
}

void makeShipSunk(struct board *b, struct ship s) {
  for (int j = 0; j < s.size; j++) {
    if (s.vert)
      b->matrix[s.row+j-1][s.col-1] = s.type;
    else
      b->matrix[s.row-1][s.col+j-1] = s.type;
  }
}
