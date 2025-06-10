# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: juribeir <juribeir@student.42.rio>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/09 20:59:22 by juribeir          #+#    #+#              #
#    Updated: 2025/06/09 21:52:33 by juribeir         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = minitalk

CC = gcc
CFLAGS = -Wall -Wextra -Werror

NAME_SERVER = server
NAME_CLIENT = client
SRC_SERVER = src/server.c
SRC_CLIENT = src/client.c
LIBFT_DIR = libft
LIBFT = $(LIBFT_DIR)/libft.a

OBJ_SERVER = $(SRC_SERVER:.c=.o)
OBJ_CLIENT = $(SRC_CLIENT:.c=.o)

all: $(LIBFT) $(NAME_SERVER) $(NAME_CLIENT)

$(LIBFT):
	@make -C $(LIBFT_DIR)

$(NAME_SERVER): $(SRC_SERVER)
	$(CC) $(CFLAGS) -o $(NAME_SERVER) $(SRC_SERVER) $(LIBFT)
	$(CC) $(CFLAGS) -o $(NAME_CLIENT) $(SRC_CLIENT) $(LIBFT)

clean:
	rm -f $(OBJ_SERVER)	$(OBJ_CLIENT)
	@make -C $(LIBFT_DIR) clean

fclean: clean
	rm -f $(NAME_SERVER) $(NAME_CLIENT)
	@make -C $(LIBFT_DIR) fclean

re: fclean all

.PHONY: fclean all clean re