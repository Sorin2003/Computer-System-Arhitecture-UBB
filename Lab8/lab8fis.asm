bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all the special characters from the given text with the character 'X'. Create a ;file with the given name and write the generated text to file.
    ; ...
   ;text dw "Asta este % balta $",0
   text dw "da  merge *acest %cod &", 0
   ;text dw "da ", 0
   len equ $-text-3
   write times len dw 0
   filename db 'output.txt', 0
   mode     db 'w', 0
   format   db 's', 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov cl, 'X'
        xor esi, esi
        read:
            mov al, [text + esi] ;moves every caracter in al
            cmp al, 'A'              
            jb special               ;if it is smaller then 'A' it s clearly a special caracter and goes to special
            jae verifyc              ;if it is greater or equal to 'A' verify if it is a capital letter or smth else
        
    special:                         ;if the code jumps here, then we write an X instead of the caracter
        mov [write + esi], cl        ;put the special caracter into the res 
        inc esi
        cmp esi, len
        jb read
        jae file
    verifyc:                        ;verify if it is capital letter else verify if it is small letter
        cmp al, 'Z'
        jbe writel
        ja verifyl
    verifyl:                        ;verify if it is small letter
        cmp al, 'a'
        jb special
        jae verifyli
    
    verifyli:                       ;verify if it is small letter else write an x instead the special caracter
        cmp al,'z'
        jbe writel
        ja special
        
    writel:                         ;write letters
        mov [write + esi], al
            inc esi
            cmp esi, len
            jb read
            jae file
     
    file:
        push dword mode
        push dword filename
        call [fopen]
        add esp, 8      ;open
        mov ebx, eax

        push dword write
        ;push dword format
        push ebx
        call [fprintf]
        add esp, 8      ;write
        
        push ebx
        call [fclose]
        add esp, 4      ;close
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
