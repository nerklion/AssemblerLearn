.8086
code SEGMENT para USE16 PUBLIC 'code'
    ASSUME CS:code, DS:data, SS:stack
    START:
        mov ax, data
        mov ds, ax
        
        mov ax, fnum  
        mov bx, snum
        push ax     
        push bx        
        call sum  
        mov rnum, ax
        mov cx, ax
        pop ax    
        
        int 20h
        
        sum proc
            push bp
            mov bp, sp
            sub sp, 4
            mov ax, [bp+4]
            mov bx, [bp+6]
            add ax, bx 
            mov sp, bp
            pop bp          
            retn 4
        sum endp  
code ends
data SEGMENT para USE16 PUBLIC 'data'
    fnum dw 5    
    snum dw 2  
    rnum dw ?
data ends
stack SEGMENT para USE16 STACK 'stack'       
    dw 256 DUP(?)
stack ends
end START