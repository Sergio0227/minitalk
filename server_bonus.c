/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sandre-a <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/07 13:00:48 by sandre-a          #+#    #+#             */
/*   Updated: 2024/06/11 13:30:36 by sandre-a         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

// PID stands for PROCESS IDENTIFIER
//  assigned when a process starts and are released once the process ends

int	fetch_pid(unsigned char c)
{
	int			pid;
	static int	i = 0;
	static char	pid_str[20];

	pid = 0;
	pid_str[i] = c;
	i++;
	if (c == '\a')
	{
		pid = ft_atoi(pid_str);
		kill(pid, SIGUSR2);
		pid = 0;
		i = 0;
		return (0);
	}
	return (1);
}

void	bit_to_char(int signal)
{
	static int				flag = 0;
	static unsigned char	c = 0;
	static int				bit = 0;
	static int				multiplier = 128;

	if (signal == SIGUSR1)
		c += 1 * multiplier;
	bit++;
	multiplier /= 2;
	if (bit == 8)
	{
		if (!flag)
			ft_printf(BOLD_WHITE "%c", c);
		else
			flag = fetch_pid(c);
		if (c == '\n')
		{
			ft_printf(S_TAB DEF_COLOR "-");
			flag = 1;
		}
		bit = 0;
		multiplier = 128;
		c = 0;
	}
}

int	main(void)
{
	ft_printf(BOLD_BLUE "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n██  SERVER STARTED  ██");
	ft_printf("\n▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n" DEF_COLOR);
	ft_printf("PID: " BOLD_YELLOW "%d\n" DEF_COLOR, getpid());
	ft_printf("Waiting for a message...\n" S_TAB "-");
	while (1)
	{
		signal(SIGUSR1, bit_to_char);
		signal(SIGUSR2, bit_to_char);
		pause();
	}
	return (0);
}
