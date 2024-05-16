global _start
section .text
_start:
    mov ebx, 42  ;exit status is 42
    mov eax, 1   ;syscall for exit
    jmp skip     ;jump to "skip" label*
    mov ebx, 13  ;exit status is 13

skip:
    int 0x80