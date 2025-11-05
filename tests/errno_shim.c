#include <errno.h>

extern int *__errno_location(void);

int *errno_location(void)
{
    return __errno_location();
}
