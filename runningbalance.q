/ transaction list
transactions: 100 -20 -30 -150 100 1000

/ Running balances
balance:sums transactions

/ Create table
result:([] Transaction:transactions; Balance:balance)

/ Display
show result