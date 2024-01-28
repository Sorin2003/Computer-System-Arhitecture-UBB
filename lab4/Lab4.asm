bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-2 of C have the value 0
    ;the bits 3-5 of C have the value 1
    ;the bits 6-9 of C are the same as the bits 11-14 of A
    ;the bits 10-15 of C are the same as the bits 1-6 of B
    ;the bits 16-31 of C have the value 1
   a dw    0101011101010111b
          ;0CCCC
   b dw    1011011011110010b
          ;         CCCCCC0
   c dd    11111111111111110000000000111000b


; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, [a]
        and ax, 0111100000000000b   ;flip to 0 all the bits that we don't need
        shr ax, 5                   ;shift to right so the bits overlap
        xor ecx,ecx                 ;ecx = 0
        mov ecx, [c]
        or cx, ax                   ;flip the missing bits of c that we need
        mov ax, [b]
        and ax, 0000000001111110b   ;flip to 0 all the bits that we don't need
        shl ax, 9                   ;shift to left so the bits overlap
        or cx,ax                    ;flip the missing bits of c that we need
        mov eax, ecx                ;eax = rez (11111111111111111110011010111000)
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
