# Assembly Language: A dive into low level programming

First step: install NASM. NASM(Netwide Assembler) is an assembler and disassembler for the Intel x86_64 architecture.<br/>

```Ezoic

$ sudo apt install nasm    #For Debian, Ubuntu, Linux Mint
$ sudo dnf install nasm    #For RHEL, Fedora, AlmaLinux
$ sudo pacman -S nasm      #For Arch, Manjaro, EndeavourOS
```

## Example 1:

In my case I used the Manjaro command, and after fixing some pacman -Syu issues, I was good to go.<br/>

```Assembly
global _start          ;<-- entry point
_start:
    mov eax, 1         ;<-- moves  1 into register eax
    mov ebx, 42        ;<-- moves 42 into register ebx
    int 0x80           ;<-- interrupts the program with exit code (hex 80) which is interrupt handler for syscalls
                       ;    the syscall that it makes it dependent on the EAX register and what it stores
```

## Assemble, Link and Execute<br/>

ASSEMBLE 32 bit ELF object file. <br />

```
nasm -f elf32 ex1.asm -o ex1.o
```

LINK executable from OBJ file. <br />

```
ld -m elf_i386 ex1.o ex1
```

EXECUTE it <br />

```
./ex1
```

Check for return <br />

```
echo $?
```

Possible operations in Assembly. Keep in mind that multiplication and division are only performed in the EAX.<br/>

```assembly
mov ebx, 123  ; EBX  = 123
mov eax, ebx  ; EAX  = EBX
add ebx, ecx  ; EBX += ECX
sub ebx, ecx  ; EBX -= ECX
mul ebx       ; EAX *= EBX
div edx       ; EAX /= EDX
```

## Example 2<br/>

```assembly
global _start

section .data
    msg db "Hello, World", 0x0a
    len equ $ - msg

section .text
_start:
    mov eax, 4   ; sys_write syscall
    mov ebc, 1   ; stdout file descriptor
    mov ecx, msg ; bytes to write
    mov edx, len ; number of bytes to write
    int 0x80     ; perform syscall
    mov eax,1    ; move 1 to eax to tell it to perform sys_exit
    mov ebx,0    ; exit status is 0
    int 0x80     ; perform syscall
```

After assembling, linking and executing, we should see the ol' familiar "Hello World" on our terminal.<br/>

[//]: # "CTRL+SHIFT+V to go to preview mode"
[//]: # "CTRL+K V to view side by side"

## Example 3

```assembly
global _start
section .text
_start:
    mov ebx, 42  ; exit status is 42
    mov eax, 1   ; syscall for exit
    jmp skip     ; jump to "skip" label*
    mov ebx, 13  ; exit status is 13

skip:
    int 0x80
```

- "\*" The resulting operation here is that the instruction pointer is moved to the location of this "skip" label, so when this program executes, the line `mov ebx, 13` is skipped, because `int 0x80` interrupts the programs and causes it to exit.

## Conditionals in Assembly

```Assembly
je  A, B   ; Jump if Equal
jne A, B   ; Jump if Not Equal
jg  A, B   ; Jump if Greater
jge A, B   ; Jump if Greater than or Equal To
jl  A, B   ; Jump if Less Than
jle A, B   ; Jump if Less Than or Equal To
```

## Example 3: Part 2

```Assembly
global _start
section .text
_start:
    mov ecx, 99  ; set ecx to 99
    mov ebx, 42  ; exit status is 42
    mov eax, 1   ; sys_exit syscall
    cmp ecx, 100 ; compares ecx to 100
    jl skip      ; jump if less than
    mov ebx, 13  ; exit statu is 13

skip:
    int 0x80
```

## Example 4

```Assembly
global _start

section .text
_start:
    mov ebx, 1    ; start ebx at 1*
    mov ecx, 4    ; number of iterations
label:
    add ebx,ebx   ; ebx += ebx
    dec ecx       ; ecx -= 1
    cmp ecx, 0    ; compare to 0
    jg label      ; jump if greater to label
    mov eax, 1    ; sys_exit syscall
    int 0x80      ;
```

- "\*" - Never use the return code to return useful info, always return 0 if no issues. Tutorial is using this just to show output.<br/>

### Fun fact:
*Max number of iterations you can do with this code is 7, for te result of 128. If you do 8 iterations, you get 0, because I guess 256 overflows. A way to show that it indeed overflows is to add a `dec ebx` before you return, and it actually returns 255 when you `echo $?`. Cool stuff.* <br/>
