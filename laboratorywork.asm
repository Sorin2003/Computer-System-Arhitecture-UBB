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
      ;find the pozition of e in a string of doublewords
      s dd 1,2,11,3,11,4,5,11
      e dd 100 ; 2,4,7
      l equ ($-s)/4
      d times l db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, l
        mov edi, s
        mov esi, d 
        mov eax, [e]
        jecxz end_loop
        mov bl, 0
        repeat:
            scasd ; cmp eax,[edi];edi+1
            jne next
            mov [esi],bl
            inc esi
        next:
        inc bl
        loop repeat
        end_pr:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
