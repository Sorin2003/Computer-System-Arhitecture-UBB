bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 2
    b db 4
    c db 5
    d db 7
    e dw 9
    f dw 17
    g dw 14
    h dw 15

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, word[f] ;word f in ax
        mov bx, word[e] ;word e in bx
        sub bx, 2       ;(e-2) -> bx
        mul bx          ;f*(e-2) -> DX:AX
        push dx         ;dx on stack
        push ax         ;ax on stack
        mov al, 3       
        mov bh, byte[d]
        sub bh, 5       ;(d-5) -> bh
        mul bh          ;ax<-3*(d-5)
        mov bx, ax
        mov eax, 0
        pop ax 
        div bx
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program