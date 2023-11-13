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
    a db 17
    b dw 95
    c dd 110
    d dq 1989
; our code starts here
segment code use32 class=code
    start:
        ; a+b-c+(d-a) a - byte, b - word, c - double word, d - qword - Unsigned representation
    xor eax, eax       ;eax=0
    mov al, byte[a]    ;al=a
    add ax, word[b]    ;ax=a+b
    sub eax, dword[c]  ;eax=a+b-c
    xor edx, edx       ;edx=0
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
