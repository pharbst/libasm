#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <errno.h>
#include <string.h>
#include <unistd.h>

static int run_write_case(const char *payload, size_t len)
{
    int pipe_ft[2];
    int pipe_std[2];

    ASSERT_TRUE(pipe(pipe_ft) == 0, "failed to create pipe for FT_WRITE");
    ASSERT_TRUE(pipe(pipe_std) == 0, "failed to create pipe for write");

    errno = 0;
    ssize_t ft_ret = FT_WRITE(pipe_ft[1], payload, len);
    int ft_errno = errno;
    close(pipe_ft[1]);

    errno = 0;
    ssize_t std_ret = write(pipe_std[1], payload, len);
    int std_errno = errno;
    close(pipe_std[1]);

    ASSERT_EQ_SSIZE(std_ret, ft_ret);
    ASSERT_EQ_INT(std_errno, ft_errno);

    char ft_buf[256] = {0};
    char std_buf[256] = {0};

    ssize_t ft_read_len = read(pipe_ft[0], ft_buf, sizeof(ft_buf));
    ssize_t std_read_len = read(pipe_std[0], std_buf, sizeof(std_buf));
    close(pipe_ft[0]);
    close(pipe_std[0]);

    ASSERT_EQ_SSIZE(std_read_len, ft_read_len);
    ASSERT_EQ_MEM(std_buf, ft_buf, (size_t)std_read_len);
    return 0;
}

static int test_basic(void)
{
    const char *msg = "Hello from FT_WRITE";
    return run_write_case(msg, strlen(msg));
}

static int test_partial(void)
{
    const char *msg = "Binary\0data";
    return run_write_case(msg, 11);
}

static int test_error(void)
{
    const char *msg = "error";

    errno = 0;
    ssize_t ft_ret = FT_WRITE(-1, msg, strlen(msg));
    int ft_errno = errno;

    errno = 0;
    ssize_t std_ret = write(-1, msg, strlen(msg));
    int std_errno = errno;

    ASSERT_EQ_SSIZE(std_ret, ft_ret);
    ASSERT_EQ_INT(std_errno, ft_errno);
    return 0;
}

static const t_test_case g_write_cases[] = {
    {"basic write", test_basic},
    {"partial write", test_partial},
    {"error handling", test_error},
};

static const t_test_suite g_write_suite = {
    .name = "FT_WRITE",
    .cases = g_write_cases,
    .count = sizeof(g_write_cases) / sizeof(g_write_cases[0]),
};

const t_test_suite *get_write_suite(void)
{
    return &g_write_suite;
}
