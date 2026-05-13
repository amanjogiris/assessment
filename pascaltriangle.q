/ Function to generate Pascal's Triangle with n rows
pascal:{[n]

    / Initialize second row of triangle: (1 1)
    row:1 1;

    
    / Initialize triangle with first two rows:
    / first row -> (1)
    / second row -> (1 1)

    triangle:(enlist 1),enlist row;

    / Loop to generate remaining rows (starting from 3rd row)
    do[n-2;
    
        / Generate next row:
        / - prepend 0 on left and append 0 on right
        / - add shifted lists element-wise
        row:(0,row)+row,0;

        / Append newly generated row to triangle
        triangle,:enlist row;
    ];

    / Return full triangle
    triangle
 }

/ Print each row of Pascal's Triangle
{show x}each pascal 4;