/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pharbst <pharbst@student.42.heilbronn.de>  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/29 10:16:40 by pharbst           #+#    #+#             */
/*   Updated: 2025/05/02 16:33:24 by pharbst          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
// # include <stdlib.h>
#include <sys/_types/_ssize_t.h>

size_t	_ft_strlen(const char* str);
int		_ft_strcmp(const char* str1, const char *str2);
char*	_ft_strcpy(char* __restrict dest, const char *__restrict src);
ssize_t	_ft_write(int fd, const void* buff, size_t count);
ssize_t	_ft_read(int fd, void* buff, size_t count);
char*	_ft_strdup(char* str);

#endif