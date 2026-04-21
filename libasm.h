/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pharbst <pharbst@student.42heilbronn.de>   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/29 10:16:40 by pharbst           #+#    #+#             */
/*   Updated: 2026/04/21 21:09:21 by pharbst          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
// # include <stdlib.h>
// #include <sys/_types/_ssize_t.h>

size_t	ft_strlen(const char* str);
int		ft_strcmp(const char* str1, const char *str2);
char*	ft_strcpy(char* __restrict dest, const char *__restrict src);
size_t	ft_write(int fd, const void* buff, size_t count);
size_t	ft_read(int fd, void* buff, size_t count);
char*	ft_strdup(char* str);

#endif