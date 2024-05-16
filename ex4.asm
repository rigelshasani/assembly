global _start

section .text
_start:
    mov ebx, 1    ; start ebx at 1*
    mov ecx, 8    ; number of iterations
label:
    add ebx,ebx   ; ebx += ebx
    dec ecx       ; ecx -= 1
    cmp ecx, 0    ; compare to 0
    jg label      ; jump if greater to label
    mov eax, 1    ; sys_exit syscall
    int 0x80      ;