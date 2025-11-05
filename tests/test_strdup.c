#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <stdlib.h>
#include <string.h>

static int run_case(const char *source)
{
    char *expected = strdup(source);
    char *actual = FT_STRDUP(source);

    ASSERT_TRUE((expected == NULL) == (actual == NULL),
        "FT_STRDUP and strdup should both succeed or fail");
    if (expected && actual)
    {
        ASSERT_EQ_STR(expected, actual);
    }
    free(expected);
    free(actual);
    return 0;
}

static int test_basic(void)
{
    return run_case("Hello");
}

static int test_empty(void)
{
    return run_case("");
}

static int test_long(void)
{
    return run_case("The quick brown fox jumps over the lazy dog");
}

static const t_test_case g_strdup_cases[] = {
    {"basic duplicate", test_basic},
    {"empty string", test_empty},
    {"long string", test_long},
};

static const t_test_suite g_strdup_suite = {
    .name = "FT_STRDUP",
    .cases = g_strdup_cases,
    .count = sizeof(g_strdup_cases) / sizeof(g_strdup_cases[0]),
};

const t_test_suite *get_strdup_suite(void)
{
    return &g_strdup_suite;
}
