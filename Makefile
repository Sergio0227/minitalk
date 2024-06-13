# Define variables
CLIENT = client
SERVER = server
NAME = minitalk
CC = cc
CFLAGS = -Werror -Wextra -Wall
LIBFT_PATH = ./libft
LIBFT_LIB = ${LIBFT_PATH}/libft.a
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

# Define object files
CLIENT_OBJS = ${CLIENT}.o
SERVER_OBJS = ${SERVER}.o
CLIENT_BONUS_OBJS = ${CLIENT}${BONUS}.o
SERVER_BONUS_OBJS = ${SERVER}${BONUS}.o

all: libft ${NAME}

${NAME}: ${CLIENT} ${SERVER}

libft: ${LIBFT_LIB}

${LIBFT_LIB}:
	@if [ ! -d "$(LIBFT_PATH)" ]; then \
		echo "downloading libft..."; \
		git clone git@github.com:Sergio0227/Libft.git $(LIBFT_PATH) > /dev/null 2>&1; \
	fi
	@${MAKE} -C ${LIBFT_PATH} > /dev/null 2>&1
	@echo "LIBFT MADE";

.c.o:
	@${CC} ${CFLAGS} -g -c $< -o $@

${CLIENT}: ${CLIENT_OBJS} ${LIBFT_LIB}
	@${CC} ${CFLAGS} ${CLIENT_OBJS} -o ${CLIENT} -L${LIBFT_PATH} -lft
	@echo "$(ORANGE)[CLIENT]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)";

${SERVER}: ${SERVER_OBJS} ${LIBFT_LIB}
	@${CC} ${CFLAGS} ${SERVER_OBJS} -o ${SERVER} -L${LIBFT_PATH} -lft
	@echo "$(CYAN)[SERVER]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)";

bonus: libft ${CLIENT}${BONUS} ${SERVER}${BONUS}

${CLIENT}${BONUS}: ${CLIENT_BONUS_OBJS} ${LIBFT_LIB}
	@${CC} ${CFLAGS} ${CLIENT_BONUS_OBJS} -o ${CLIENT}${BONUS} -L${LIBFT_PATH} -lft
	@echo "$(ORANGE)[CLIENT_BONUS]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)";

${SERVER}${BONUS}: ${SERVER_BONUS_OBJS} ${LIBFT_LIB}
	@${CC} ${CFLAGS} ${SERVER_BONUS_OBJS} -o ${SERVER}${BONUS} -L${LIBFT_PATH} -lft
	@echo "$(CYAN)[SERVER_BONUS]:$(DEF_COLOR) exec file $(GREEN) \t=> Created!$(DEF_COLOR)";

run: all
	@echo "\n";
	@./server;

run_bonus: bonus
	@echo "\n";
	@./server_bonus;

clean:
	@${MAKE} -C ${LIBFT_PATH} clean > /dev/null 2>&1
	@${RM} ${CLIENT_OBJS} ${SERVER_OBJS} ${CLIENT_BONUS_OBJS} ${SERVER_BONUS_OBJS}
	@echo -n "$(CYAN)[LIBFT]:$(DEF_COLOR) object files$(RED) \t => Removed!$(DEF_COLOR)\n"

fclean: clean
	@if [ -f "${CLIENT}${BONUS}" ]; then \
		echo -n "$(CYAN)[minitalk_bonus]:$(DEF_COLOR) exec. files$(RED)  => Removed!$(DEF_COLOR)\n"; \
		${RM} ${CLIENT}${BONUS}; \
		${RM} ${SERVER}${BONUS}; \
	fi
	@if [ -f "${CLIENT}" ]; then \
		echo -n "$(CYAN)[minitalk]:$(DEF_COLOR) exec. files$(RED)  => Removed!$(DEF_COLOR)\n"; \
		${RM} ${CLIENT}; \
		${RM} ${SERVER}; \
	fi
	@${RM} -rf ${LIBFT_PATH}
	@echo -n "$(CYAN)[LIBFT]:$(DEF_COLOR)    folder$(RED)    \t => Removed!$(DEF_COLOR)\n"

re: fclean all

.PHONY: all clean fclean re libft bonus ${NAME}
