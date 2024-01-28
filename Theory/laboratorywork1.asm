bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern fopen
import fopen msvcrt.dll
extern printf
import printf msvcrt.dll
extern fscanf
import fscanf msvcrt.dll
extern fclose 
import fclose msvcrt.dll
extern fprintf
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
a dd 0
f dd 0
g dd 0
filein db "a.txt",0
fileout db "b.txt", 0
format db "%d", 0
moder db "r",0
modem db "m", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;FILE * fopen(name, mode)
        ;int fprint (FILE*  id, char*format,...)
        ;int fscanf (FILE* ids, char*format,...)
        ;int fread (void*res, int size, int count, FILE*id)
        push moder
        push filein
        call [fopen]
        add esp, 4*2
        mov dword [f], eax
        push modem
        push fileout
        call [fopen]
        add esp, 4*2
        mov dword [g], eax
        push dword a
        push format
        push dword [f]
        call [fscanf]
        add esp, 4*3
        push dword [a]
        push format
        push dword [g]
        call [fprintf]
        add esp, 4*3
        push dword [f]
        call [fclose]
        add esp,4
        push dword [g]
        call [fclose]
        add esp, 4
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
