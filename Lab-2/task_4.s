## Task:Write a program for the series 1+2+3+….+N (N=10) and put the sum into memory location 0x50


.section .bss
.globl ram
.lcomm ram, 256

.section .data
var1:  .byte 0
sum:   .byte 0
count: .byte 10     ## if count = 9, then it would stop early and not be 10 fully

.section .text
.globl fill_ram


fill_ram:

    loop_add:
        addb $1, var1
        movb var1, %al

        addb %al, sum

        decb count 
       
    jne loop_add

movb sum, %al  ## cannot move memory to memory
movb %al, ram+0x50
ret
.section .note.GNU-stack,"", @progbits
