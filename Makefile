# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pharbst <pharbst@student.42heilbronn.de>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 18:12:18 by pharbst           #+#    #+#              #
#    Updated: 2026/04/23 23:36:27 by pharbst          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include color.mk

# **************************************************************************** #
# Variables
# **************************************************************************** #

NAME	:=	libasm.a
BNAME	:=	libasm.a

CC		:=	nasm
CFLAGS	:=	-g -f elf64

LIBFT	:=	
HEADER	:=	./libasm.h

SRCS	:=	ft_strlen.s\
			ft_strcpy.s\
			ft_strcmp.s\
			ft_write.s\
			ft_read.s\
			ft_strdup.s\
			ft_strchr.s\
			ft_is_whitespace.s\
			ft_atoi_base.s

ODIR	:=	./obj
OBJS	:=	$(SRCS:%.s=$(ODIR)/%.o)

# **************************************************************************** #
# Compilation Rules
# **************************************************************************** #

# help:
# 	@printf "Available Rules:\n\
# 	  all\n\
# 	  clean\n\
# 	  fclean\n\
# 	  re\n\
# 	  test\n"

all:
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_all

test:
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_all
	@gcc -Wall -Werror -Wextra main.c libasm.a -o libasm_test
	@./libasm_test

std_all:
	@printf "%-88s$(RESET)" "Assemble library ..."
	$(MAKE) -s $(NAME)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

$(NAME): $(OBJS)
	@ar rcs $(NAME) $(OBJS)

$(ODIR)/%.o: %.s | $(ODIR)
	@$(CC) $(CFLAGS) $< -o $@

$(ODIR):
	@mkdir -p $@

# **************************************************************************** #
# Cleaning Rules
# **************************************************************************** #

clean:
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_clean

fclean:
	@$(MAKE) -s proname_header
	@$(MAKE) -s cleanator

re:
	@$(MAKE) -s proname_header
	@$(MAKE) -s cleanator
	@$(MAKE) -s std_all

std_clean:
	@printf "%-95s$(RESET)" "$(FPurple)Cleaning up ..."
	@$(RM) -rf $(ODIR)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

cleanator:
	@printf "%-95s$(RESET)" "$(FPurple)FCleaning up ..."
	@$(RM) -rf $(ODIR)
	@$(RM) -rf $(NAME)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

# **************************************************************************** #
# Header Rules                                                                 #
# **************************************************************************** #

proname_header:
	@printf "$(Red)╔═════════════════════════════════════════════════════════════════════════════════════════╗$(RESET)\n\
$(Red)║$(Green)                                                                                         $(Red)║\n\
$(Red)║$(Green)          :::        ::::::::::: :::::::::              :::      ::::::::    :::   :::   $(Red)║\n\
$(Red)║$(Green)         :+:            :+:     :+:    :+:           :+: :+:   :+:    :+:  :+:+: :+:+:   $(Red)║\n\
$(Red)║$(Green)        +:+            +:+     +:+    +:+          +:+   +:+  +:+        +:+ +:+:+ +:+   $(Red)║\n\
$(Red)║$(Green)       +#+            +#+     +#++:++#+          +#++:++#++: +#++:++#++ +#+  +:+  +#+    $(Red)║\n\
$(Red)║$(Green)      +#+            +#+     +#+    +#+         +#+     +#+        +#+ +#+       +#+     $(Red)║\n\
$(Red)║$(Green)     #+#            #+#     #+#    #+#         #+#     #+# #+#    #+# #+#       #+#      $(Red)║\n\
$(Red)║$(Green)    ########## ########### #########          ###     ###  ########  ###       ###       $(Red)║\n\
$(Red)║$(Green)                                                                                         $(Red)║\n\
$(Red)╚═════════════════════════════════════════════════════════════════════════════════════════╝\n$(RESET)"


