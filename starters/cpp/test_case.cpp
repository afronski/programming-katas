#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MODULE HELLO_WORLD
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(HELLO_WORLD)
{
    BOOST_CHECK_EQUAL(2, 2);
}