/*
This model is used to solve classic sudoku puzzles.
in the input_grid, use 0 to represent those unknown values.
*/
set of int: size = 1..9;
array[size, size] of 0..9: input_grid;
array[size, size] of var 1..9: grid;

constraint forall(i in size, j in size)(input_grid[i, j] > 0 <-> 
                                        input_grid[i,j] = grid[i,j]);
include "alldifferent.mzn";
constraint forall(i in size)(
           alldifferent([grid[i, j] | j in size])
           ); 
constraint forall(j in size)(
           alldifferent([grid[i, j] | i in size])
           ); 

constraint alldifferent([grid[i,j] | i in 1..3, j in 1..3]);
constraint alldifferent([grid[i,j] | i in 1..3, j in 4..6]);
constraint alldifferent([grid[i,j] | i in 1..3, j in 7..9]);
constraint alldifferent([grid[i,j] | i in 4..6, j in 1..3]);
constraint alldifferent([grid[i,j] | i in 4..6, j in 4..6]);
constraint alldifferent([grid[i,j] | i in 4..6, j in 7..9]);
constraint alldifferent([grid[i,j] | i in 7..9, j in 1..3]);
constraint alldifferent([grid[i,j] | i in 7..9, j in 4..6]);
constraint alldifferent([grid[i,j] | i in 7..9, j in 7..9]);

solve satisfy;

output [show(grid[i,j]) ++ if j=9 then if i mod 3 = 0 
                                       then "\n\n"
                                       else "\n" endif
                           else if j=3 \/ j=6 
                                then "| " 
                                else", " 
                                endif 
                           endif 
                          |i in size, j in size]
