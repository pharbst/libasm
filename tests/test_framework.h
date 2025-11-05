#ifndef TEST_FRAMEWORK_H
#define TEST_FRAMEWORK_H

#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>

typedef int (*t_test_fn)(void);

typedef struct s_test_case {
    const char *name;
    t_test_fn fn;
}   t_test_case;

typedef struct s_test_suite {
    const char *name;
    const t_test_case *cases;
    size_t count;
}   t_test_suite;

int run_suites(const t_test_suite *const *suites, size_t suite_count);

#define ASSERT_TRUE(condition, message)                                                     \
    do {                                                                                    \
        if (!(condition)) {                                                                 \
            fprintf(stderr, "Assertion failed: %s (line %d): %s\n", __FILE__, __LINE__,    \
                    (message));                                                             \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#define ASSERT_EQ_INT(expected, actual)                                                     \
    do {                                                                                    \
        int _expected = (expected);                                                         \
        int _actual = (actual);                                                             \
        if (_expected != _actual) {                                                         \
            fprintf(stderr, "Assertion failed: %s (line %d): expected %d, got %d\n",         \
                    __FILE__, __LINE__, _expected, _actual);                                \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#define ASSERT_EQ_SIZE(expected, actual)                                                    \
    do {                                                                                    \
        size_t _expected = (expected);                                                      \
        size_t _actual = (actual);                                                          \
        if (_expected != _actual) {                                                         \
            fprintf(stderr, "Assertion failed: %s (line %d): expected %zu, got %zu\n",      \
                    __FILE__, __LINE__, _expected, _actual);                                \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#define ASSERT_EQ_SSIZE(expected, actual)                                                   \
    do {                                                                                    \
        ssize_t _expected = (expected);                                                     \
        ssize_t _actual = (actual);                                                         \
        if (_expected != _actual) {                                                         \
            fprintf(stderr, "Assertion failed: %s (line %d): expected %zd, got %zd\n",      \
                    __FILE__, __LINE__, _expected, _actual);                                \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#define ASSERT_EQ_STR(expected, actual)                                                     \
    do {                                                                                    \
        const char *_expected = (expected);                                                 \
        const char *_actual = (actual);                                                     \
        if ((_expected == NULL && _actual != NULL) ||                                       \
            (_expected != NULL && _actual == NULL) ||                                       \
            (_expected != NULL && _actual != NULL && strcmp(_expected, _actual) != 0)) {    \
            fprintf(stderr, "Assertion failed: %s (line %d): expected '%s', got '%s'\n",    \
                    __FILE__, __LINE__,                                                    \
                    _expected ? _expected : "(null)",                                      \
                    _actual ? _actual : "(null)");                                          \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#define ASSERT_EQ_MEM(expected, actual, length)                                             \
    do {                                                                                    \
        const unsigned char *_expected =                                                   \
            (const unsigned char *)(expected);                                              \
        const unsigned char *_actual =                                                     \
            (const unsigned char *)(actual);                                                \
        size_t _length = (length);                                                          \
        if (memcmp(_expected, _actual, _length) != 0) {                                     \
            fprintf(stderr, "Assertion failed: %s (line %d): buffers differ\n",             \
                    __FILE__, __LINE__);                                                    \
            return 1;                                                                       \
        }                                                                                   \
    } while (0)

#endif /* TEST_FRAMEWORK_H */
