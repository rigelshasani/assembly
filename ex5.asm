global _start              ; global _start
section .data              ; section .data
    addr db "yellow"       ;     addr db "yellow"
section .text              ; section .text
_start:                    ; _start:
    mov [addr], byte 'H'   ;
    mov [addr+5],byte '!'  ;
    mov eax, 4             ;     mov eax, 4
    mov ebx, 1             ;     mov ebx, 1
    mov ecx, addr          ;     mov ecx, addr
    mov edx, 6             ;     mov edx, 6
    int 0x80               ;     int 0x80
    mov eax, 1             ;     mov eax, 1
    mov ebx, 0             ;     mov ebx, 0
    int 0x80               ;     int 0x80