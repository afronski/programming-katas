#include <stdlib.h>

#include "dbg.h"
#include "list.h"

Node* Node_create(int value)
{
  Node* node = calloc(1, sizeof(Node));
  check_mem(node)

  node->value = value;
  node->next = NULL;

  return node;

error:
  return NULL;
}

void List_print_n_elements(Node* head, int n)
{
  int i = 0;

  for (i = 0; i < n; ++i) {
    if (head == NULL) {
      break;
    }

    printf("List element - value '%d' on position '%d' at address '%p'.\n",
           head->value, i, head);

    head = head->next;
  }
}

int List_detect_cycle(Node* head)
{
  return 0;
}