/ input list
list: 10 20 30 40 50

/ window size
w:3

/ compute moving average
show `long$(w-1)_(w mavg list)