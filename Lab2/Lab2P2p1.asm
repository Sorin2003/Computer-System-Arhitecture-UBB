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
    a db 5
    b db 7
    c db 5
    d db 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, byte[a] ;byte a in al
        sub al, byte[b] ;substract byte b from al
        sub al, byte[d] ;substract byte d from al
        add al, 2       ;add 2 to al
        add al, byte[c] ;add byte c to al
        mov ah, 10      ;10 in ah
        sub ah, byte[b] ;substarct byte b from ah
        add al, ah      ;add al with ah
        ;final in al
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
