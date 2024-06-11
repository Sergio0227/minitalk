.SILENT:

# Define variables
CLIENT = client
SERVER = server
NAME = minitalk
CC = cc
CFLAGS = -Werror -Wextra -Wall
LIBFT_PATH = ./libft
BONUS = _bonus
RM = rm -f

# Define colors
DEF_COLOR = \033[0;39m
ORANGE = \033[0;33m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[1;92m
YELLOW = \033[1;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m

all: libft ${NAME}

libft:
	if [ ! -d "$(LIBFT_PATH)" ]; then \
		echo "downloading libft..."; \
		git clone git@github.com:Sergio0227/Libft.git $(LIBFT_PATH) > /dev/null 2>&1; \
	fi
	${MAKE} -C ${LIBFT_PATH} > /dev/null 2>&1
	echo "LIBFT MADE";

.c.o:
	${CC} ${CFLAGS} -g -c $< -o ${<:.c=.o}

${NAME}:
	${CC} ${CFLAGS} ${CLIENT}.c -o ${CLIENT} -L${LIBFT_PATH} -lft
	if [ "$(CLIENT)" ]; then \
		echo "$(ORANGE)[CLIENT]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)"; \
	fi
	${CC} ${CFLAGS} ${SERVER}.c -o ${SERVER} -L${LIBFT_PATH} -lft
	if [ "$(SERVER)" ]; then \
		echo "$(CYAN)[SERVER]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)"; \
	fi

bonus: libft
	${CC} ${CFLAGS} ${CLIENT}${BONUS}.c -o ${CLIENT}${BONUS} -L${LIBFT_PATH} -lft
	if [ "$(CLIENT)$(BONUS)" ]; then \
		echo "$(ORANGE)[CLIENT_BONUS]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)"; \
	fi
	${CC} ${CFLAGS} ${SERVER}${BONUS}.c -o ${SERVER}${BONUS} -L${LIBFT_PATH} -lft
	if [ "$(SERVER)$(BONUS)" ]; then \
		echo "$(CYAN)[SERVER_BONUS]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)"; \
	fi

run: all
	echo "\n";
	./server;

clean:
	${MAKE} -C ${LIBFT_PATH} clean > /dev/null 2>&1
	echo -n "$(CYAN)[LIBFT]:$(DEF_COLOR) object files$(RED) \t => Removed!$(DEF_COLOR)\n"

fclean:
	if [ -f "${CLIENT}${BONUS}" ]; then \
		echo -n "$(CYAN)[minitalk_bonus]:$(DEF_COLOR) exec. files$(RED)  => Removed!$(DEF_COLOR)\n"; \
		${RM} ${CLIENT}${BONUS}; \
		${RM} ${SERVER}${BONUS}; \
	fi
	if [ -f "${CLIENT}" ]; then \
		echo -n "$(CYAN)[minitalk]:$(DEF_COLOR) exec. files$(RED)  => Removed!$(DEF_COLOR)\n"; \
		${RM} ${CLIENT}; \
		${RM} ${SERVER}; \
	fi
	${RM} -rf ${LIBFT_PATH}
	echo -n "$(CYAN)[LIBFT]:$(DEF_COLOR)    folder$(RED)    \t => Removed!$(DEF_COLOR)\n"

re: fclean all

.PHONY: all clean fclean re libft
