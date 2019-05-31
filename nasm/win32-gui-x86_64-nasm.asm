extern ExitProcess
extern RegisterClassExW
extern CreateWindowExW
extern ShowWindow
extern PostQuitMessage
extern FillRect
extern BeginPaint
extern EndPaint
extern DefWindowProcW
extern GetMessageW
extern TranslateMessage
extern DispatchMessageW
extern MessageBoxA
extern GetLastError

global WinMain
global WindowProc

section .data
;;;; String Literals ;;;;
class_name dw __utf16__('Sample Window Class'), 00h
title      dw __utf16__('Learn to Program Windows'), 00h

;;;; CODE ;;;;
section .text

;;;;
; WindowProc
;;;;
WindowProc:
    push   rbp
    mov    rbp, rsp
    ; shadow space. parameter space. local variables
    sub    rsp, (16 + 72 + 8 + 32)

%define psStart    88
%define ps         rbp - (psStart     ) ; PAINTSTRUCT 72 bytes
%define ps.rcPaint rbp - (psStart - 12) ; 16 bytes

    ; Save WindowProc parameters into local variables
    mov    qword [rbp + 16], rcx ; hwnd
    mov    dword [rbp + 24], edx ; uMsg
    mov    qword [rbp + 32], r8 ; wParam
    mov    qword [rbp + 40], r9 ; lParam

    ; Switch on uMsg
    cmp    dword [rbp + 24], 2 ; WM_DESTROY
    je     .LWindowProc_quit
    cmp    dword [rbp + 24], 15 ; WM_PAINT
    je     .LWindowProc_paint

    ; Default
    mov    rcx, [rbp + 16]
    mov    edx, dword [rbp + 24]
    mov    r8, [rbp + 32]
    mov    r9, [rbp + 40]
    call   DefWindowProcW
    jmp    .LWindowProc_end

.LWindowProc_quit:
    mov    rcx, 0
    call   PostQuitMessage

    mov    rax, 0
    jmp    .LWindowProc_end

.LWindowProc_paint:
    mov    rcx, [rbp + 16]
    lea    rdx, [ps]
    call   BeginPaint

    mov    rcx, rax
    lea    rdx, [ps.rcPaint]
    mov    r8, 6
    call   FillRect

    mov    rcx, [rbp + 16]
    lea    rdx, [ps]
    call   EndPaint

    mov    rax, 0
    jmp    .LWindowProc_end

.LWindowProc_end:
    add    rsp, (16 + 72 + 8 + 32)
    pop    rbp
    ret

;;;;
; WinMain
;;;;
WinMain:
    push   rbp      ; Save current frame pointer
    mov    rbp, rsp ; Save current stack pointer
    ; 16 byte boundary. local. padding. parameters shadow space.
    sub    rsp, (16 + 152 + 8 + 64 + 32)

    ; Save WinMain parameters into shadow space
    ; (Start at offset 16 to skip return address and current
    ;  rbp in the stack)
    mov    qword [rbp + 16], rcx ; hInstance
    mov    qword [rbp + 24], rdx ; hPrevInstance
    mov    qword [rbp + 32], r8 ; pCmdLine
    mov    dword [rbp + 40], r9d ; nCmdShow

%define wcStart          96                   ;
%define wc               rbp - (wcStart     ) ; WNDCLASSEX struct, 80 bytes
%define wc.cbSize        rbp - (wcStart     ) ; 4 bytes 96 - 92
%define wc.style         rbp - (wcStart - 4 ) ; 4 bytes 92 - 88
%define wc.lpfnWndProc   rbp - (wcStart - 8 ) ; 8 bytes 88 - 80
%define wc.cbClsExtra    rbp - (wcStart - 16) ; 4 bytes 80 - 76
%define wc.cbWndExtra    rbp - (wcStart - 20) ; 4 bytes 76 - 72
%define wc.hInstance     rbp - (wcStart - 24) ; 8 bytes 72 - 64
%define wc.hIcon         rbp - (wcStart - 32) ; 8 bytes 64 - 32
%define wc.hCursor       rbp - (wcStart - 40) ; 8 bytes 56 - 48
%define wc.hbrBackground rbp - (wcStart - 48) ; 8 bytes 48 - 40
%define wc.lpszMenuName  rbp - (wcStart - 56) ; 8 bytes 40 - 32
%define wc.lpszClassName rbp - (wcStart - 64) ; 8 bytes 32 - 24
%define wc.hIconSm       rbp - (wcStart - 72) ; 8 bytes 24 - 16

%define hwndStart 104
%define hwnd      rbp - hwndStart ; 8 bytes 104 - 96

%define msgStart     152                   ;
%define msg          rbp - (msgStart     ) ; MSG struct, 48 bytes
%define msg.hwnd     rbp - (msgStart     ) ; 8 bytes 152 - 144
%define msg.message  rbp - (msgStart - 4 ) ; 4 bytes 144 - 140
%define msg.pad1     rbp - (msgStart - 8 ) ; 4 bytes 140 - 136
%define msg.wParam   rbp - (msgStart - 16) ; 8 bytes 136 - 128
%define msg.lParam   rbp - (msgStart - 24) ; 8 bytes 128 - 120
%define msg.time     rbp - (msgStart - 32) ; 4 bytes 120 - 116
%define msg.pt.x     rbp - (msgStart - 36) ; 4 bytes 116 - 112
%define msg.pt.y     rbp - (msgStart - 40) ; 4 bytes 112 - 108
%define msg.pad2     rbp - (msgStart - 44) ; 4 bytes 108 - 104

    ;mov    rcx, 0
    ;lea    rdx, [class_name]
    ;lea    r8, [title]
    ;mov    r9, 0
    ;call   MessageBoxA

    ;mov    eax, 0
    ;add    rsp, (16 + 152 + 8 + 64 + 32)
    ;pop    rbp
    ;ret

    ; Setup wc
    mov    dword [wc.cbSize], 80
    mov    dword [wc.style], 0
    mov    qword [wc.lpfnWndProc], 0
    mov    qword [wc.cbClsExtra], 0
    mov    qword [wc.cbWndExtra], 0
    mov    qword [wc.hInstance], 0
    mov    qword [wc.hIcon], 0
    mov    qword [wc.hCursor], 0
    mov    qword [wc.hbrBackground], 0
    mov    qword [wc.lpszMenuName], 0
    mov    qword [wc.lpszClassName], 0
    mov    qword [wc.hIconSm], 0
    lea    r11, [WindowProc]
    mov    qword [wc.lpfnWndProc], r11
    mov    r11, qword [rbp + 16]
    mov    qword [wc.hInstance], r11
    lea    r11, [class_name]
    mov    qword [wc.lpszClassName], r11

    ; RegisterClassExW
    lea    rcx, [wc]
    call   RegisterClassExW

    call   GetLastError

    ; CreateWindowExW
    mov    rcx, 0
    lea    rdx, [class_name]
    lea    r8, [title]
    mov    r9, 13565952
    mov    qword [rsp + 4 * 8], -2147483648
    mov    qword [rsp + 5 * 8], -2147483648
    mov    qword [rsp + 6 * 8], -2147483648
    mov    qword [rsp + 7 * 8], -2147483648
    mov    qword [rsp + 8 * 8], 0x00
    mov    qword [rsp + 9 * 8], 0x00
    mov    r11, qword [wc.hInstance]
    mov    qword [rsp + 10 * 8], r11
    mov    qword [rsp + 11 * 8], 0x00
    call   CreateWindowExW
    mov    qword [hwnd], rax

    ; Make sure the hwnd is not NULL
    cmp    qword [hwnd], 0x00
    je     .LWinMain_end

    mov    rcx, qword [hwnd]
    mov    rdx, qword [rbp + 40]
    call   ShowWindow

.LWinMain_get_msg_loop:
    lea    rcx, [msg]
    mov    rdx, 0x00
    mov    r8, 0x00
    mov    r9, 0x00
    call   GetMessageW

    cmp    rax, 0x00
    je     .LWinMain_end

    lea    rcx, [msg]
    call   TranslateMessage

    lea    rcx, [msg]
    call   DispatchMessageW
    jmp    .LWinMain_get_msg_loop

.LWinMain_end:
    mov    eax, 0
    add    rsp, (16 + 152 + 8 + 64 + 32)
    pop    rbp
    ret
