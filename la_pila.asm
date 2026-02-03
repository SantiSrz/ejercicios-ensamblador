section .data
mensaje db 'Escribe algo: ', 0xa
len equ $ - mensaje

section .bss
buffer resb 64

section .text
global _start
    _start:

    

