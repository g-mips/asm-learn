global _start

section .data
    msg db 'Hello World!', 0Ah
    msg_len equ $ - msg

section .text
_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg]
    mov rdx, msg_len
    syscall

    mov rax, 60
    mov rdi, 3
    syscall
