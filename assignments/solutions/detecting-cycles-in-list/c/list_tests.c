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

Node* List_create_cycle_at_the_end(int size)
{
  Node* head = List_create(size);
  Node* it = head;

  while (it->next) {
    it = it->next;
  }

  it->next = it;

  return head;
}

Node* List_create_cycle(int size)
{
  check(size >= 2, "Size should be equal to at least 2.");

  Node* head = Node_create(0);
  Node* neck = List_create(size - 1);

  head->next = neck;

  Node* it = head;

  while (it->next) {
    it = it->next;
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

  Node* backbone = List_create(size - 2);

  neck->next = backbone;

  Node* it = head;

  while (it->next) {
    it = it->next;
  }

  it->next = neck;

  return head;

error:
  return NULL;
}

// Test cases.

char* empty_list_does_not_have_cycle()
{
  mu_assert(List_has_cycle(NULL) == 0, "Empty list does not have cycle.");

  return NULL;
}

char* test_for_list_built_from_one_element()
{
  Node* head = Node_create(0);

  mu_assert(List_has_cycle(head) == 0, "List from one element does not have cycle.");

  return NULL;
}

char* test_for_straight_list()
{
  Node* head = List_create(10);

  mu_assert(List_has_cycle(head) == 0, "Straight list does not have cycle.");

  return NULL;
}

char* test_for_straight_list_and_cycle_at_the_end()
{
  Node* head = List_create_cycle_at_the_end(10);

  mu_assert(List_has_cycle(head) == 1, "Straight list with cycle at the end.");

  return NULL;
}

char* test_for_one_element_tied_in_loop()
{
  Node* head = Node_create(0);
  head->next = head;

  mu_assert(List_has_cycle(head) == 1, "Cycle on list with one node.");

  return NULL;
}

char* test_for_circle_from_two_nodes()
{
  Node* head = List_create_cycle(2);

  mu_assert(List_has_cycle(head) == 1, "Cycle on list with two nodes.");

  return NULL;
}

char* test_for_circle_from_many_nodes()
{
  Node* head = List_create_cycle(10);

  mu_assert(List_has_cycle(head) == 1, "Cycle on list with many nodes.");

  return NULL;
}

char* test_for_small_internal_cycle()
{
  Node* head = List_create_internal_cycle(3);

  mu_assert(List_has_cycle(head) == 1, "Internal cycle on list with three nodes.");

  return NULL;
}

char* test_for_big_internal_cycle()
{
  Node* head = List_create_internal_cycle(10);

  mu_assert(List_has_cycle(head) == 1, "Internal cycle on list with many nodes.");

  return NULL;
}

char* all_tests()
{
  mu_suite_start();

  mu_run_test(empty_list_does_not_have_cycle);
  mu_run_test(test_for_list_built_from_one_element);
  mu_run_test(test_for_straight_list);
  mu_run_test(test_for_straight_list_and_cycle_at_the_end);
  mu_run_test(test_for_one_element_tied_in_loop);
  mu_run_test(test_for_circle_from_two_nodes);
  mu_run_test(test_for_circle_from_many_nodes);
  mu_run_test(test_for_small_internal_cycle);
  mu_run_test(test_for_big_internal_cycle);

  return NULL;
}

RUN_TESTS(all_tests);