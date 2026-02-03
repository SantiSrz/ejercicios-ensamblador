section .text
global _start
    _start:

    mov eax, 0
    mov ecx, 5

bucle:
    add eax, ecx
    dec ecx
    cmp ecx, 0
    jne bucle

    mov ebx, eax
    mov eax, 1
    int 0x80