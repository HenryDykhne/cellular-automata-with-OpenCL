# cellular-automata-with-OpenCL
## Compile 
with `make`

## Run 
with `oclgrind ./a5 <-n #> <-s #> <-i #>`
ex: `oclgrind ./a5 -n 4 -s 32 -i 4`

## The command line arguments are:

* -n # -the number represents the number of kernels
* -s # -the number represents both the height and width of the array
* -i # -the number indicates which initial configuration will be used in the first row of the array

The default number of kernels is 1. The default size of the array is 20. The initial configuration is 0 (random).

The initial configuration patterns and associated command line numbers for the array are:

# Command
```
Line       | Initial  | Pattern
Parameter  | Pattern  | Name
-------------------------------
0          | random   |  Random
1          | "X XX"   |  FlipFlop
2          | "XXXXXX" |  Spider
3          | "X XXX"  |  Glider
4          | "XXXXXXX"|  Face
```
