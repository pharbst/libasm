# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pharbst <pharbst@student.42.heilbronn.de>  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 18:12:18 by pharbst           #+#    #+#              #
#    Updated: 2025/05/02 16:44:29 by pharbst          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include color.mk

SHELL           :=      /bin/bash

# **************************************************************************** #
# Variables
# **************************************************************************** #

NAME            :=      libasm.a
BNAME           :=      libasm.a

NASM            :=      nasm
NASMFLAGS       :=      -f elf64

CC              :=      cc
CFLAGS          :=      -Wall -Wextra -Werror
CPPFLAGS        :=      -I. -I./tests
LDFLAGS         :=      -no-pie

LIBFT           :=
HEADER          :=      ./libasm.h

SRCS            :=      ft_strlen.s\
	                ft_strcpy.s\
	                ft_strcmp.s\
	                ft_write.s\
	                ft_read.s\
	                ft_strdup.s

ODIR            :=      ./obj
OBJS            :=      $(SRCS:%.s=$(ODIR)/%.o)

TEST_DIR        :=      ./tests
TEST_OBJDIR     :=      $(TEST_DIR)/obj
TEST_SRCS       :=      $(TEST_DIR)/test_framework.c\
	                $(TEST_DIR)/test_strlen.c\
	                $(TEST_DIR)/test_strcpy.c\
	                $(TEST_DIR)/test_strcmp.c\
	                $(TEST_DIR)/test_strdup.c\
	                $(TEST_DIR)/test_write.c\
	                $(TEST_DIR)/test_read.c\
	                $(TEST_DIR)/errno_shim.c\
	                $(TEST_DIR)/test_runner.c
TEST_OBJS       :=      $(TEST_SRCS:$(TEST_DIR)/%.c=$(TEST_OBJDIR)/%.o)
TEST_BIN        :=      $(TEST_DIR)/libasm_tester

.PHONY: all std_all clean fclean re std_clean cleanator proname_header test

# **************************************************************************** #
# Compilation Rules
# **************************************************************************** #

all:
	@$(MAKE) proname_header
	@$(MAKE) std_all

std_all:
	@printf "%-88s$(RESET)" "Assemble library ..."
	@$(MAKE) $(NAME)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

$(NAME): $(OBJS)
	ar rcs $(NAME) $(OBJS)

$(ODIR)/%.o: %.s | $(ODIR)
	$(NASM) $(NASMFLAGS) $< -o $@

$(TEST_OBJDIR)/%.o: $(TEST_DIR)/%.c | $(TEST_OBJDIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(TEST_OBJDIR):
	mkdir -p $@

$(TEST_BIN): $(TEST_OBJS) $(NAME)
	$(CC) $(CFLAGS) $(LDFLAGS) $(TEST_OBJS) $(NAME) -o $@

test: re $(TEST_BIN)
	./$(TEST_BIN)

$(ODIR):
	mkdir -p $@

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
	@$(MAKE) proname_header
	@$(MAKE) cleanator
	@$(MAKE) std_all

std_clean:
	@printf "%-95s$(RESET)" "$(FPurple)Cleaning up ..."
	@$(RM) -rf $(ODIR)
	@$(RM) -rf $(TEST_OBJDIR)
	@$(RM) -f $(TEST_BIN)
	@printf "$(FGreen)$(TICKBOX)\n$(RESET)"

cleanator:
	@printf "%-95s$(RESET)" "$(FPurple)FCleaning up ..."
	@$(RM) -rf $(ODIR)
	@$(RM) -rf $(NAME)
	@$(RM) -rf $(TEST_OBJDIR)
	@$(RM) -f $(TEST_BIN)
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
