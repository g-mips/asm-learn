    .intel_syntax noprefix

    .global _start

.data
hello_str:
    .ascii "Hello World\n"
    .set hello_str_len, . - hello_str

.text
_start:
    mov eax, 4
    mov ebx, 1
    lea ecx, hello_str
    mov edx, hello_str_len
    int 0x80

    mov eax, 1
    mov ebx, 2
    int 0x80
