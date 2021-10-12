#ifndef LINKED_LIST_H
#define LINKED_LIST_H

struct node
{
  int num;
  struct node *nextptr;
};

void append(struct node *n, int num);
void delete(struct node *n, int index);
void displayList();
void free_list(struct node *n);

#endif
