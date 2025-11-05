#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <string.h>

static int run_case(const char *source)
{
    char dest_ft[128];
    char dest_std[128];

    memset(dest_ft, 0xAA, sizeof(dest_ft));
    memset(dest_std, 0xAA, sizeof(dest_std));

    char *ft_ret = FT_STRCPY(dest_ft, source);
    char *std_ret = strcpy(dest_std, source);

    ASSERT_TRUE(ft_ret == dest_ft, "FT_STRCPY should return destination pointer");
    ASSERT_TRUE(std_ret == dest_std, "strcpy should return destination pointer");
    ASSERT_EQ_STR(dest_std, dest_ft);
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
    return run_case("Lorem ipsum dolor sit amet, consectetur adipiscing elit.");
}

static const t_test_case g_strcpy_cases[] = {
    {"basic copy", test_basic},
    {"empty string", test_empty},
    {"long string", test_long},
};

static const t_test_suite g_strcpy_suite = {
    .name = "FT_STRCPY",
    .cases = g_strcpy_cases,
    .count = sizeof(g_strcpy_cases) / sizeof(g_strcpy_cases[0]),
};

const t_test_suite *get_strcpy_suite(void)
{
    return &g_strcpy_suite;
}
