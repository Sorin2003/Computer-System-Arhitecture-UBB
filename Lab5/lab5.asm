bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A: 2, 1, 3, 3, 4, 2, 6
    ;B: 4, 5, 7, 6, 2, 1
    ;R: 1, 2, 6, 7, 5, 4, 1, 3, 3
    A db 2, 1, 3, 3, 4, 2, 6
    B db 4, 5, 7, 6, 2, 1
    lA equ $ - A - B
    lB equ $ - B
    R times lA db 0
; our code starts here
segment code use32 class=code
    start:
    mov ecx, lA
        ;Two byte strings A and B are6 given. Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A.
        xor esi,esi ;put esi on 0 so i can use it for the loops
        mov edi, lB ;mov the lenght of B in edi so we can use it to start from the last element
        reverse_B:                ;loop for the reversed elements of B
            mov al, [B + edi - 1] ;element of B in al starting from the last element because [B + edi] edi being the lenght of B in the beginning
            mov [R + esi], al     ;moving the element in R
            inc esi               ;esi + 1 so we add to the next poz
            dec edi               ;edi - 1 so we get the previous poz
            cmp esi, lB           ;verify if we're done sets zf to 1 if esi = lB (cf = 1 if lower)
        jb reverse_B              ;jump if cf = 1
        xor edi,edi               ;put edi on 0 so we can use it in the loop
        odd_A:                    ;loop for the odd elements of a
            mov al, [A + edi]     ;element of A in al
            test al, 1            ;set zf to and pf to 1 if even and to 0 if odd
            jz not_odd            ;if the zf is set to 1(the number was even) then we go into not odd loop
            mov [R + esi], al     ;if the jz didn t jump us to not_odd loop then we add the odd number to our list
            inc esi               ;esi+1 so we can write the next element
            cmp edi,lA            ;we check if we finished the numbers (zf is one if we're done)
            not_odd:        ;jump the number if it s even
                inc edi     ; we go to the next number
                cmp edi, lA ; lA is a constant, so we do not use [l1] we check if we finished the numbers
        jb odd_A  ;if zf = 1 then we jump out             
            
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
