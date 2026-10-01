## Assembly code for storing the array address into %rdi
## sum_array(array, count)

.section .text

.globl sum_array ## visible to c file

sum_array:
    movl $0, %eax ## should hold the sum  
    movl $0, %ecx ## for the index to add to the sum

    
loop:
    # to get the array index: (%rdi, %rcx, 4) #4 bytes : 1 int

    addl (%rdi, %rcx, 4), %eax
    incl %ecx #index increment
    cmpl %esi, %ecx  # i stored in lower half of rsi 
    jl loop

    ret
.section .note.GNU-stack,"", @progbits
