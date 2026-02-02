section .data
edad DD 15

section .text
global _start
    _start:

    mov eax, [edad]
    cmp eax, 18

    jge es_mayor_o_igual
    jmp es_menor

es_mayor_o_igual:
    mov ebx, 1
    jmp fin

es_menor:
    mov ebx, 0
    jmp fin

fin:
    mov eax, 1
    int 0x80