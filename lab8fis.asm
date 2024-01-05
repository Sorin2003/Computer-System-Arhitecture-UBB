bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all the special characters from the given text with the character 'X'. Create a ;file with the given name and write the generated text to file.
    ; ...
   text dw "Asta este % balta $",0
   ;text dw "da  merge *acest %cod &", 0
   len equ $-text-3
   write times len dw 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        cmp esi, len
        mov cl, 'X'
        xor esi, esi
        read:
            mov al, [text + esi] ;moves every caracter in al
            cmp al, 'A'              
            jb special               ;if it is smaller then 'A' it s clearly a special caracter and goes to special
            jae verifyc              ;if it is greater or equal to 'A' verify if it is a capital letter or smth else
        
    special:                         ;if the code jumps here, then we write an X instead of the caracter
        mov [write + esi], cl       
        inc esi
        cmp esi, len
        jb read
        jae exit
    verifyc:
        cmp al, 'Z'
        jbe writel
        ja verifyl
    verifyl:
        cmp al, 'a'
        jb special
        jae verifyli
    
    verifyli:
        cmp al,'z'
        jbe writel
        ja special
        
    writel:
        mov [write + esi], al
            inc esi
            cmp esi, len
            jb read
            jae exit
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
