extern GetStdHandle
extern WriteConsoleA
extern ExitProcess

global start

section .data
    msg db 'Hello World!', 0Ah
    msg_len equ $ - msg

section .bss
    written resw 1
    handle resw 1

section .text
start:
    ; handle = GetStdHandle(-11)
    mov     ecx, -11
    call    GetStdHandle
    mov     [handle], rax

    ; WriteConsole(handle, &msg[0], 22, &written, 0)
    mov     rcx, [handle]
    lea     rdx, [msg]
    mov     r8d, msg_len
    lea     r9, [written]
    push    0
    call    WriteConsoleA

    ; ExitProcess(0)
    mov     ecx, 0
    call    ExitProcess
