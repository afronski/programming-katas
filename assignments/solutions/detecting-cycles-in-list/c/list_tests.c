#include <assert.h>

#include "minunit.h"

#include "list.h"

Node* List_create(int size)
{
  check(size > 0, "Size should be greater than 0.");

  Node* head = Node_create(0);
  Node* it = head;

  int i = 1;

  for (i = 1; i < size; ++i) {
    Node* actual = Node_create(i);

    it->next = actual;
    it = actual;
  }

  return head;

error:
  return NULL;
}

Node* List_create_cycle(int size)
{
  check(size >= 2, "Size should be equal to at least 2.");

  Node* head = Node_create(0);
  Node* it = head;

  int i = 1;

  for (i = 1; i < size; ++i) {
    Node* actual = Node_create(i);

    it->next = actual;
    it = actual;
  }

  it->next = head;

  return head;

error:
  return NULL;
}

Node* List_create_internal_cycle(int size)
{
  check(size >= 3, "Size should be equal to at least 3.");

  Node* head = Node_create(0);
  Node* neck = Node_create(1);

  head->next = neck;

  Node* it = neck;

  int i = 2;

  for (i = 2; i < size; ++i) {
    Node* actual = Node_create(i);

    it->next = actual;
    it = actual;
  }

  it->next = neck;

  return head;

error:
  return NULL;
}

// Test cases.

char* empty_list_does_not_have_cycle()
{
  return NULL;
}

char* test_for_list_built_from_one_element()
{
  return NULL;
}

char* test_for_straight_list()
{
  return NULL;
}

char* test_for_one_element_tied_in_loop()
{
  return NULL;
}

char* test_for_circle_from_two_nodes()
{
  return NULL;
}

char* test_for_circle_from_many_nodes()
{
  return NULL;
}

char* test_for_small_internal_cycle()
{
  return NULL;
}

char* test_for_big_internal_cycle()
{
  return NULL;
}

char* all_tests()
{
  mu_suite_start();

  mu_run_test(empty_list_does_not_have_cycle);
  mu_run_test(test_for_list_built_from_one_element);
  mu_run_test(test_for_straight_list);
  mu_run_test(test_for_one_element_tied_in_loop);
  mu_run_test(test_for_circle_from_two_nodes);
  mu_run_test(test_for_circle_from_many_nodes);
  mu_run_test(test_for_small_internal_cycle);
  mu_run_test(test_for_big_internal_cycle);

  return NULL;
}

RUN_TESTS(all_tests);