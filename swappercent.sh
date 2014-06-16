echo -e "Memory Usage $(free -m) \nSwap Usage as Percent = $(free -m | awk 'NR == 4 {printf ("%3.1f\n", ($3 / $2) * 100)}')%"
