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
    a db 6
    b db 5
    c db 4
    d dw 2

; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov al, byte[a] ;byte a in al
    mov ah, 2       ;2 in ah
    mul ah          ;multiply al(a) with ah(2) -> ax   (a*2)
    mov bl, al      ;a*2 converted to byte from word in bl (unsigned) bl = (a*2)
    mov al, byte[b] ;byte b in al
    sub al, 3       ;substract 3 from al(b) al =(b-3)
    mov ah, 2       ;2 in ah
    mul ah          ;al 2*(b-3) -> ax = (b-3)*2
    add bl, al      ;add al (byte converted from ax) to bl (unsigned) bl = (a*2)+(b-3)*2 
    mov ax, 0       ;0 in ax so i can convert from byte to word ax = 0
    add al, bl      ;add bl to al (ax) ax=(a*2)+(b-3)*2 
    sub ax, word[d] ;substract the word d from ax  ax = (a*2)+(b-3)*2-d
    mov bx, ax      ;move ax in bx
    mov al, byte[c] ;move c to al
    mov ah, 2       ;move 2 to ah
    mul ah          ;ah*al  2*c -> ax
    sub bx, ax      ;the final substraction ax = (a*2)+(b-3)*2-d-2*c
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program