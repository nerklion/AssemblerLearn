.8086                                  ; Processor model 
code SEGMENT para USE16 PUBLIC 'code'  ; Defining code segment and its parameters
    ASSUME CS:code, DS:data, SS:stack  ; Defining code segment to CS register, etc
    START:                             ; Start code
        mov ax, data                   ; Move vars from data segment to ax segment
        mov ds, ax                     ; Move vars from ax to ds segment (cant do it directly)
                                       
        mov ax, fnum                   ; Move vars from data to ax and bx registers
        mov bx, snum                   
        push ax                        ; "Save" ax and bx in stack
        push bx                        
        call sum                       ; Call procedure sum
        mov rfnum, ax                  ; Save procedure's result to var rnum
        pop ax                         ; Remove ax & bx from stack
        pop bx
        
        mov ax, rfnum                  ; Move vars from data to ax and bx registers
        mov bx, snum                   
        push ax                        ; "Save" ax and bx in stack
        push bx                        
        call sum                       ; Call procedure sum
        mov rsnum, ax                  ; Save procedure's result to var rfnum
        pop ax                         ; Remove ax & bx from stack
        pop bx
        
        mov ax, rsnum                  ; Move vars from data to ax and bx registers
        mov bx, rfnum                  
        push ax                        ; "Save" ax and bx in stack
        push bx                        
        call min                       ; Call procedure min
        mov rsnum, ax                  ; Save procedure's result to var rsnum
        pop ax                         ; Remove ax & bx from stack  
        pop bx                         
                                       
        int 20h                        ; Return pc control to OS
                                       
        sum proc                       ; Define procedure "Sum"
            push bp                    ; "Save" bp to stack
            mov bp, sp                 ; bp to top of stack
            sub sp, 4                  ;
            mov ax, [bp+4]             ; Adress of return + offset
            mov bx, [bp+6]             
            add ax, bx                 ; Add ax to bx
            mov sp, bp                 ; Save result to sp 
            pop bp                     ; Remove bp from stack
            retn 4                     ; Return result 
        sum endp                       ; End procedure 
        
        min proc                       ; Define procedure "Min" 
            push bp                    ; "Save" bp to stack
            mov bp, sp                 ; bp to top of stack
            sub sp, 4                  ;
            mov ax, [bp+4]             ; Adress of return + offset
            mov bx, [bp+6]             
            sub ax, bx                 ; Minus from bx ax
            mov sp, bp                 ; Save result to sp 
            pop bp                     ; Remove bp from stack
            retn 4                     ; Return result 
        min endp                       ; End procedure 
        
        
code ends                              ; Code segment ends
data SEGMENT para USE16 PUBLIC 'data'  ; Defining data segment and its parameters
    fnum dw 5                          ; Define first var
    snum dw 2                          ; Define second var (first and second will be summed)
    rfnum dw ?                         ; Define first var for result 
    rsnum dw ?                         ; Define first var for result
data ends                              ; Data segment ends
stack SEGMENT para USE16 STACK 'stack' ; Defining stack segment and its parameters     
    dw 256 DUP(?)                      ; Reserve 256 bytes for program & vars
stack ends                             ; Stack segment ends
end START                              ; Programm ends         