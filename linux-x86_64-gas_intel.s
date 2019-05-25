    .intel_syntax noprefix

    .global _start

.data
    .align 8
hello_str:
    .ascii "Hello World\n"
    .set hello_str_len, . - hello_str

.text
_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, hello_str
    mov rdx, hello_str_len
    syscall

    mov rax, 60
    mov rdi, 2
    syscall
