/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pharbst <pharbst@student.42heilbronn.de>   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/02 13:18:25 by pharbst           #+#    #+#             */
/*   Updated: 2026/04/23 23:13:40 by pharbst          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static int	g_failures = 0;

static void	check_int(const char *name, long got, long expected)
{
	if (got == expected)
		printf("[OK]   %s\n", name);
	else
	{
		printf("[FAIL] %s: got %ld expected %ld\n", name, got, expected);
		g_failures++;
	}
}

static void	check_str(const char *name, const char *got, const char *expected)
{
	if (strcmp(got, expected) == 0)
		printf("[OK]   %s\n", name);
	else
	{
		printf("[FAIL] %s: got \"%s\" expected \"%s\"\n", name, got, expected);
		g_failures++;
	}
}

static void	check_ptr(const char *name, const void *got, const void *expected)
{
	if (got == expected)
		printf("[OK]   %s\n", name);
	else
	{
		printf("[FAIL] %s: got %p expected %p\n", name, got, expected);
		g_failures++;
	}
}

static void	check_sign(const char *name, int got, int expected)
{
	int	got_sign;

	got_sign = 0;
	if (got > 0)
		got_sign = 1;
	else if (got < 0)
		got_sign = -1;
	if (got_sign == expected)
		printf("[OK]   %s\n", name);
	else
	{
		printf("[FAIL] %s: got sign %d expected %d (raw=%d)\n",
			name, got_sign, expected, got);
		g_failures++;
	}
}

static void	test_strlen(void)
{
	check_int("ft_strlen(\"123\")", ft_strlen("123"), 3);
	check_int("ft_strlen(\"\")", ft_strlen(""), 0);
}

static void	test_strdup(void)
{
	char	*s;

	s = ft_strdup("coucou");
	if (s == NULL)
	{
		printf("[FAIL] ft_strdup(\"coucou\"): returned NULL\n");
		g_failures++;
		return ;
	}
	check_str("ft_strdup(\"coucou\") content", s, "coucou");
	check_int("ft_strdup(\"coucou\") len", strlen(s), strlen("coucou"));
	free(s);
	s = ft_strdup("");
	if (s == NULL)
	{
		printf("[FAIL] ft_strdup(\"\"): returned NULL\n");
		g_failures++;
		return ;
	}
	check_str("ft_strdup(\"\") content", s, "");
	check_int("ft_strdup(\"\") len", strlen(s), 0);
	free(s);
}

static void	test_strcpy(void)
{
	char	dest[15];

	memset(dest, 'f', sizeof(dest));
	check_ptr("ft_strcpy return lorem", ft_strcpy(dest, "lorem"), dest);
	check_str("ft_strcpy lorem", dest, "lorem");
	check_int("ft_strcpy lorem keeps tail", dest[6], 'f');
	memset(dest, 'f', sizeof(dest));
	check_ptr("ft_strcpy return lorem ipsum", ft_strcpy(dest, "lorem ipsum"),
		dest);
	check_str("ft_strcpy lorem ipsum", dest, "lorem ipsum");
	check_int("ft_strcpy lorem ipsum keeps tail", dest[12], 'f');
	memset(dest, 'f', sizeof(dest));
	check_ptr("ft_strcpy return empty", ft_strcpy(dest, ""), dest);
	check_str("ft_strcpy empty", dest, "");
	check_int("ft_strcpy empty keeps tail", dest[1], 'f');
}

static void	test_strcmp(void)
{
	check_sign("ft_strcmp salut/salut", ft_strcmp("salut", "salut"), 0);
	check_sign("ft_strcmp test/testss", ft_strcmp("test", "testss"), -1);
	check_sign("ft_strcmp testss/test", ft_strcmp("testss", "test"), 1);
	check_sign("ft_strcmp test/tEst", ft_strcmp("test", "tEst"), 1);
	check_sign("ft_strcmp empty/test", ft_strcmp("", "test"), -1);
	check_sign("ft_strcmp test/empty", ft_strcmp("test", ""), 1);
	check_sign("ft_strcmp unsigned char", ft_strcmp("test\200", "test\0"), 1);
}

static void	test_write(void)
{
	int		pipefd[2];
	char	buf[32];
	ssize_t	ret;

	if (pipe(pipefd) != 0)
	{
		perror("pipe");
		g_failures++;
		return ;
	}
	ret = ft_write(pipefd[1], "hello", 5);
	check_int("ft_write return count", ret, 5);
	close(pipefd[1]);
	memset(buf, 0, sizeof(buf));
	ret = read(pipefd[0], buf, sizeof(buf));
	check_int("ft_write pipe readback size", ret, 5);
	check_str("ft_write pipe readback content", buf, "hello");
	close(pipefd[0]);
	errno = 0;
	ret = ft_write(-1, "x", 1);
	check_int("ft_write invalid fd return", ret, -1);
	check_int("ft_write invalid fd errno", errno, EBADF);
}

static void	test_read(void)
{
	int		pipefd[2];
	char	buf[32];
	ssize_t	ret;

	if (pipe(pipefd) != 0)
	{
		perror("pipe");
		g_failures++;
		return ;
	}
	ret = write(pipefd[1], "world", 5);
	check_int("setup write for ft_read", ret, 5);
	close(pipefd[1]);
	memset(buf, 0, sizeof(buf));
	ret = ft_read(pipefd[0], buf, 5);
	check_int("ft_read return count", ret, 5);
	check_str("ft_read content", buf, "world");
	close(pipefd[0]);
	errno = 0;
	ret = ft_read(-1, buf, 1);
	check_int("ft_read invalid fd return", ret, -1);
	check_int("ft_read invalid fd errno", errno, EBADF);
}

static void	test_atoi_base(void)
{
	check_int("ft_atoi_base(\"42\")", ft_atoi_base("42", "0123456789"), 42);
	check_int("ft_atoi_base(\"+42\")", ft_atoi_base("+42", "0123456789"), 42);
	check_int("ft_atoi_base(\"-42\")", ft_atoi_base("-42", "0123456789"), -42);
}

int	main(void)
{
	test_strlen();
	test_strdup();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	if (g_failures != 0)
	{
		printf("\n%d test(s) failed\n", g_failures);
		return (1);
	}
	printf("\nAll tests passed\n");
	return (0);
}
