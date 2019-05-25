/**
 * https://docs.microsoft.com/en-us/windows/desktop/WinProg/windows-data-types
 *
 * Win32 x86_64 Intel Assembly (GAS)
 * - Calling Convention:
 *   - Microsoft x64 calling convention
 *   - First
 *     - RCX, RDX, R8, R9 (integers)
 *     - XMM0, XMM1, XMM2, XMM3 (floats)
 *   - Then stack, parameter order on stack: Right to Left
 *   - Stack Cleanup:
 *     - Caller
 *     - Stack aligned on 16 bytes. 32 bytes shadow space on stack.
 *       The specified 8 registers can only be used for paramters 1 through 4
 *
 * Compiled with:
 * - x86_64-w64-mingw32-gcc -e start -nostdlib win32-console-x86_64-gas-intel.s -lkenerl32
 **/
    .intel_syntax noprefix

    .global start

.data
msg:
    .ascii  "Hello Win64 Bit World\n"
    .set msg_str_len, . - msg

.bss
written:
    .int    0

handle:
    .int    0

.text
start:
    /* handle = GetStdHandle(-11) */
    mov     ecx, -11
    mov     rax, [rip + __imp_GetStdHandle]
    call    rax
    mov     handle, rax

    /* WriteConsole(handle, &msg[0], 22, &written, 0) */
    mov     rcx, handle
    lea     rdx, msg
    mov     r8d, msg_str_len
    lea     r9, written
    push    0
    mov     rax, [rip + __imp_WriteConsoleA]
    call    rax

    /* ExitProcess(0) */
    mov     ecx, 0
    mov     rax, [rip + __imp_ExitProcess]
    call    rax
