#ifndef LINKED_LIST_H
#define LINKED_LIST_H

struct node
{
  int num;
  struct node *nextptr;
};

void append(struct node *n, int num);
void insert(struct node *n, int num, int index);
void displayList();
void free_list(struct node *n);

#endif
