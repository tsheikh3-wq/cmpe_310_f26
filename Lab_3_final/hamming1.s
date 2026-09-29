.section .bss #reserving space for the strings

.lcomm string1, 256   #Maximum string length =256
.lcomm string2, 256

.lcomm len1, 8   #bytes read string1
.lcomm len2, 8   #bytes read from string2
.lcomm hamming_distance, 8
.lcomm output, 32

.section .data # prompt to enter the strings
newline: .byte 10
prompt1: .ascii "Enter your first string: "
prompt1_len = . - prompt1   # length of string1

prompt2: .ascii "Enter your second string: "
prompt2_len = . - prompt2  #length of second string


result_msg: .ascii "Hamming distance: "
result_msg_len = . - result_msg

.section .text
.globl _start

_start:

## printing first prompt 
mov $1, %rax
mov $1, %rdi
mov $prompt1, %rsi
mov $prompt1_len, %rdx
syscall

## reading string1
mov $0, %rax  # read syscall
mov $0, %rdi
mov $string1, %rsi #rsi contains address of where input will be store
mov $255, %rdx
syscall

decq %rax ## removing new line
movq %rax, len1

## second prompt
mov $1, %rax
mov $1, %rdi
mov $prompt2, %rsi
mov $prompt2_len, %rdx
syscall

## storing string2

mov $0, %rax
mov $0, %rdi
mov $string2, %rsi
mov $256, %rdx
syscall

decq %rax ## removing new line
movq %rax, len2    #moving value in %rax into len2


## comparing the lengths

movq len1, %rbx
cmpq len2, %rbx
jbe len1_shorter   #if len1 <= len2, jump

movq len2, %rcx
jmp length

len1_shorter:
    movq len1, %rcx

length:
## rcx has shorter length

movq $0, %rdi   #index = 0
movq $0, %rsi   # for total hamming distance

cmpq $0, %rcx # just in case if the shorter length = 0
je end_compare  # if yes, nothing to compare_chars


compare_chars:
    movb string1(%rdi), %al   # string 1 + index
    movb string2(%rdi), %bl

    ## to know which bits are different
    xorb %bl, %al
    movq $8, %rdx ## every character has 8 bits

bit_loop:

testb $1, %al   #testing the lowest bit from xorb
jz next_bit
incq %rsi    ## incrementing hamming distance

next_bit:  

shrb $1, %al   ##shifting to the right by 1
decq %rdx
jne bit_loop   ## repeating until all 8 bits are checked

incq %rdi   ## move to the next character as rdi has the index
decq %rcx   ## reducing the length
jne compare_chars



## rsi: stores the total hamming distance
## rdi: tells us character index
## rdx: counts the 8 bits in one character
## rcx: counts how many characters are left


end_compare:
movq %rsi, hamming_distance

## printing out the hamming result
mov $1, %rax
mov $1, %rdi
mov $result_msg, %rsi
mov $result_msg_len, %rdx
syscall

# number conversion

movq hamming_distance, %rax
movq $10, %rbx  ## to divide by 10
movq $0, %rcx
movq $output+31, %rdi  #division stores backwards so we store right to left

convert_loop:

xorq %rdx, %rdx  #clearing it out
divq %rbx       #divide by 10
                # RAX : quotient
                # rdx : remainder
addb $ '0', %dl        ##converting the remainder into ascii
movb %dl, (%rdi)                # storing digit

decq %rdi                       
incq %rcx                      

cmpq $0, %rax                  
jne convert_loop                

## printing the number

incq %rdi
movq %rdi, %rsi
movq %rcx, %rdx

movq $1, %rax
movq $1, %rdi
syscall
# temporary newline for cleaner output
movq $1, %rax
movq $1, %rdi
movq $newline, %rsi
movq $1, %rdx
syscall

##exit
mov $60, %rax # exit
mov $0, %rdi # status
syscall
