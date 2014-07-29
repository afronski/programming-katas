#include "minunit.h"
#include <assert.h>

char* test_case()
{
  return NULL;
}

char* all_tests()
{
  mu_suite_start();

  mu_run_test(test_case);

  return NULL;
}

RUN_TESTS(all_tests);