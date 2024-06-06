.SILENT:

CLIENT = client

SERVER = server

NAME = minitalk

CC = cc

CFLAGS = -Werror -Wextra -Wall

LIBFT_PATH = ./libft

RM = rm -f

GREEN=\033[0;32m

DEFAULTCOLOR=\033[0m

all: libft	${NAME}

libft:
	if [ ! -d "$(LIBFT_PATH)" ]; then \
		echo "downloading libft..."; \
		git clone git@github.com:Sergio0227/Libft.git $(LIBFT_PATH) > /dev/null 2>&1; \
	fi
	${MAKE} -C ${LIBFT_PATH} > /dev/null 2>&1
	echo "LIBFT MADE";

.c.o:		
	${CC} ${CFLAGS} -g -c $< -o ${<:.c=.o}

minitalk: 	
	${CC} ${CFLAGS} ${CLIENT}.c -o ${CLIENT} -L${LIBFT_PATH} -lft
	if [ "$(CLIENT)" ]; then \
    	echo "$(GREEN)CLIENT is ready$(DEFAULTCOLOR)"; \
	fi
	${CC} ${CFLAGS} ${SERVER}.c -o ${SERVER} -L${LIBFT_PATH} -lft
	if [ "$(SERVER)" ]; then \
    	echo "$(GREEN)SERVER is ready$(DEFAULTCOLOR)"; \
	fi

run: 	all
		echo "\n";
		./server;

clean:		
	${MAKE} -C ${LIBFT_PATH} clean > /dev/null 2>&1

fclean:	clean
	${MAKE} -C ${LIBFT_PATH} fclean > /dev/null 2>&1
	${RM} ${CLIENT}
	${RM} ${SERVER}
	${RM} -rf ${LIBFT_PATH}

re:			fclean all

.PHONY:		all clean fclean re libft
