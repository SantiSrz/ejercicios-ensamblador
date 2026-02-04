section .data
    mensaje db 'Escribe algo: ', 0xa ; Define la cadena con un salto de línea (0xa)
    longitud equ $ - mensaje         ; Calcula automáticamente el tamaño del mensaje

section .bss
    buffer resb 64                   ; Reserva 64 bytes de espacio vacío para la entrada del usuario

section .text
    global _start
_start:

    ; --- Bloque 1: Imprimir el mensaje inicial ---
    mov eax, 4          ; Llamada al sistema (syscall) para 'write' (escribir)
    mov ebx, 1          ; File descriptor 1: salida estándar (pantalla)
    mov ecx, mensaje    ; Dirección del texto a imprimir
    mov edx, longitud   ; Cuántos bytes imprimir
    int 0x80            ; Interrupción 0x80: ejecuta la llamada al kernel de Linux

    ; --- Bloque 2: Leer lo que el usuario escribe ---
    mov eax, 3          ; Llamada al sistema para 'read' (leer)
    mov ebx, 0          ; File descriptor 0: entrada estándar (teclado)
    mov ecx, buffer     ; Dónde guardar lo que el usuario escriba
    mov edx, 64         ; Límite máximo de bytes a leer
    int 0x80            ; Interrupción 0x80: el programa se detiene y espera al usuario
    ; Nota: Después de int 0x80, EAX guarda el número de bytes que el usuario escribió realmente.

    ; --- Bloque 3: Preparar el recorrido del buffer ---
    mov ecx, eax        ; Ponemos en ECX el número de bytes leídos (servirá como contador del bucle)
    mov esi, buffer     ; Ponemos en ESI la dirección de inicio de nuestro buffer

bucle:
    mov ebx, 0          ; Limpiamos EBX para que no tenga basura
    mov bl, [esi]       ; Movemos el carácter actual (1 byte) a la parte baja de EBX (BL)
    push ebx            ; Guardamos el carácter en la pila (LIFO: el último entrará primero al salir)
    inc esi             ; Avanzamos el puntero ESI al siguiente carácter
    loop bucle          ; Decrementa ECX y salta a 'bucle' si ECX no es 0

    ; --- Bloque 4: Preparar la inversión (sacar de la pila) ---
    mov ecx, eax        ; Reiniciamos el contador con la cantidad de bytes leídos
    mov esi, buffer     ; Reiniciamos ESI al principio del buffer para sobreescribirlo

desapilar:
    pop ebx             ; Sacamos el último valor que entró a la pila (el final de la palabra)
    mov [esi], bl       ; Lo guardamos en la posición actual del buffer
    inc esi             ; Avanzamos el puntero ESI
    loop desapilar      ; Repetimos hasta vaciar lo que metimos

    ; --- Bloque 5: Imprimir el resultado (el texto invertido) ---
    mov eax, 4          ; Syscall 'write'
    mov ebx, 1          ; Salida estándar (pantalla)
    mov ecx, buffer     ; El buffer ahora contiene el texto al revés
    mov edx, 64         ; Imprimimos los 64 bytes (o podrías usar el valor original de EAX)
    int 0x80            ; Ejecutar

    ; --- Bloque 6: Salida limpia del programa ---
    mov eax, 1          ; Syscall 'exit' (terminar programa)
    mov ebx, 0          ; Código de retorno 0 (sin errores)
    int 0x80            ; Ejecutar