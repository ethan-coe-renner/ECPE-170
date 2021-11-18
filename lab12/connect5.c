#include <stdio.h>
#include <stdlib.h>
#include "connect5.h"

int m_w;    /* must not be zero */ 
int m_z; /* must not be zero */

int main() {
  int rows = 5;
  int cols = 7;
  char *board = newboard(rows,cols);
  /* introduction(); */
  dropChar(board, 'H', 3, rows, cols);
  dropChar(board, 'H', 3, rows, cols);
  dropChar(board, 'H', 3, rows, cols);
  dropChar(board, 'H', 3, rows, cols);
  dropChar(board, 'H', 3, rows, cols);
  printBoard(board, rows, cols);
}

// prints introduction text and decides first player
int introduction() {
  printf("Welcome to Connect Four, Five in a row variant!");
  printf("Implemented by Ethan Coe-Renner");
  printf("Enter two positive numbers to initilize the random number generator.");
  printf("Number 1: ");
  scanf("%d", &m_w);
  printf("Number 2: ");
  scanf("%d", &m_z);
  printf("Human player (H)");
  printf("Computer Player (C)");
  printf("Coin toss... ");
  int first = random_in_range(0, 1);
  if (first) {
    printf("HUMAN goes first.");
  }
  else {
    printf("COMPUTER goes first.");
  }
  return first;
}

char * newboard(int rows, int cols) {
  char *board = malloc((rows * cols + 2) * sizeof(char)); // store last added cell in last 2 spaces
  for (int i = 0; i < rows * cols; i++) {
    board[i] = '.';
  }
  return board;
}

void gameLoop(char board[], int rows, int cols, int first) {
  int won = 1;
  while (!won) {
    if (first) { // human first
      // TODO: human turn
      // TODO: check win
      computerTurn(board, rows, cols);
      // TODO: check win
    }

    else {
      computerTurn(board,rows, cols);
      // TODO: check win
      // TODO: human turn
      // TODO: check win
    }
  }
}

void printBoard(char board[], int rows, int cols) {
  for (int i = 1; i <=cols; i++) {
    printf("%d ", i);
  }

  printf("\n");

  for (int i = 1; i <=cols; i++) {
    printf("--");
  }

  printf("\n");

  for (int i = 0; i < cols * rows; i++) {
    printf("%c ", board[i]);
    if ((i + 1) % cols == 0) {
      printf("\n");
    }
  }
}

// checks every line from current node
// returns 1 if win condition, 0 otherwise
int checkWin(char board[], int rows, int cols) {
  int row = (int)board[rows*cols] - 1; // last row added
  int col = (int)board[rows*cols+1]; // last col added

  return
    checkLine(board, cols, row, col, 1,-1) ||
    checkLine(board, cols, row, col, 1,1) ||
    checkLine(board, cols, row, col, 0,1) ||
    checkLine(board, cols, row, col, 1,0);
}

// checks along a line defined by the slope drow/dcol
// returns 1 if win condition, 0 otherwise
int checkLine(char board[], int cols, int row, int col, int drow, int dcol) {
  int currow = row+drow;
  int curcol = col+dcol;
  int length = 1;

  while (board[getIndex(cols, currow, curcol)] == board[getIndex(cols,row, col)]) { // compare current cell to start cell
    length++;
    currow += drow;
    curcol += dcol;
  }

  drow *= -1;
  dcol *= -1;

  currow = row+drow;
  curcol = col+dcol;


  while (board[getIndex(cols, currow, curcol)] == board[getIndex(cols,row, col)]) { // compare current cell to start cell
    length++;
    currow += drow;
    curcol += dcol;
  }
  
  return length >= 5;
}
  
// gives the index in board of row and col
int getIndex(int cols, int row, int col) {
  return row * cols + col -1;
}

// attempts to drop a piece c in the given col, returns 1 if full
int dropChar(char board[], char c, int col, int rows, int cols) {
  int curcell = (rows-1) * cols + col; // index of bottom cell in chosen col

  int row = 1;
  while (board[curcell] != '.' && curcell >= 0) {
    curcell -= cols; // go one row up
    row++;
  }

  if (curcell < 0) {
    return 1; // column is full
  }

  board[curcell] = c;
  board[rows*cols] = row; 
  board[rows*cols+1] = col;
    return 0;
}

void computerTurn(char board[], int rows, int cols) {
  int col = random_in_range(1, cols);

  while (!dropChar(board, 'C', col, rows, cols)) {
    col = random_in_range(1, cols); // regenerate random col if col full
    // TODO: could get caught in loop if board full
  }
}


uint32_t get_random()
{
  m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  return (m_z << 16) + m_w; /* 32-bit result */
}


uint32_t random_in_range(uint32_t low, uint32_t high)
{
  uint32_t range = high-low+1;
  uint32_t rand_num = get_random();

  return (rand_num % range) + low;
}
