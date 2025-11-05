#include "test_framework.h"

const t_test_suite *get_strlen_suite(void);
const t_test_suite *get_strcpy_suite(void);
const t_test_suite *get_strcmp_suite(void);
const t_test_suite *get_strdup_suite(void);
const t_test_suite *get_write_suite(void);
const t_test_suite *get_read_suite(void);

int main(void)
{
    const t_test_suite *suites[] = {
        get_strlen_suite(),
        get_strcpy_suite(),
        get_strcmp_suite(),
        get_strdup_suite(),
        get_write_suite(),
        get_read_suite(),
    };
    return run_suites(suites, sizeof(suites) / sizeof(suites[0]));
}
