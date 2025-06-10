/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juribeir <juribeir@student.42.rio>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/05 09:33:41 by juribeir          #+#    #+#             */
/*   Updated: 2025/06/10 00:15:31 by juribeir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <signal.h>
#include <unistd.h>
#include "minitalk.h"

void	handle_signal(int sig)
{
	static int	bit;
	static char	c;

	if (sig == SIGUSR2)
		c |= (1 << (7 - bit));
	bit++;
	if (bit == 8)
	{
		if (c == '\0')
			write(1, "\n", 1);
		write(1, &c, 1);
		bit = 0;
		c = 0;
	}
}

int	main(void)
{
	struct sigaction	sa;
	char				*pid_str;

	pid_str = ft_itoa(getpid());
	sa.sa_handler = handle_signal;
	sa.sa_flags = SA_RESTART;
	sigemptyset(&sa.sa_mask);
	write(1, "Server PID: ", 12);
	write(1, pid_str, ft_strlen(pid_str));
	write(1, "\n", 1);
	free(pid_str);
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
	return (0);
}
