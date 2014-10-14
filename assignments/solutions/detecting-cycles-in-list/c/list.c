#include <stdlib.h>

#include "dbg.h"
#include "list.h"

int List_has_cycle(Node* head)
{
  if (head == NULL) {
    return 0;
  }

  Node* fast = head;
  Node* faster = head;

  Node* slow = head;

  while (slow && (fast = faster->next) && (faster = fast->next)) {
    if (slow == fast || slow == faster) {
      return 1;
    }

    slow = slow->next;
  }

  return 0;
}

// Helpers.

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

  printf("List:\n");

  for (i = 0; i < n; ++i) {
    if (head == NULL) {
      break;
    }

    printf("  Element #%d: value '%d' at address '%p'\n",
           i, head->value, head);

    head = head->next;
  }
}