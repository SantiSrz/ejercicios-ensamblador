section .data
mensaje db 'Escribe algo: ', 0xa
len equ $ - mensaje

section .bss
buffer resb 64

section .text
global _start
    _start:

    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, len

    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 64

    int 0x80

    mov edx, eax

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer

    int 0x80

    mov eax, 1
    mov ebx, 0

    int 0x80