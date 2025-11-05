#ifndef TEST_LIBASM_WRAPPERS_H
#define TEST_LIBASM_WRAPPERS_H

#include "libasm.h"

#ifndef FT_STRLEN
# define FT_STRLEN _ft_strlen
#endif

#ifndef FT_STRCMP
# define FT_STRCMP _ft_strcmp
#endif

#ifndef FT_STRCPY
# define FT_STRCPY _ft_strcpy
#endif

#ifndef FT_WRITE
# define FT_WRITE _ft_write
#endif

#ifndef FT_READ
# define FT_READ _ft_read
#endif

#ifndef FT_STRDUP
# define FT_STRDUP _ft_strdup
#endif

#endif /* TEST_LIBASM_WRAPPERS_H */
