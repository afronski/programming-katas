#ifndef __list_h__
#define __list_h__

typedef struct Node {
  int value;

  struct Node* next;
} Node;

Node* Node_create(int value);

void List_print_n_elements(Node* head, int n);
int List_has_cycle(Node* head);

#endif