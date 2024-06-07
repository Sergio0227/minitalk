/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sandre-a <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/07 13:00:48 by sandre-a          #+#    #+#             */
/*   Updated: 2024/06/07 13:38:50 by sandre-a         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

// PID stands for PROCESS IDENTIFIER
//  assigned when a process starts and are released once the process ends

int	main(void)
{
	ft_printf(BOLD_BLUE"▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n██  SERVER STARTED  ██");
	ft_printf("\n▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n"DEF_COLOR);
	ft_printf(S_TAB"PID: " BOLD_YELLOW "%d\n" DEF_COLOR, getpid());
	return (0);
}
