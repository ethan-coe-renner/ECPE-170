#ifndef LINKED_LIST_H
#define LINKED_LIST_H

struct node
{
  int num;
  struct node *nextptr;
};

void append(struct node *n, int num);
void displayList();

#endif
