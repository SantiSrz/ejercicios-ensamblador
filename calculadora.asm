section .text
    global _start
_start:
    ; Resultado = (10 + 20) - 5 + 2

    mov eax, 10 ; creo el valor 10
    mov ebx, 20 ; creo el valor 20

    add eax, ebx ; sumo el 20 de ebx en eax, ahora eax vale 30
    sub eax, 5 ; resto 5 a eax
    add eax, 2 ; sumo 2 a eax

    mov ebx, eax ; guardo el valor del resultado en ebx porque es la que lee el kernel y libero eax para poner el comando 1
    mov eax, 1 ; se pone la instruccion 1 para salir
    
    int 0x80 ; llamo al kernel para que ejecute
