# assemblyCalc
A simplistic calculator programmed on the raspberry PI in arvmv8 assembly.

# How to build

Use gcc to build the program with the command

```gcc -g -o0 prog5.s parser.s getFirstNum.s getSecondNum.s getOp.s getDecVal.s -o prog5```

# How to run and use

You can run the program like any other C file

```./prog5```

For the program to run correctly, you must enter your input in this format:

```firstNum op secondNum```

Where op can be one of four operations:

```+: Additon
   -: Subtraction
   *: Multiplication
   /: Divison
   ```
