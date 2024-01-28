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
    a dw 7
    b dw 4
    c dw 5
    d dw 8
; our code starts here
segment code use32 class=code
    start:
        ; ...
    ;(a-b+c)-(d+d)
        mov ax, word[a]  ;a in ax
        sub ax, word[b]  ;a-b -> ax
        add ax, word[c]  ;(a-b+c) -> ax
        mov bx, word[d]  ; d in bx
        add bx, word[d]  ;(d+d) in bx
        sub ax, bx       ;ax-bx (a-b+c)-(d+d) -> ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
