##Task: Task 1 but with indirect addressing mode

.section .bss
.globl ram
.lcomm ram, 256

.section .data
count:  .byte 9

.section .text
.globl fill_ram  

fill_ram:
## indirect addressing


    movq $ram+0X50,%rax

    loop_1:

    movb $0xFF,(%rax)
    incq %rax
    decb count

    jne loop_1

ret

.section .note.GNU-stack,"", @progbits
