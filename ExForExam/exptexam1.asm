bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fprintf, fclose           
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fprintf msvcrt.dll 
import fclose msvcrt.dll 
import exit msvcrt.dll 

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
  filein db 'in.txt', 0
  fileout db 'out.txt', 0
  formatn db '%u', 0
  formatl db '%c', 0
  modew    db 'w', 0
  moder    db 'r' , 0
  smth resb 101
  len equ 100
  file1 dd 0
  file2 dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword moder       ;open the in file
        push dword filein
        call [fopen]
        add esp, 4 * 2
        mov [file1], eax    ;copy the desc into smth that we don t override ecx in
        cmp eax, 0
        je exit
        push dword modew       ;open the out file
        push dword fileout 
        call [fopen]
        add esp, 4 * 2
        mov [file2], eax   ;ctdistwdo edx out
        cmp eax, 0
        je exit
        read:
            push dword smth   ;where we save what we read
            push dword len
            push dword 1
            push dword file1
            call [fread]
            add esp, 4 * 4
            cmp eax, 0
            je close
            mov esi, smth
        repeta:
            lodsb
            cmp al, 'A'
            jae checkcap
        checkcap:
            cmp al, 'Z'
            ja wsml
            jbe wbig
        wsml:
            push dword eax
            push dword formatn
            push file2
            call [fprintf]
            add esp, 4 * 3
            loop repeta
        wbig:
            push dword eax
            push dword formatl
            push file2
            call [fprintf]
            add esp, 4 * 3
            loop repeta
        jmp read
        close:
            push file1
            call [fclose]
            add esp, 4
            push file2
            call [fclose]
            add esp, 4
        
        
        
            
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
