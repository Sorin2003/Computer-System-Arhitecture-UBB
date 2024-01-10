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
    ;Given an array S of doublewords, build the array of bytes D formed from bytes of doublewords sorted as unsigned numbers in descending order.
    s DD 12345607h, 1A2B3C15h
    ;d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h
    len equ ($-s)
    R times len db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,s
        mov ecx,len
        mov edi,R
        mov ebx,0
        xor dl,dl
        make_string:         ;A loop to add all of the bytes of the array s in the array d
        lodsb ;move in al every element of the array starting from the second doublew
        stosb   ;move every element that we previously stored in al in R
        inc dl;
        cmp dl, len;        ;check if we have finished the array
        jb make_string       ;close the loop if the cmp says so
        sorted:
            mov cl, 1            ;sorted is true
            xor esi,esi          ;clear esi so we can start again
            sort:
                mov al, [R + esi]       ;put one element in al
                mov ah, [R + esi + 1]   ;put the next element in ah
                inc esi                 ;increment so we can go to the next ones
                cmp al, ah              ;compare them
                jb swap                 ;if the first one is smaller then swap them
                cmp esi, len-1          ;check if we checked all of the elements
                jb sort                 ;if we didn't go back in the loop
                cmp cl, 1               ;check if we did swap anything in the last loop
                jb sorted               ;if we swapped smth jump back in the sorted loop
                jae exitt               ;exit if we finished everything
            swap:            ;swap the 2 elements
                mov [R + esi - 1], ah   
                mov [R + esi], al
                mov cl, 0               ;check that we sorted smth
                cmp esi, len-1          ;check if we finished the loop
                jb sort                 ;jump back to the sort loop if we didn t finish it
                jae sorted              ;jump back to the sorted loop if we finished the for
        exitt:
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
