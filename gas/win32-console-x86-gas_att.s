/**
 * https://docs.microsoft.com/en-us/windows/desktop/WinProg/windows-data-types
 *
 * Win32 x86 Intel Assembly (GAS)
 **/
    .global start

.data
msg:
    .ascii  "Hello Win32 Bit World\n"
    .set msg_str_len, . - msg

.bss
handle:
    .int    0

written:
    .int    0

.text
start:
    /* handle = GetStdHandle(-11) */
    push    $-11
    call    _GetStdHandle@4
    mov     %eax, handle

    /* WriteConsole(handle, &msg[0], 22, &written, 0) */
    push    $0
    push    $written
    push    $msg_str_len
    push    $msg
    push    handle
    call    _WriteConsoleA@20

    push    $1000
    push    $493
    call    _Beep@8

    push    $2000
    push    $329
    call    _Beep@8

    push    $1000
    push    $392
    call    _Beep@8

    push    $1000
    push    $493
    call    _Beep@8

    push    $2000
    push    $329
    call    _Beep@8

    push    $1000
    push    $392
    call    _Beep@8

    push    $500
    push    $493
    call    _Beep@8

    push    $500
    push    $587
    call    _Beep@8

    push    $1000
    push    $554
    call    _Beep@8

    push    $1000
    push    $440
    call    _Beep@8

    push    $500
    push    $392
    call    _Beep@8

    push    $500
    push    $440
    call    _Beep@8

    push    $1000
    push    $493
    call    _Beep@8

    push    $1000
    push    $329
    call    _Beep@8

    push    $500
    push    $293
    call    _Beep@8

    push    $500
    push    $369
    call    _Beep@8

    push    $3000
    push    $329
    call    _Beep@8

    /* ExitProcess(0) */
    push    $0
    call    _ExitProcess@4
