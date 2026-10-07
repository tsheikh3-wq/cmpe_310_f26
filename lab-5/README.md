# Lab 5: Language Code and Assembly

## Assignment Part IA

### Compile
gcc -O0 -S -m32 helloworld.c -o helloworld.s


## Assignment Part IB

### Compile
gcc -O4 -S helloworld.c -o helloworld_optimized.s


## Assignment Part II: C

### Compile
gcc -O0 -S HelloWorld.c -o HelloWorldC.s


## Assignment Part II: C++

### Compile
g++ -O0 -S HelloWorldCpp.cpp -o HelloWorldCpp.s


## Assignment Part III: While Loop

### Compile
gcc -O0 -S -m32 whileloop.c -o whileloop.s


## Assignment Part III: Max Value

### Compile
gcc -m32 -no-pie printmax.c maxvalue.s -o test

### Run
./test