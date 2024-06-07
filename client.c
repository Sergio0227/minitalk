/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sandre-a <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/05 13:30:33 by sandre-a          #+#    #+#             */
/*   Updated: 2024/06/07 21:09:33 by sandre-a         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

static void	send_signal(int pid, char bit)
{
	if (bit == '1')
		kill(pid, SIGUSR2);
	else
		kill(pid, SIGUSR1);
	usleep(1000);
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
	message = malloc(sizeof(char *) * (ft_strlen(str) + 1));
	if (!message)
		return (NULL);
	while (++i < (int)ft_strlen(str))
		message[i] = char_to_bit(str[i]);
	message[i] = 0;
	return (message);
}

int	main(int argc, char **argv)
{
	int		i;
	int		x;
	char	**message;

	(void)argv;
	if (argc == 1)
		ft_printf(BOLD_YELLOW "Please provide the PID to the program\n");
	else if (argc == 2)
		ft_printf(BOLD_YELLOW "Please, provide the message as an argument\n");
	else
	{
		i = -1;
		message = store_msg_bits(argv[2]);
		while (message[++i])
		{
			x = 0;
			while (message[i][x])
				send_signal(atoi(argv[1]), message[i][x++]);
		}
	}
	ft_printf("%s\n", message[0]);
	return (0);
}
