// SAMPLE DATA - SHOP / WAREHOUSE

sales:([]
    time:  09:05 09:30 10:15 10:45 11:20 12:00 13:10 14:30 15:00 16:45 17:10 18:00 19:30 20:00 20:45;
    store: `faridabad`faridabad`delhi`delhi`faridabad`faridabad`delhi`gurgaon`gurgaon`faridabad`delhi`gurgaon`delhi`faridabad`gurgaon;
    product: `shoes`shirt`shoes`cap`shirt`shoes`shirt`cap`shoes`shirt`shoes`cap`shoes`shirt`cap;
    customer: `aman`ajay`pankaj`priyanka`shalini`aman`ajay`pankaj`priyanka`shalini`aman`ajay`pankaj`priyanka`shalini;
    quantity: 2 1 3 2 1 4 2 1 3 2 5 1 2 3 1;
    price: 2500 800 2500 400 800 2500 800 400 2500 800 2500 400 2500 800 400
 )

inventory:([]
    time:  08:00 08:00 08:00 08:00 08:00 08:00 12:00 12:00 12:00 12:00 12:00 12:00 16:00 16:00 16:00 16:00 16:00 16:00;
    store: `faridabad`faridabad`faridabad`delhi`delhi`delhi`faridabad`faridabad`faridabad`delhi`delhi`delhi`gurgaon`gurgaon`gurgaon`faridabad`faridabad`faridabad;
    product: `shoes`shirt`cap`shoes`shirt`cap`shoes`shirt`cap`shoes`shirt`cap`shoes`shirt`cap`shoes`shirt`cap;
    stock: 50 40 30 60 35 25 40 30 20 45 25 18 55 38 22 35 28 15
 )


// LEVEL 1 - BASIC SUMMARY

show "===== Total Sales Count Per Store ====="
show `store xkey select count i by store from sales

show "===== Total Quantity Sold Per Product ====="
show `product xkey select totalQty:sum quantity by product from sales

show "===== Product With Highest Total Quantity Sold ====="
show 1# `totalQty xdesc `product xkey select totalQty:sum quantity by product from sales


// LEVEL 2 - WORKING WITH TIME

show "===== Sales Count Per Store Per Hour ====="
show `store`hour xkey select count i by store, hour:{`$string[x],"-",string[x+1]}each `hh$time from sales

show "===== Average Price Per Product - Morning (09:00-13:00) ====="
show `product xkey select avgPrice:avg price by product
    from sales where time within 09:00 13:00

show "===== Average Price Per Product - Evening (17:00-21:00) ====="
show `product xkey select avgPrice:avg price by product
    from sales where time within 17:00 21:00

show "===== Hour With Highest Total Quantity Sold ====="
show 1# `totalQty xdesc `hour xkey select totalQty:sum quantity by hour:{`$string[x],"-",string[x+1]}each `hh$time from sales


// LEVEL 3 - COMBINING DATA BY TIME

show "===== Sales With Most Recent Inventory (As-of Join) ====="
joined: aj[`store`product`time; sales; inventory]
show joined

show "===== Sales With Remaining Stock ====="
joined: update remainingStock: stock - quantity from joined
show joined

show "===== Average and Minimum Remaining Stock Per Product ====="
show `product xkey select
    avgRemainingStock: avg remainingStock,
    minRemainingStock: min remainingStock
    by product from joined