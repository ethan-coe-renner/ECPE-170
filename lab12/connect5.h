#include <stdint.h>

int introduction();

char * newboard(int rows, int cols);

void printBoard(char board[], int rows, int cols);

int dropChar(char board[], char c, int col, int rows, int cols);

int checkLine(char board[], int cols, int row, int col, int drow, int dcol);

int checkWin(char board[], int rows, int cols);

int getIndex(int cols, int row, int col);

void computerTurn(char board[], int rows, int cols);

uint32_t get_random();

uint32_t random_in_range(uint32_t low, uint32_t high);
