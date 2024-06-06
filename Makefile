SRC = main.c

NAME = minitalk

OBJS = ${SRC:.c=.o}

CC = cc

CFLAGS = -Werror -Wextra -Wall

LIBFT_PATH = ./libft

RM = rm -f


all:	${NAME}

libft:		
	${MAKE} -C ${LIBFT_PATH}

.c.o:		
	${CC} ${CFLAGS} -g -c $< -o ${<:.c=.o}

minitalk:	${OBJS} libft	
	${CC} ${CFLAGS} ${OBJS} -o ${NAME} -L${LIBFT_PATH} -lft

clean:		
	${MAKE} -C ${LIBFT_PATH} clean
	${RM} ${OBJS}

fclean:	clean
	${MAKE} -C ${LIBFT_PATH} fclean
	${RM} ${NAME}

re:			fclean all

.PHONY:		all clean fclean re libft
