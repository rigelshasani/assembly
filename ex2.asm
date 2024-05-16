global _start

section .data
    msg db "Hello, World", 0x0a
    len equ $ - msg

section .text
_start:
    mov eax, 4   ; sys_write syscall
    mov ebx, 1   ; stdout file descriptor
    mov ecx, msg ; bytes to write
    mov edx, len ; number of bytes to write
    int 0x80     ; perform syscall
    mov eax,1    ; move 1 to eax to tell it to perform sys_exit
    mov ebx,0    ; exit status is 0
    int 0x80     ; perform syscall