bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
extern scanf                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
extern printf
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    scan_msg db "%d", 0
    a dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;movs - move string -movsb/movsw/movsd - byte/word/double [esi] -> edi
        ;cmps - compare string - b/w/d - compare [esi] = ! = [edi]
        ;loads - load string -b/w/d <- al <- [esi] / ax <- [esi]/ eax <- [esi]
        ;stos - store string -b/w/d    al -> [esi], etc
        ;scas - scan string -b/w/d cmp al,[edi], etc
        push dword a
        push dword scan_msg
        call [scanf]
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
