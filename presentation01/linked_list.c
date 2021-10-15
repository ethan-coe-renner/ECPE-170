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

void delete(struct node *n, int index) {
  struct node * current = n;
  while (current->nextptr != NULL && index > 1) {
    current = current->nextptr;
    index--;
  }

  struct node * temp = current->nextptr;

  current->nextptr = temp->nextptr;
  free(temp); // deletion of this line creates a memory leak
}

void displayList(struct node *n) {
  struct node * current = n;
  while (current != NULL) { // change to while (1) to cause seg fault
    /* while (1) { */
    printf("%d ", current->num);
    current = current->nextptr;
  }
  printf("\n");
}

void free_list(struct node *n) {
  if (n->nextptr == NULL) {
    free(n);
  }
  else {
    free_list(n->nextptr);
    free(n);
  }
}
