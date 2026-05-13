pascal:{[n]
    row:1 1;
    triangle:(enlist 1),enlist row;
    do[n-2;
        row:(0,row)+row,0;
        triangle,:enlist row;
    ];
    triangle
 }

{show x}each pascal 4;