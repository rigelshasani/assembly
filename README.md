# assembly

Learning assembly.

First step: install NASM. NASM(Netwide Assembler) is an assembler and disassembler for the Intel x86_64 architecture.

```Ezoic

$ sudo apt install nasm    #For Debian, Ubuntu, Linux Mint
$ sudo dnf install nasm    #For RHEL, Fedora, AlmaLinux
$ sudo pacman -S nasm      #For Arch, Manjaro, EndeavourOS
```

Example 1:

In my case I used the Manjaro command, and after fixing some pacman -Syu issues, I was good to go.

```Assembly
global _start          ;<-- entry point
_start:
    mov eax, 1         ;<-- moves  1 into register eax
    mov ebx, 42        ;<-- moves 42 into register ebx
    int 0x80           ;<-- interrupts the program with exit code (hex 80) which is interrupt handler for syscalls
                       ;    the syscall that it makes it dependent on the EAX register and what it stores
```

Build 32 bit ELF object file. <br />
`nasm -f elf32 ex1.asm -o ex1.o` <br />
Build executable from OBJ file. <br />
`ld -m elf_i386 ex1.o ex1` <br />
Execute it <br />
`./ex1` <br />
Check for return <br />
`echo $?` should return 42 <br />
