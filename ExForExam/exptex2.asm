bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A text file is given. Read the content of the file, count the number of even digits and display the result on the screen. The name of text file is defined in the data segment.
    file_name db "ex3.txt", 0
    access_mode db "r", 0
    
    file_descriptor dd -1
    len equ 100
    digits times (len+1) db 0
    
    format db "In the file there are %d even digits.", 0

; our code starts here
segment code use32 class=code
    start:
      
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final
        
        ; read the text from file using fread()
        ; after the fread() call, EAX will contain the number of chars we've read 
        ; eax = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword digits
        call [fread]
        add esp, 4 * 4
        
        ; Go through the digits array and count the even ones.
        mov ecx, len
        mov esi, digits
        mov ebx, 0
        cld
        
        jecxz close
        repeta:
            lodsb ; load byte in al
            sub al, '0' ; convert ascii to number
            shr al, 1 ; the last bit, is a parity bit, shift to the right and load it in the carry flag
            jb inc_ebx
            jmp next_iter
            
            inc_ebx:
                inc ebx
        
        next_iter:
        loop repeta
       
       ; printf(format, ebx)
        push ebx
        push format
        call [printf]
        add esp, 4 * 2
        
        
    close:
        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program