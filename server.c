/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sandre-a <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/07 13:00:48 by sandre-a          #+#    #+#             */
/*   Updated: 2024/06/11 13:18:57 by sandre-a         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

// PID stands for PROCESS IDENTIFIER
//  assigned when a process starts and are released once the process ends

void	bit_to_char(int signal)
{
	static unsigned char	c = 0;
	static int				bit = 0;
	static int				multiplier = 128;

	if (signal == SIGUSR1)
		c += 1 * multiplier;
	bit++;
	multiplier /= 2;
	if (bit == 8)
	{
		ft_printf(BOLD_WHITE "%c", c);
		if (c == '\n')
			ft_printf(S_TAB DEF_COLOR "-");
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
