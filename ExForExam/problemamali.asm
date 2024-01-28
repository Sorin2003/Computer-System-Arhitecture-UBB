bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fopen, fread, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll 
import fread msvcrt.dll      ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ; citesc un nume de fișier de la tastatura și sa modific din fișierul ala cifrele cu codul lor ascii și după sa afișez în alt fișier sirul schimbat 
    fis dd 0
    formats dd "%s", 0
    fout db 'out.txt', 0
    mode db 'r+'
    fisin dd 0
    fisout dd 0
    len equ 100
    rez times (len+1) db 0
    formatc db '%c', 0
    formatu db '%u', 0
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
         push dword mode
        push dword fout
        call [fopen]
        add esp, 4 * 2
        mov [fisout], eax
        cmp eax, 0
        je exit
        
        push dword fis
        push dword formats
        call [scanf]
        add esp, 4 * 2
        
        
        push dword mode
        push dword fis
        call [fopen]
        add esp, 4 * 2
        mov [fisin], eax
        cmp eax, 0
        je exit
        
        
        push dword [fisin]
        push dword len
        push dword 1
        push dword rez
        call [fread]
        add esp, 4 * 4
        mov esi, rez
        mov ecx, len
        
        repeta:
            lodsb
            cmp al, ''
            je close
            cmp al, '0'
            jae ver
            jb write
            
        ver:
            cmp al, '9'
            jbe writen
            ja write
            
        write:
            push dword eax
            push dword formatc
            push dword [fisout]
            call [fprintf]
            add esp, 4*3
            loop repeta
            
        writen:
            push dword eax
            push dword formatu
            push dword [fisout]
            call [fprintf]
            add esp, 4*3
            loop repeta
            
        close:
            push dword [fisout]
            call [fclose]
            add esp, 4
            push dword [fisin]
            call [fclose]
            add esp, 3
            
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
