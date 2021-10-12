#include "linked_list.h"
#include <stdlib.h>
#include <stdio.h>

void append(struct node *n, int num) {
  struct node * current = n;
  while (current->nextptr != NULL) {
    current = current->nextptr;
  }

  current->nextptr = (struct node *)malloc(sizeof(struct node));
  current->nextptr->num = num;
  current->nextptr->nextptr = NULL;
}

void displayList(struct node *n) {
  struct node * current = n;
  while (current != NULL) {
    printf("%d ", current->num);
    current = current->nextptr;
  }
  printf("\n");
}
