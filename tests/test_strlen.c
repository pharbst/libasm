#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <string.h>

static int run_case(const char *input)
{
    size_t expected = strlen(input);
    size_t actual = FT_STRLEN(input);

    ASSERT_EQ_SIZE(expected, actual);
    return 0;
}

static int test_empty(void)
{
    return run_case("");
}

static int test_alpha(void)
{
    return run_case("Hello, world!");
}

static int test_binary(void)
{
    const char payload[] = {'a', '\0', 'b', '\0'};

    size_t expected = strlen(payload);
    size_t actual = FT_STRLEN(payload);

    ASSERT_EQ_SIZE(expected, actual);
    return 0;
}

static const t_test_case g_strlen_cases[] = {
    {"empty string", test_empty},
    {"alphabetic characters", test_alpha},
    {"embedded null bytes", test_binary},
};

static const t_test_suite g_strlen_suite = {
    .name = "FT_STRLEN",
    .cases = g_strlen_cases,
    .count = sizeof(g_strlen_cases) / sizeof(g_strlen_cases[0]),
};

const t_test_suite *get_strlen_suite(void)
{
    return &g_strlen_suite;
}
