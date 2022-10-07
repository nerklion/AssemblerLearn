.8086                                     ; Processor model
code SEGMENT para USE16 PUBLIC 'code'     ; Defining code segment and its parameters
    ASSUME CS:code, DS:data, SS:stack     ; Defining code segment to CS register, etc
    START:                                ; Start code
        mov ax, data                      ; Move vars from data segment to ax segment
        mov ds, ax                        ; Move vars from ax to ds segment (cant do it directly)
        mov ah, 9h                        ; Call interrupt 9h - print to screen
        mov dx, offset message            ; Print message to console (move it to dx)
        int 21h                           ; Stop printing & Return pc control to OS
        mov ax, 4C00h                      
        int 21h                           
code ends                                 ; Code segment ends
data SEGMENT para USE16 PUBLIC 'data'     ; Defining data segment and its parameters 
    message db 'Hellow, World!$'          ; Create variable message, give byte for each symbol, $ - shows to OS last synbol, variable's address - first byte
data ends                                 ; Data segment ends
stack SEGMENT para USE16 STACK 'stack'    ; Defining stack segment and its parameters  
    db 256 DUP(?)                         ; Reserve 256 bytes for program & vars
stack ends                                ; Stack segment ends
end START                                 ; Programm ends