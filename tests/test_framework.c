#include "test_framework.h"

#include <errno.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

static int run_case(const t_test_case *test)
{
    pid_t pid = fork();

    if (pid == -1)
    {
        fprintf(stderr, "Failed to fork for test '%s': %s\n", test->name, strerror(errno));
        return -1;
    }
    if (pid == 0)
    {
        int result = test->fn ? test->fn() : 1;
        _exit(result);
    }
    int status = 0;
    if (waitpid(pid, &status, 0) == -1)
    {
        fprintf(stderr, "waitpid failed for test '%s': %s\n", test->name, strerror(errno));
        return -1;
    }
    if (WIFEXITED(status))
        return WEXITSTATUS(status);
    if (WIFSIGNALED(status))
    {
        fprintf(stderr, "Test '%s' terminated by signal %d\n", test->name, WTERMSIG(status));
        return -1;
    }
    return -1;
}

int run_suites(const t_test_suite *const *suites, size_t suite_count)
{
    size_t total = 0;
    size_t failed = 0;

    for (size_t i = 0; i < suite_count; ++i)
    {
        const t_test_suite *suite = suites[i];

        if (!suite || !suite->cases)
            continue;
        printf("\n=== %s ===\n", suite->name);
        for (size_t j = 0; j < suite->count; ++j)
        {
            const t_test_case *test = &suite->cases[j];
            int result = run_case(test);

            if (result == 0)
            {
                printf("[OK]   %s\n", test->name);
            }
            else
            {
                printf("[FAIL] %s\n", test->name);
                ++failed;
            }
            ++total;
        }
    }
    printf("\nSummary: %zu/%zu tests passed\n", total - failed, total);
    return failed == 0 ? 0 : 1;
}
