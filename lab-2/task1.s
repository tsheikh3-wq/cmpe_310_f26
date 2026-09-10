# Task 1

.section .bss
.globl ram
.lcomm ram, 256

.section .text
.globl fill_ram    # 
fill_ram:
    mov $0xFF, ram+0x50
    mov $0xFF, ram+0x51
    mov $0xFF, ram+0x52
    mov $0xFF, ram+0x53
    mov $0xFF, ram+0x54
    mov $0xFF, ram+0x55
    mov $0xFF, ram+0x56
    mov $0xFF, ram+0x57
    mov $0xFF, ram+0x58
    
    ret

.section .note.GNU-stack,"", @progbits