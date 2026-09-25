.section .bss

.lcomm string1, 256
.lcomm string2, 256
.lcomm output, 4


.section .data

message1:
    .ascii "Enter first string: "
message1_len = . - message1

message2:
    .ascii "Enter second string: "
message2_len = . - message2

answer:
    .ascii "Hamming distance: "
answer_len = . - answer

newline:
    .ascii "\n"


.section .text
.globl _start


_start:

# first message
movq $1, %rax
movq $1, %rdi
movq $message1, %rsi
movq $message1_len, %rdx
syscall


# first string
movq $0, %rax
movq $0, %rdi
movq $string1, %rsi
movq $256, %rdx
syscall

movq %rax, %rbx
decq %rbx      # remove enter


# second message
movq $1, %rax
movq $1, %rdi
movq $message2, %rsi
movq $message2_len, %rdx
syscall


# second string
movq $0, %rax
movq $0, %rdi
movq $string2, %rsi
movq $256, %rdx
syscall

movq %rax, %rcx
decq %rcx      # remove enter


# get shorter length
cmpq %rcx, %rbx
jbe length_done

movq %rcx, %rbx


length_done:

movq $0, %rsi      # position
movq $0, %rdx      # distance


compare_chars:

cmpq %rbx, %rsi
je comparison_done


movb string1(%rsi), %al
movb string2(%rsi), %ah

xorb %ah, %al      # different bits become 1

movl $8, %ecx      # 8 bits


check_bits:

testb $1, %al
jz same_bit

incq %rdx          # add 1 if different


same_bit:

shrb $1, %al       # next bit

loop check_bits


incq %rsi          # next character
jmp compare_chars


comparison_done:

movq %rdx, %rbx    # save answer


# print answer message
movq $1, %rax
movq $1, %rdi
movq $answer, %rsi
movq $answer_len, %rdx
syscall


# start at 0000
movb $'0', output
movb $'0', output+1
movb $'0', output+2
movb $'0', output+3


thousands:

cmpq $1000, %rbx
jl hundreds

subq $1000, %rbx
incb output

jmp thousands


hundreds:

cmpq $100, %rbx
jl tens

subq $100, %rbx
incb output+1

jmp hundreds


tens:

cmpq $10, %rbx
jl ones

subq $10, %rbx
incb output+2

jmp tens


ones:

addb %bl, output+3


# skip zeros in front
movq $output, %rsi
movq $4, %rdx

cmpb $'0', (%rsi)
jne print_number

incq %rsi
decq %rdx

cmpb $'0', (%rsi)
jne print_number

incq %rsi
decq %rdx

cmpb $'0', (%rsi)
jne print_number

incq %rsi
decq %rdx


print_number:

movq $1, %rax
movq $1, %rdi
syscall


# new line
movq $1, %rax
movq $1, %rdi
movq $newline, %rsi
movq $1, %rdx
syscall


# exit
movq $60, %rax
movq $0, %rdi
syscall
