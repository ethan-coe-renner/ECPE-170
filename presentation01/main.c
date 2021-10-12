#include "linked_list.h"
#include <stdlib.h>

int main(){
  struct node *l = NULL;
  l = malloc(sizeof(struct node));
  l->num = 1;
  l->nextptr = NULL;

  append(l,2);
  append(l,3);
  append(l,4);
  append(l,5);
  append(l,6);
  append(l,7);
  append(l,8);
  append(l,9);
  append(l,10);
  displayList(l);
  insert(l,20,5);
  displayList(l);
  free_list(l);
}
