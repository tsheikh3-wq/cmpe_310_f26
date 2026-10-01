## Task: Write a program to clear RAM locations starting at RAM ADDRESS 0X50 TO 0X58

.section .bss
.globl ram
.lcomm ram, 256

.section .data
count: .byte 9 

.section .text
.globl fill_ram  

fill_ram:


    movq $ram+0X50, %rax

    loop_2:
        ## clearing the ram
    
        movb $0x00, (%rax)
        incq %rax
        decb count

    jne loop_2

ret

.section .note.GNU-stack,"", @progbits
