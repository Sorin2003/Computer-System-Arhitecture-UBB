bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
extern printf
extern scanf
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;Read two numbers a and b (in base 10) from the keyboard and calculate a+b. Display the result in base 16
    a dd  0       ; defining the variable a
    b dd  0
	format  db "%d", 0  ; definining the format
    formath db "%x", 0  ; format hexa
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]       ; calling the scanf function for reading
		add esp, 4 * 2     ; cleaning the parameters from the stack
        push dword b       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]       ; calling the scanf function for reading
		add esp, 4 * 2     ; cleaning the parameters from the stack
        mov eax, [a]
        add eax, [b]
        push eax
		push dword format  
		call [printf]       ; calling the printf function
		add esp, 4 * 2    ; cleaning the parameters from the stack
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
