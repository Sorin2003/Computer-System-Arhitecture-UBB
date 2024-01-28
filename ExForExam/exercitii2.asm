bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf, fopen, fclose, fread              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll   
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll                        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;baga de la tastatura un numar si are un fisier cu cuvinte si sa numere cuvintele pare mai lungi decat numarul bagat de la tastatura
    fin db 'in.txt', 0
    file dd 0
    mode db 'r', 0
    format db '%u', 0
    len equ 100
    rez times (len+1) db 0
    n resb 4
    form db "%u", 0
    count times len db 0
    cont times len db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...\
   ;read
    push dword n
    push dword form
    call [scanf]
    add esp, 4 * 2
    
    ;open file
    push dword mode
    push dword fin
    call [fopen]
    add esp, 4 * 2
    mov [file], eax
    cmp eax,0
    je exit
    mov ah, 0
    mov bx, 0
    ;read
    push dword [file]
    push dword len
    push dword 1
    push dword rez
    call [fread]
    add esp, 4 * 4
    mov esi, rez
    mov ecx, len
    mov ebx, 0;
    mov ah, 0
        repeta:
        lodsb
        cmp al, ''
        je closez
        cmp al, ' '
        je zero
        inc bx
        loop repeta
        
        zero:
        cmp bx, [n]
        ja pc
        mov bx, 0
        loop repeta
        
        pc:
        shr bx, 1
        jnc ad
        loop repeta
        
        ad:
        inc ah
        loop repeta
        
        closez:
        cmp bx, [n]
        ja pcz
        mov bx, 0
        jmp close
        
        pcz:
        shr bx, 1
        jnc adz
        jmp close
        
        adz:
        inc ah
        jmp close
         
        
        close:
         mov ebx, 0
        mov bl, ah
        push dword [file]
        call [fclose]
        add esp, 4
        
        
        push dword ebx
        push dword format
        call [printf]
        add esp, 4 * 2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
