    .data

# Array of 10 integers
Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11
Array_length:
    .long 10

max:
    .long 0

    .text
    .globl find_max

find_max:
    pushl %ebp
    movl %esp, %ebp 

    #assuming first number is largest
    movl Numbers, %eax   #eax = numbers[0]
    movl $1, %ecx  ## counter(i) at 1

    jmp .condition

.L1:
    movl Numbers(,%ecx,4), %edx
    cmpl %eax, %edx
    jle .skip  # jump if edx is less than eax(current max)

    movl %edx, %eax  # number becomes max

.skip:
    addl $1, %ecx

.condition:
    cmpl Array_length, %ecx
    jl .L1

    movl %eax, max
    
    ## movl $0, %eax
    popl %ebp
    ret
.section .note.GNU-stack,"",@progbits
