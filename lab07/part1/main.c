#include <stdint.h>
#include <stdio.h>

int main() {
  uint32_t array1[3][5];
  uint32_t array2[3][5][7];

  // initialize 2d array1
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 5; j++) {
      array1[i][j] = i*5+j+10;
    }
  }

  // initialize 3d array2
  for (int i = 0; i< 3; i++) {
    for (int j = 0; j< 5; j++) {
      for (int k = 0; k< 7; k++) {
	array2[i][j][k] = i*5*7+j*7+k+100;
      }
    }
  }

  printf("This is a two dimensional array displayed graphically in rows and columns\n");
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 5; j++) {
      printf("%d ",array1[i][j]);
    }
    printf("\n");
  }


  printf("This is a two dimensional array displayed as it is in memory\n");
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 5; j++) {
      printf("%d ",array1[i][j]);
    }
  }
  printf("\n");


  printf("This is a three dimensional array displayed graphically as layers\n");
  
  for (int i = 0; i< 3; i++) {
    for (int j = 0; j< 5; j++) {
      for (int k = 0; k< 7; k++) {
	printf("%d ",array2[i][j][k]);
      }
	  printf("\n");
    }
    printf("\n");
  }

  printf("This is a three dimensional array displayed as it is stored in memory\n");
  
  for (int i = 0; i< 3; i++) {
    for (int j = 0; j< 5; j++) {
      for (int k = 0; k< 7; k++) {
	printf("%d ",array2[i][j][k]);
      }
    }
  }

  printf("\n");
}
