#include "test_framework.h"
#include "test_libasm_wrappers.h"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

static int run_read_case(const char *payload, size_t len, size_t read_len)
{
    FILE *fp = tmpfile();

    ASSERT_TRUE(fp != NULL, "failed to create temporary file");
    ASSERT_EQ_SIZE(len, fwrite(payload, 1, len, fp));

    int fd = fileno(fp);
    char ft_buf[256] = {0};
    char std_buf[256] = {0};

    errno = 0;
    lseek(fd, 0, SEEK_SET);
    ssize_t ft_ret = FT_READ(fd, ft_buf, read_len);
    int ft_errno = errno;

    errno = 0;
    lseek(fd, 0, SEEK_SET);
    ssize_t std_ret = read(fd, std_buf, read_len);
    int std_errno = errno;

    fclose(fp);

    ASSERT_EQ_SSIZE(std_ret, ft_ret);
    ASSERT_EQ_INT(std_errno, ft_errno);
    if (ft_ret > 0 && std_ret > 0)
        ASSERT_EQ_MEM(std_buf, ft_buf, (size_t)std_ret);
    return 0;
}

static int test_basic(void)
{
    const char *msg = "Hello from FT_READ";
    return run_read_case(msg, strlen(msg), strlen(msg));
}

static int test_partial(void)
{
    const char *msg = "partial read";
    return run_read_case(msg, strlen(msg), 5);
}

static int test_error(void)
{
    char buffer[10];

    errno = 0;
    ssize_t ft_ret = FT_READ(-1, buffer, sizeof(buffer));
    int ft_errno = errno;

    errno = 0;
    ssize_t std_ret = read(-1, buffer, sizeof(buffer));
    int std_errno = errno;

    ASSERT_EQ_SSIZE(std_ret, ft_ret);
    ASSERT_EQ_INT(std_errno, ft_errno);
    return 0;
}

static const t_test_case g_read_cases[] = {
    {"basic read", test_basic},
    {"partial read", test_partial},
    {"error handling", test_error},
};

static const t_test_suite g_read_suite = {
    .name = "FT_READ",
    .cases = g_read_cases,
    .count = sizeof(g_read_cases) / sizeof(g_read_cases[0]),
};

const t_test_suite *get_read_suite(void)
{
    return &g_read_suite;
}
