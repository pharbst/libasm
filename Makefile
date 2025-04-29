# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pharbst <pharbst@student.42heilbronn.de>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 18:12:18 by pharbst           #+#    #+#              #
#    Updated: 2025/04/29 03:43:39 by pharbst          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include color.mk

# **************************************************************************** #
# Variables
# **************************************************************************** #

NAME	:=	libasm.a
BNAME	:=	libasm.a

CC		:=	nasm
CFLAGS	:=	
# CFLAGS	:=	-Wall -Werror -Wextra -Wunreachable-code -g
# CFLAGS	+=	-fsanitize=address

LIBFT	:=	
HEADER	:=	./includes/libasm.h
# ifeq ($(UNAME), Darwin)
# LIBS	:=	$(LIBFT)/libftio.a
# else
# LIBS	:=	$(LIBFT)/libftio_linux.a
# endif

# INC		:=	-I ./includes -I $(LIBFT)/includes
# VPATH	:=	src src/algorythm src/stackoperations src/t_stack src/checker src/input src/tools

SRCS	:=	

BFILES	=	

ODIR	:=	obj
OBJS	:=	$(SRCS:%.c=$(ODIR)/%.o)

# **************************************************************************** #
# Compilation Rules
# **************************************************************************** #

all:
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_all
	
std_all:
	
# ifneq ($($(LIBFT)/Makefile), "")
# 	@printf "%-67s$(RESET)" "$(Yellow)Updating $(FCyan)submodule ..."
# 	@git submodule update --init >/dev/null 2>&1
# endif
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"
# 	@printf "%-67s$(RESET)" "$(Yellow)Compiling $(FCyan)libft ..."
# 	@./spinner.sh $(MAKE) -j -s -C $(LIBFT) >/dev/null
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"
# 	@printf "%-67s$(RESET)" "$(Yellow)Compiling $(FCyan)$(NAME) ..."	
# 	@./spinner.sh $(MAKE) -s $(NAME)
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"

bonus:
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_bonus

std_bonus:
# ifneq ($($(LIBFT)/Makefile), "")
# 	@printf "%-67s$(RESET)" "$(Yellow)Updating $(FCyan)submodule ..."
# 	@git submodule update --init >/dev/null 2>&1
# endif
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"
# 	@printf "%-67s$(RESET)" "$(Yellow)Compiling $(FCyan)libft ..."
# 	@./spinner.sh $(MAKE) -j -s -C $(LIBFT) >/dev/null
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"
# 	@printf "%-67s$(RESET)" "$(Yellow)Compiling $(FCyan)$(NAME) ..."	
# 	@./spinner.sh $(MAKE) -s $(NAME)
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"
# 	@printf "%-67s$(RESET)" "$(Yellow)Compiling $(FCyan)$(BNAME) ..."	
# 	@./spinner.sh $(MAKE) -s $(BNAME)
# 	@printf "$(FGreen)[$(TICK)]\n$(RESET)"

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) $(LIBS) $(INC) -o $(NAME)

$(BNAME): $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) $(LIBS) $(INC) -o $(BNAME)

$(ODIR)/%.o: %.c $(HEADER) | $(ODIR)
	@$(CC) $(CFLAGS) $(INC) -c $< -o $@

$(ODIR):
	@mkdir -p $@

libft:
	@$(MAKE) -j -s -C $(LIBFT) $(MAKECMDGOALS) >/dev/null

# **************************************************************************** #
# Cleaning Rules
# **************************************************************************** #

clean:	libft
	@$(MAKE) -s proname_header
	@$(MAKE) -s std_clean

std_clean:
	@printf "%-60s$(RESET)" "$(FPurple)Cleaning up ..."
	@$(RM) -rf $(ODIR)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

fclean:	libft
	@$(MAKE) -s proname_header
	@$(MAKE) -s cleanator

cleanator:
	@printf "%-60s$(RESET)" "$(FPurple)FCleaning up ..."
	@$(RM) -rf $(ODIR)
	@$(RM) -rf $(NAME)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

re:
	@$(MAKE) -s proname_header
	@$(MAKE) -s cleanator
	@$(MAKE) -s std_all

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


