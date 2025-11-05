#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <string.h>

static int run_case(const char *lhs, const char *rhs)
{
    int expected = strcmp(lhs, rhs);
    int actual = FT_STRCMP(lhs, rhs);

    ASSERT_EQ_INT((expected > 0) - (expected < 0), (actual > 0) - (actual < 0));
    ASSERT_EQ_INT(expected, actual);
    return 0;
}

static int test_equal(void)
{
    return run_case("Hello", "Hello");
}

static int test_less(void)
{
    return run_case("Apple", "Banana");
}

static int test_greater(void)
{
    return run_case("Banana", "Apple");
}

static int test_prefix(void)
{
    return run_case("Test", "Testing");
}

static const t_test_case g_strcmp_cases[] = {
    {"equal strings", test_equal},
    {"less than", test_less},
    {"greater than", test_greater},
    {"prefix comparison", test_prefix},
};

static const t_test_suite g_strcmp_suite = {
    .name = "FT_STRCMP",
    .cases = g_strcmp_cases,
    .count = sizeof(g_strcmp_cases) / sizeof(g_strcmp_cases[0]),
};

const t_test_suite *get_strcmp_suite(void)
{
    return &g_strcmp_suite;
}
