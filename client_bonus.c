/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sandre-a <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/05 13:30:33 by sandre-a          #+#    #+#             */
/*   Updated: 2024/06/10 13:21:00 by sandre-a         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

static void	send_signal(int pid, char bit)
{
	if (bit == '1')
		kill(pid, SIGUSR1);
	else if (bit == '0')
		kill(pid, SIGUSR2);
	usleep(100);
}

static char	*char_to_bit(unsigned char c)
{
	int		i;
	char	*byte;

	byte = ft_calloc(9, sizeof(char));
	i = 7;
	while (i >= 0)
	{
		if (c & (1 << i))
			byte[7 - i] = '1';
		else
			byte[7 - i] = '0';
		i--;
	}
	byte[8] = 0;
	return (byte);
}

static char	**store_msg_bits(char *str)
{
	int		i;
	char	**message;

	i = -1;
	message = malloc(sizeof(char *) * (ft_strlen(str) + 2));
	if (!message)
		return (NULL);
	while (++i < (int)ft_strlen(str))
		message[i] = char_to_bit(str[i]);
	message[i] = char_to_bit('\n');
	message[i + 1] = 0;
	return (message);
}

static void	send_client_pid(int server_pid)
{
	static int	i = -1;
	int			x;
	char		*pid;
	char		**pid_bits;

	if (i == -1)
	{
		pid = ft_itoa(getpid());
		pid_bits = malloc(sizeof(char *) * (ft_strlen(pid) + 2));
		while (pid[++i])
			pid_bits[i] = char_to_bit(pid[i]);
		pid_bits[i] = char_to_bit('\a');
		pid_bits[i + 1] = 0;
		i = -1;
		while (pid_bits[++i])
		{
			x = 0;
			while (pid_bits[i][x])
				send_signal(server_pid, pid_bits[i][x++]);
		}
	}
	else 
		ft_printf("Message received\n");
}

int	main(int argc, char **argv)
{
	int		i;
	int		x;
	char	**message;

	if (argc == 1)
		ft_printf(BOLD_YELLOW "Please provide the PID to the program\n");
	else if (argc == 2)
		ft_printf(BOLD_YELLOW "Please, provide the message as an argument\n");
	else
	{
		i = -1;
		message = store_msg_bits(argv[2]);
		signal(SIGUSR2, send_client_pid);
		while (message[++i])
		{
			x = 0;
			while (message[i][x])
				send_signal(ft_atoi(argv[1]), message[i][x++]);
			free(message[i]);
		}
		send_client_pid(ft_atoi(argv[1]));
		free(message);
	}
	return (0);
}
