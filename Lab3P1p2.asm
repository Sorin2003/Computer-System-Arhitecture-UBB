bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword - Signed representation
    a db 31
    b dw 12
    c dd 345
    d dq 1989
; our code starts here
segment code use32 class=code
    start:
        ; c+a+b+b+a
    mov ebx, dword[c] ;ebx = c
    xor eax, eax      ;eax=0
    mov al,byte[a]    ;al = a
    cbw               ;al->ax
    cwde              ;ax->eax
    add eax,ebx       ;eax = c+a
    mov ebx,eax       ;ebx = c+a
    xor eax,eax       ;eax = 0
    mov ax, word[b]   ;ax = b
    cwde              ;ax -> eax
    add ebx,eax       ;ebx = c+a+b
    add ebx,eax       ;ebx = c+a+b+b
    xor eax, eax      ;eax=0
    mov al,byte[a]    ;al = a
    cbw               ;al->ax
    cwde              ;ax->eax
    add ebx,eax       ;ebx = c+a+b+b+a - reazolvarea
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
