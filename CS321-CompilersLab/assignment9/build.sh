#!/bin/bash

echo "Compiling the lexical analyzer and parser..."
bison -d -y parser.y
flex lexA.l
g++ -o compiler y.tab.c -lfl

echo "Running the compiler on test inputs..."

echo "1. GCD Program:"
./compiler gcd.txt gcd_output.txt
echo "Output written to gcd_output.txt"

echo "2. Interest Calculation Program:"
./compiler interest.txt interest_output.txt
echo "Output written to interest_output.txt"

echo "3. Triangle Area Calculation Program:"
./compiler triangle.txt triangle_output.txt
echo "Output written to triangle_output.txt"

echo "All tests complete. Check the output files for results."