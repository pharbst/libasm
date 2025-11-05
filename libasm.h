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
# include <sys/types.h>

size_t  _ft_strlen(const char *str);
int     _ft_strcmp(const char *s1, const char *s2);
char    *_ft_strcpy(char *dest, const char *src);
ssize_t _ft_write(int fd, const void *buff, size_t count);
ssize_t _ft_read(int fd, void *buff, size_t count);
char    *_ft_strdup(const char *str);

#endif /* LIBASM_H */
