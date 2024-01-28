bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;  a,b,c-byte; e-doubleword , i assumed that x is a qw like evrywhere else
    ;unsigned
    a db 16
    b db 18
    c db 20
    e dd 89
    x dq 1989

; our code starts here
segment code use32 class=code
    start:
        ; x-(a*b*25+c*3)/(a+b)+e;
        mov al, byte[a]
        mov dl, byte[b]
        mul dl           ;ax <- al*dl = a*b
        mov dx, 25
        mul dx           ;dx:ax <- ax*dx = a*b*25
        push dx
        push ax
        xor eax,eax      ;eax = 0
        pop eax          ;eax <- dx:ax
        mov ebx,eax      ;ebx = eax = a*b*25
        xor eax, eax     ;eax = 0 so we can use it all later
        mov al, byte[c]
        mov dl, 3
        mul dl         ;ax <- al*dl = c*3
        add ebx, eax    ;ebx = a*b*25+c*3
        mov ecx, ebx    ;ecx = ebx =a*b*25+c*3
        xor eax, eax     ;eax = 0 so we can use it later
        mov al, byte[a]
        add al, byte[b] ;al = a+b
                        ;eax = a+b
        mov ebx, eax    ;ebx = eax = a+b
        mov eax, ecx    ;eax = ecx = a*b*25+c*3
        xor edx,edx     ;edx = 0 so we can use it later for edx:eax <- eax
        div ebx        ;eax = (a*b*25+c*3)/(a+b)    edx = (a*b*25+c*3)%(a+b)
        ;I will not use the fractional part so I will only use eax
        xor edx, edx    ;edx = 0 so i can use it later
                        ;edx:eax <- eax
        mov ebx, dword[x+0]
        mov ecx, dword[x+4] ;ecx:ebx <- x
        sub ebx, eax
        sub ecx,edx     ;ecx:ebx = ecx:ebx - edx:eax = x - edx:eax
        mov eax, dword[e]
        xor edx,edx     ;edx = 0 so i can use it later
        add ebx, eax
        add ecx, edx    ;ecx:ebx = ecx:ebx + edx:eax = ecx:ebx + e
        mov eax, ebx
        mov edx, ecx    ;edx:eax = x-(a*b*25+c*3)/(a+b)+e
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
