/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pharbst <pharbst@student.42heilbronn.de>   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/29 10:16:40 by pharbst           #+#    #+#             */
/*   Updated: 2025/04/29 10:31:55 by pharbst          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
// # include <stdlib.h>
#include <sys/_types/_ssize_t.h>

size_t	strlen(const char* str);
int		strcmp(const char* str1, const char *str2);
char*	strcpy(char* __restrict dest, const char *__restrict src);
ssize_t	write(int fd, const void* buff, size_t count);
ssize_t	read(int fd, void* buff, size_t count);
char*	strdup(char* str);

#endif