section .data
numeroA DD 15
numeroB DD 10

section .text
global _start
    _start:

    mov eax, [numeroA]
    mov ebx, [numeroB]

    add eax, ebx

    mov ebx, eax
    mov eax, 1

    int 0x80