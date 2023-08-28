---
title: 王爽汇编语言实验代码
layout: post
author: runphp
date: '2010-11-16 21:43:00 +0800'
category: other
tags: assembly 王爽 汇编语言
toc: true
---

## 实验4 [bx]和loop的使用
```asm
assume cs: codesg
codesg segment
     
    mov ax, 20h  ;   20:0 到 20:3f
    mov ds, ax
 
    mov bx, 0
    mov cx, 64   ;    循环64次
 
s:  mov [bx], bl  ;  ((ds)*16+ bx) = (bl) = ( 0 到 63)
    inc bl
    loop s
 
    mov ax, 4c00H
    int 21H
 
codesg ends
 
end 

```

## 实验5 编写、调试具有多个段的程序

（5）
```asm
assume cs: code
 
a segment
    db 1,2,3,4,5,6,7,8
a ends
 
b segment
    db 1,2,3,4,5,6,7,8
b ends
 
c segment
    db 0,0,0,0,0,0,0,0
c ends
 
code segment
    start:
    mov ax, c
    mov ds, ax
 
    mov ax, b
    mov es, ax
 
    mov bx, 0
    mov cx, 4
;;;;;;;;;;;;;;;;;;;;c = b
    s:
    mov ax, es:[bx]
    mov [bx], ax
    add bx, 2
    loop s
 
    mov ax, a
    mov es, ax
    mov bx, 0
    mov cx, 4
;;;;;;;;;;;;;;;;;;;;c = c + a
    s1:
    mov ax, es:[bx]
    add [bx], ax
    add bx, 2
    loop s1
 
    mov ax,4c00H
    int 21H
code ends
 
end start 
```

（6）
```asm
assume cs: code
 
a segment
    dw 1,2,3,4,5,6,7,8
a ends
 
b segment
    dw 0,0,0,0,0,0,0,0
b ends
 
code segment
    start:
    mov ax, a
    mov ds, ax
 
    mov ax, b
    mov ss, ax
    mov sp, 10H
     
    mov cx, 8
    s:
    push  [bx]
    add bx, 2
    loop s
 
    mov ax,4c00H
    int 21H
code ends
 
end start 
```

## 实验6 实践课程中的程序

（2）
```asm
assume cs:code, ds:data
stack segment
    dw 0,0,0,0,0,0,0,0
stack ends
data segment
    ;;;'0123456789abcdef'
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends
 
code segment
    start: 
        ;初始 ss sp and ds
        mov ax, stack
        mov ss, ax
        mov sp,10H
        mov ax, data
        mov ds, ax 
 
        ;下一行：bx+=16,
        ;下一个：cx-- 
        mov bx, 0
        mov cx, 4
    s:  
         
        push cx  ;备份cx
        mov si, 0
        mov cx, 4
        s1:
            mov al, [bx+si+3]
            and al, 11011111b
            mov [bx+si+3], al
            inc si
        loop s1   
        add bx, 16
         
        pop cx   ;恢复cx
    loop s
    mov ax, 4c00h
    int 21h
code ends
 
end start 
```

### 实验7 寻址方式在结构化数据访问中的应用
```asm
assume cs:code
data segment
    ; 以下是表示21年的21个字符串    
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'
    ; 以下是表示21年公司总收入的21个DWORD型数据
    dd 16, 22, 382, 1356, 2390, 8000, 16000, 2446, 50065, 97479, 140417, 197514 
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000 
    ; 以下是表示21年公司雇员人数的21个word型数据  
    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226 
    dw 11542, 14430, 15257, 17800 
data ends
 
table segment
    ;;;;;;;;;;;'0123456789ABCDEF'
    db 21 dup ('year summ ne ?? ')
table ends
 
code segment
    start:
        mov ax, table
        mov ds, ax
 
        mov ax, data
        mov es, ax
 
        mov si, 0
        mov di, 0
        mov bx, 0
        mov cx, 21
        s:
            ;table.年份 = [bx].0h
            ;4字节
            mov ax, es:0[si]
            mov [bx].0h, ax
            mov ax, es:2[si]
            mov [bx].2h, ax
 
            ;table.收入 = [bx].5h
            ;4字节
            mov ax, es:84[si]
            mov [bx].5h, ax
            mov ax, es:86[si]
            mov [bx].7h, ax
 
            ;table.雇员数 = [bx].0ah
            ;2字节
            mov ax, es:168[di]
            mov [bx].0ah, ax
 
            ;table.人均收入 = table.收入 / table.雇员数
            ;2字节
            mov ax, [bx].5h
            mov dx, [bx].7h
            div word ptr [bx].0ah
            mov [bx].0dh, ax
             
            add si, 4
            add di, 2
            add bx, 10h
        loop s
    mov ax, 4c00h
    int 21h
code ends
end start 
```

## 实验9 根据材料编程
```asm
assume cs:code, ss:stack, ds:data
 
stack segment
    dw 8 dup(0)
stack ends
 
data segment
    db 'Welcome to masm!'
    ;绿色，绿底红色，白底蓝色
    db 02h,24h,71h
     
data ends
 
code segment
start:
    mov ax, stack
    mov ss, ax
    mov sp, 10h
 
    mov ax, data
    mov es, ax
 
    mov ax, 0B878h ;12行段地址
    mov di, 10h ;第一个颜色偏移地址
    mov cx, 3
s:
    ;备份ax和cx
    push ax
    push cx
 
    mov ds, ax
    mov bx, 0
    mov si, 0
    mov cx, 10h
 
    s1:
        mov al, es:[bx]
        mov [si].32h, al ;ascii
        mov al, es:[di]
        mov [si].33h, al ;color
        inc bx
        add si, 2
        loop s1
 
    inc di ;下一个颜色
    ;恢复ax和cx
    pop cx 
    pop ax
    
    add ax, 0ah  ;下一行
    loop s
 
    mov ax, 4c00h
    int 21h
code ends
end start 
```

## 实验10 编写子程序

1. 显示字符串

```asm
assume cs:code
 
data segment
        db 'Welcome to masm!', 0
data ends
 
code segment
start: 
       mov dh, 8
       mov dl, 3
       mov cl, 2
       mov ax, data
       mov ds, ax
       mov si, 0
     
       call show_str
       mov ax, 4c00h
       int 21h
 
;参数:(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;     (cl)=颜色,ds:si指向字符串的首地址
;返回:无
show_str: push si        ;保存寄存器
          push cx
 
          mov al, 0ah
          mul dh
          add ax, 0b800h
          mov es, ax      ;得到行
 
          mov al, 2
          mul dl
          mov di, ax      ;得到列
 
          mov ch, 0       ;
          mov ah, cl      ;(ah) = 颜色
 
        show_char: 
          mov al, [si]    ;(al)= 字符
          mov cl, al      ;保存字符到cl
          jcxz ok         ;遇到结束符(0),跳出
          mov es:[di], ax ;显示一个带颜色的字符
          inc si          ;data segment下一个字符
          add di, 2       ;显示缓冲区下一个位置(占2字符)
          jmp short show_char
 
    ok: pop cx            ;恢复寄存器
        pop si
        ret
code ends
 
end start 
```

2. 解决除法溢出的问题

```asm
assume cs:code
code segment
    start:
    mov ax, 4240h
    mov dx, 000fh
    mov cx, 0ah
     
    call divdw
    mov ax, 4c00h
    int 21h
;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型
;参数：（ax）= dword型数据的低16位
;      （dx）= dword型数据的高16位
;      （cx）= 除数
;返回：（dx）= 结果的高16位，（ax）= 结果的低16位
;      （cx）= 余数
divdw:
    ;(dx)/(cx)
    push ax
    mov ax, dx 
    mov dx, 0
    div cx    
    mov bx, ax ;高16商
 
    ;(ax)/(cx)
    pop ax     ;dx中已经保存了余数,即:(dx)%(cx)
    div cx
    mov cx, dx ;返回余数cx
    add dx, bx ;
    ret
 
code ends
end start  
```

3. 数值显示

```asm
assume cs:code
data segment
    db 10 dup(0)
data ends
code segment
start:
    mov ax, 12666
    mov bx, data
    mov ds, bx
    mov si, 0
     
    call dtoc
 
    mov dh, 8
    mov dl, 3
    mov cl, 2
    call show_str
 
    mov ax, 4c00h
    int 21h
;功能：将word型数据转变为表示十进制数的字符串，字符串以0为结束符。
;参数：（ax）= word型数据
;      ds:si指向字符串的首地址
;返回：无
dtoc: add si, 8           ;word型最大只有65535=0xffff
      dtoc_s: mov cx, ax
              jcxz ok
              mov dx, 0   ;(dx) = 0
              mov bx, 10  
              div bx      ;(dx)*10000h+(ax)/(bx) = (ax)/(bx)
              add dl, 30h ;word -> ascii
              mov [si], dl;类似压入堆栈一个字节
              dec si
      jmp short dtoc_s  
      ok: inc si
          ret
 
;功能：在指定的位置用指定的颜色显示一个用0结束的字符串。
;参数:(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;     (cl)=颜色,ds:si指向字符串的首地址
;返回:无
show_str: push si        ;保存寄存器
          push cx
 
          mov al, 0ah
          mul dh
          add ax, 0b800h
          mov es, ax      ;得到行
 
          mov al, 2
          mul dl
          mov di, ax      ;得到列
 
          mov ch, 0       ;
          mov ah, cl      ;(ah) = 颜色
 
        show_char: 
          mov al, [si]    ;(al)= 字符
          mov cl, al      ;保存字符到cl
          jcxz okk         ;遇到结束符(0),跳出
          mov es:[di], ax ;显示一个带颜色的字符
          inc si          ;data segment下一个字符
          add di, 2       ;显示缓冲区下一个位置(占2字符)
          jmp short show_char
 
    okk: pop cx            ;恢复寄存器
        pop si
        ret 
 
code ends
end start 
```

## 课程设计 1

```asm
assume cs:code
data segment
    db 16 dup(0)
data ends
 
poweridea segment
    ; 以下是表示21年的21个字符串
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'
    ; 以下是表示21年公司总收入的21个DWORD型数据
    dd 16, 22, 382, 1356, 2390, 8000, 16000, 2446, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
    ; 以下是表示21年公司雇员人数的21个word型数据
    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
poweridea ends
 
table segment
    ;;;;;;;;;;;'0123456789ABCDEF'
    db 21 dup ('year summ ne ?? ')
table ends
 
code segment
start:
    call poweridea2table
 
    mov bx, 0h
    mov cx, 21
    mov dh, 0
bwf:
    push cx
    mov dl, 8
    mov cl, 2
 
    call showyear
    mov dl, 18
    call showsum
    mov dl, 28
    call shownum
    mov dl, 38
    call showaverage
 
    add bx, 10h
    inc dh
    pop cx
    loop bwf
 
    mov ax, 4c00h
    int 21h
;功能：将dword型数据转变为表示十进制数的字符串，字符串以0为结束符。
;参数：（ax）= dword型数据的低16位
;      （dx）= dword型数据的高16位
;返回： ds:si指向字符串的首地址
dwtoc: add si, 14           ;word型最大只有4294967295=0xffffffff
        push cx
        push ax
        push dx
      dwtoc_s: mov cx, ax
              add cx, dx
              jcxz ok
              mov cx, 10
              call divdw
              add cl, 30h ;word -> ascii
              mov [si], cl;类似压入堆栈一个字节
              dec si
      jmp short dwtoc_s
      ok: inc si
            pop dx
            pop ax
            pop cx
          ret
 
;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型
;参数：（ax）= dword型数据的低16位
;      （dx）= dword型数据的高16位
;      （cx）= 除数
;返回：（dx）= 结果的高16位，（ax）= 结果的低16位
;      （cx）= 余数
divdw:
    ;(dx)/(cx)
    push bx
    push ax
    mov ax, dx
    mov dx, 0
    div cx
    mov bx, ax ;高16商
 
    ;(ax)/(cx)
    pop ax     ;dx中已经保存了余数,即:(dx)%(cx)
    div cx
    mov cx, dx ;返回余数cx
    mov dx, bx ;
    pop bx
    ret
 
;功能：在指定的位置用指定的颜色显示一个用0结束的字符串。
;参数:(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;     (cl)=颜色,ds:si指向字符串的首地址
;返回:无
show_str: push si        ;保存寄存器
          push cx
 
          mov al, 0ah
          mul dh
          add ax, 0b800h
          mov es, ax      ;得到行
 
          mov al, 2
          mul dl
          mov di, ax      ;得到列
 
          mov ch, 0       ;
          mov ah, cl      ;(ah) = 颜色
 
        show_char:
          mov al, [si]    ;(al)= 字符
          mov cl, al      ;保存字符到cl
          jcxz okk         ;遇到结束符(0),跳出
          mov es:[di], ax ;显示一个带颜色的字符
          inc si          ;data segment下一个字符
          add di, 2       ;显示缓冲区下一个位置(占2字符)
          jmp short show_char
 
    okk: pop cx            ;恢复寄存器
        pop si
        ret
 
;功能：把poweridea公司的数据转换为table格式
;参数：无
;返回：无
poweridea2table:
        mov ax, table
        mov ds, ax
 
        mov ax, poweridea
        mov es, ax
 
        mov si, 0
        mov di, 0
        mov bx, 0
        mov cx, 21
        s:
            ;table.年份 = [bx].0h
            ;4字节
            mov ax, es:0[si]
            mov [bx].0h, ax
            mov ax, es:2[si]
            mov [bx].2h, ax
 
            ;table.收入 = [bx].5h
            ;4字节
            mov ax, es:84[si]
            mov [bx].5h, ax
            mov ax, es:86[si]
            mov [bx].7h, ax
 
            ;table.雇员数 = [bx].0ah
            ;2字节
            mov ax, es:168[di]
            mov [bx].0ah, ax
 
            ;table.人均收入 = table.收入 / table.雇员数
            ;2字节
            mov ax, [bx].5h
            mov dx, [bx].7h
            div word ptr [bx].0ah
            mov [bx].0dh, ax
 
            add si, 4
            add di, 2
            add bx, 10h
        loop s
 
ret
 
;在指定的位置用指定的颜色显示年份。
;参数：(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;      (cl)=颜色,bx指向第几条记录
;返回：无
showyear:
    mov ax, data
    mov ds, ax
    mov ax, table
    mov es, ax
 
    mov ax, es:[bx].0
    mov ds:0, ax
    mov ax, es:[bx].2
    mov ds:2, ax
    mov si,0
    call show_str
ret
 
;在指定的位置用指定的颜色显示公司总收入。
;参数：(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;      (cl)=颜色,bx指向第几条记录
;返回：无
showsum:
    push dx
    mov ax, table
    mov es, ax
    mov ax, data
    mov ds, ax
    mov ax, es:[bx].5
    mov dx, es:[bx].7
    mov si, 0
    call dwtoc
    pop dx
    call show_str
ret
 
;在指定的位置用指定的颜色显示公司雇员人数。
;参数：(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;      (cl)=颜色,bx指向第几条记录
;返回：无
shownum:
    push dx
    mov ax, table
    mov es, ax
    mov ax, data
    mov ds, ax
    mov ax, es:[bx].0ah
    mov dx, 0
    mov si, 0
    call dwtoc
    pop dx
    call show_str
ret
 
;在指定的位置用指定的颜色显示公司雇员人均收入。
;参数：(dh)=行号(取值范围0~24),(dl)=列号(取值范围0~79),
;      (cl)=颜色,bx指向第几条记录
;返回：无
showaverage:
    push dx
    mov ax, table
    mov es, ax
    mov ax, data
    mov ds, ax
    mov ax, es:[bx].0dh
    mov dx, 0
    mov si, 0
    call dwtoc
    pop dx
    call show_str
ret
code ends
end start
```

## 实验11 编写子程序

```asm
assume cs:code
data segment
    db "{Beginner's All-purpose Symbolic Instruction Code.}", 0
data ends
code segment
    start:  mov ax, data
            mov ds, ax
            mov si, 0
            call letterc
            mov ax, 4c00h
            int 21h
 
;名称：letterc
;功能：将以0结尾的字符串的小写字母转变成大写字母
;参数：ds:si指向字符串首地址
;返回：无
letterc: cmp byte ptr [si], 0
         je ok
         cmp byte ptr [si], 61h
         jb s0
         cmp byte ptr [si], 7ah
         ja s0
         and byte ptr [si], 11011111b
     s0: inc si
         jmp short letterc
     ok: ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
code ends   
end start 
```

## 实验12 编写0号中断的处理程序

```asm
assume cs:code
code segment
start: 
;;;;;;;;do0安装程序;;;;;;;;;;;;;;;;;;;;;;;
        mov ax, cs
        mov ds, ax
        mov si, offset do0                  ;设置ds:si指向源地址
        mov ax, 0
        mov es, ax
        mov di, 200h                        ;设置es:di指向目的地址
 
        mov cx, offset do0end - offset do0  ;设置cx传输长度
        cld
        rep movsb
;;;;;;;;设置中断向量表;;;;;;;;;;;;;;;;;;;;;
        mov ax, 0
        mov es, ax
        mov word ptr es:[0*4], 200h
        mov word ptr es:[0*4+2], 0
         
        mov ax, 4c00h
        int 21h
;;;;;;;;显示overflow;;;;;;;;;;;;;;;;;;;;;;;
do0:        jmp short do0start
            db "Divide error!"
do0start:   mov ax, cs
            mov ds, ax
            mov si, 202h                     ;设置ds:si指向字符串
 
            mov ax, 0b800h
            mov es, ax
            mov di, 12 * 160 + 27 * 2        ;设置es:di指向显存空间的中间位置
            mov cx, offset do0start - offset do0 - 2
             
s:          mov al, [si]
            mov es:[di], al
            mov al, 11111100b           
            mov es:[di+1], al
            inc si
            add di, 2
            loop s
            mov ax, 4c00h
            int 21h
do0end: nop
 
code ends
end start
 
测试代码3.asm
assume cs:code
code segment
start: 
        mov bl, 0
        div bl
 
        mov ax, 4c00h
        int 21h
code ends
end start 
```

## 实验13 编写、应用中断例程

(1)
```asm
assume cs:code
code segment
start:  mov ax, cs
        mov ds, ax
        mov si, offset lp
        mov ax, 0
        mov es, ax
        mov di, 200h
        mov cx, offset lpend - offset lp
        cld
        rep movsb
         
        mov word ptr es:[7ch*4], 200h
        mov word ptr es:[7ch*4+2], 0
        mov ax, 4c00h
        int 21h   
 
;功能：显示一个用0结束的字符串
;参数：(dh) = 行号，(dl) = 列号，(cl) = 颜色，ds:si指向字符串首地址
lp:     push ax
        push di
        push si
 
        mov ax, 0b800h
        mov es, ax
 
        mov al, 160
        mul dh
        mov di, ax
        mov al, 2
        mul dl
        add di, ax
 
        mov al, cl    ;保存颜色
lp0:    mov cx, [si]
        jcxz ok
        mov es:[di], cl
        mov es:[di+1], al
        inc si
        add di, 2
        jmp short lp0
 
ok:     pop si
        pop di
        pop ax
        iret
lpend:  nop
 
code ends
end start 
```

(2)

```asm
assume cs:code
code segment
start:  mov ax, cs
        mov ds, ax
        mov si, offset lp
        mov ax, 0
        mov es, ax
        mov di, 200h
        mov cx, offset lpend - offset lp
        cld
        rep movsb
         
        mov ax, 0
        mov es, ax
        mov word ptr es:[7ch*4], 200h
        mov word ptr es:[7ch*4+2], 0h
         
        mov ax, 4c00h
        int 21h
lp:     push bp
        mov bp, sp
        dec cx
        jcxz ok
        add [bp+2], bx
ok:     pop bp
        iret
lpend: nop
code ends
end start 
```

(3)
```asm
assume cs:code
code segment
s1: db 'Good, better, best,' , '$'
s2: db 'Never let it rest,'  , '$'
s3: db 'Till good is better,', '$'
s4: db 'And better, best.'   , '$'
s:  dw offset s1, offset s2, offset s3, offset s4
row:db 2, 4, 6, 8
start:  mov ax, cs
        mov ds, ax
        mov bx, offset s
        mov si, offset row
        mov cx, 4
ok:     mov bh, 0    ;页
        mov dh, [si] ;行
        mov dl, 0    ;列
        mov ah, 2    ;置光标
        int 10h      ;bios中断例程
 
        mov dx, [bx] ;字符串位置 ds:dx
        mov ah, 9    ;光标位置显示字符串
        int 21h      ;dos中断例程
        inc si
        add bx, 2
        loop ok
 
        mov ax, 4c00h
        int 21h        
code ends
end start 
```

## 检测点14.2

```asm
assume cs:code
code segment
start:  mov ax, 2
 
        mov bx, ax
        shl ax, 1  ;(ax)*2
        mov cl, 3
        shl bx, cl ;(ax)*8
        add ax, bx ;(ax)*2 + (ax)*8
 
        mov ax, 4c00h
        int 21h        
code ends
end start 
```

## 实验14 访问CMOS RAM
```asm
assume cs:code
data segment
    db 9, '/', 8, '/', 7, ' ', 4, ':', 2, ':', 0
data ends
code segment
start:  mov ax, data
        mov ds, ax
        mov si, 0
        mov ax, 0b800h
        mov es, ax
         
        mov cx, 11
        mov di, 0
s:      push cx
        cmp byte ptr [si], 9
        mov al, [si]
        ja s0
        mov al, [si]
        out 70h, al
        in al, 71h
        mov ah, al
        mov cl, 4
        shr ah, cl
        and al, 00001111b
        add ax, 3030h                            ;转换为ascii
        mov byte ptr es:[160*12+40*2+di], ah     ;十位
        add di, 2
s0:     mov byte ptr es:[160*12+40*2+di], al     ;个位 或分隔符
        add si, 1
        add di, 2
        pop cx
        loop s
 
        mov ax, 4c00h
        int 21h        
code ends
end start 
```

## 实验15 安装新的int 9 中断例程

```asm
assume cs:code
stack segment
    db 128 dup(0)
stack ends
code segment
start:  mov ax, stack
        mov ss, ax
        mov sp, 128
     
        push cs
        pop ds
 
        mov ax, 0
        mov es, ax
         
        mov si, offset int9
        mov di, 204h
        mov cx, offset int9end - offset int9
        cld
        rep movsb
         
        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]
         
        cli
        mov word ptr es:[9*4], 204h
        mov word ptr es:[9*4+2], 0
        sti
        mov ax, 4c00h
        int 21h
int9:   push ax
        push bx
        push cx
        push es
         
        in al, 60h
         
        pushf
        call dword ptr cs:[200h]
         
        cmp al, 9eh ;A的断码
        jne int9ret
 
        mov ax, 0b800h
        mov es, ax
        mov bx, 0
        mov cx, 2000
s:      mov byte ptr es:[bx], 'A'
        add bx, 2
        loop s
int9ret:    pop es
            pop cx
            pop bx
            pop ax
            iret
int9end:    nop
code ends
end start 
```

## 实验16 编写包含多个功能子程序的中断例程

```asm
assume cs:code
stack segment
    db 128 dup(0)
stack ends
code segment
start:  mov ax, stack
        mov ss, ax
        mov sp, 128 
 
        mov ax, cs
        mov ds, ax
        mov si, offset setscreen
        mov ax, 0
        mov es, ax
        mov di, 200h
        mov cx, offset setscreenend - offset setscreen
        cld
        rep movsb
 
        mov ax, 0
        mov es, ax
        mov word ptr es:[7ch*4], 0h
        mov word ptr es:[7ch*4+2], 20h 
 
        mov ax, 4c00h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;屏幕设置
setscreen:  jmp short set           ;安装后这条语句地址是0020:0000，下一条0020:0002
table:     dw offset sub1 - offset setscreen, offset sub2 - offset setscreen, offset sub3 - offset setscreen, offset sub4 - offset setscreen
set:        push bx
            cmp ah, 3
            ja sret
            mov bl, ah
            mov bh, 0
            add bx, bx                  ;bx是偏移地址
            call word ptr cs:2h[bx]     ;即0020:(0002+bx)
sret:       pop bx
            iret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;清屏
sub1:   push bx
        push cx
        push es
        mov bx, 0b800h
        mov es, bx
        mov bx, 0
        mov cx, 2000
sub1s:  mov byte ptr es:[bx], ' '
        add bx, 2
        loop sub1s
        pop es
        pop cx
        pop bx
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;设置前景色
sub2:   push bx
        push cx
        push es
        mov bx, 0b800h
        mov es, bx
        mov bx, 1
        mov cx, 2000
sub2s:  and byte ptr es:[bx], 11111000b
        or es:[bx], al
        add bx, 2
        loop sub2s
        pop es
        pop cx
        pop bx
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;设置背景色
sub3:   push bx
        push cx
        push es
        mov cl, 4
        shl al, cl
        mov bx, 0b800h
        mov es, bx
        mov bx, 1
        mov cx, 2000
sub3s:  and byte ptr es:[bx], 10001111b
        or es:[bx], al
        add bx, 2
        loop sub3s
        pop es
        pop cx
        pop bx
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;向上滚动一行
sub4:   push cx
        push si
        push di
        push es
        push ds
 
        mov si, 0b800h
        mov es, si
        mov ds, si
        mov si, 160
        mov di, 0
        cld
        mov cx, 24
sub4s:  push cx
        mov cx, 160
        rep movsb
        pop cx
        loop sub4s
        mov cx, 80
        mov si, 0
sub4s1: mov byte ptr [160*24+si], ' '
        add si, 2
        loop sub4s1
        pop ds
        pop es
        pop di
        pop si
        pop cx
        ret
setscreenend: nop
code ends
end start 
```
附上测试代码：
```asm
assume cs:code
code segment
start:  mov ah, 1
        mov al, 010b
        int 7ch         ;调用1号子程序，设置前景色为绿色
        call delay
 
        mov ah, 2
        mov al, 001b    ;调用2号子程序，设置背景色为蓝色
        int 7ch
        call delay
 
        mov ah, 3
        int 7ch         ;调用3号子程序，上滚一行
        call delay
         
        mov ah, 3
        int 7ch         ;调用3号子程序，上滚一行
        call delay
 
        mov ax, 4c00h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
;暂停
delay:  push ax
        push dx
        mov dx, 4000h
        mov ax, 0
s1:     sub ax, 1
        sbb dx, 0
        cmp ax, 0
        jne s1
        cmp dx, 0
        jne s1
        pop dx
        pop ax
        ret
code ends
end start
```

## 字符串的输入

```asm
assume cs:code ds:data
data segment
    dd 128 dup(0)
data ends
code segment
start:  mov ax, data
        mov ds, ax
        mov dx, 0   ;0行0列
        call getstr 
        mov ax, 4c00h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getstr: push ax
getstrs:    mov ah, 0
            int 16h
            cmp al, 20h 
            jb nochar       ;ascii小于20h(sp)，说明不是字符
            mov ah, 0
            call charstack  ;字符入栈
            mov ah, 2
            call charstack  ;显示栈中的字符
            jmp getstrs
;控制符(退格和回车)
nochar: cmp ah, 0eh         ;退格键的扫描码
        je  backspace
        cmp ah, 1ch         ;回车键的扫描码
        je  enter
        jmp getstrs
;退格
backspace:  mov ah, 1
            call charstack  ;字符出栈
            mov ah, 2
            call charstack  ;显示栈中的字符
            jmp getstrs
;回车
enter:  mov al, 0
        mov ah, 0
        call charstack      ;0入栈
        mov ah, 2
        call charstack      ;显示栈中的字符
        pop ax
        ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;功能:  字符栈的入栈，出栈和显示
;参数:  (ah)=功能号，0表示入栈，1表示出栈，2表示显示；
;       ds:si指向字符栈空间；
;       对于0号功能：(al)=入栈字符；
;       对于1号功能：(al)=返回字符；
;       对于2号功能：(dh),(dl)=字符串在屏幕上显示的行，列位置。
charstack:  jmp short charstart
    table   dw charpush, charpop, charshow
    top     dw 0            ;栈顶
charstart:  push bx
            push dx
            push di
            push es
 
            cmp ah, 2
            ja  sret
            mov bl, ah
            mov bh, 0
            add bx, bx
            jmp word ptr table[bx]
;入栈
charpush:   mov bx, top
            mov [si][bx], al
            inc top
            jmp sret
;出栈
charpop:    cmp top, 0
            je sret
            dec top
            mov bx, top
            mov al, [si][bx]
            jmp sret
;显示
charshow:   mov bx, 0b800h
            mov es, bx
            mov al, 160
            mov ah, 0
            mul dh
            mov di, ax
            add dl, dl
            mov dh, 0
            add di, dx  ; (dh)*160 + (dl)+(dl)
 
            mov bx, 0
 
charshows:  cmp bx, top
            jne noempty
            mov byte ptr es:[di], ' '
            jmp sret
 
noempty:    mov al, [si][bx]
            mov es:[di], al
            mov byte ptr es:[di+2], ' '
            inc bx
            add di, 2
            jmp charshows
 
sret:       pop es
            pop di
            pop dx
            pop bx
            ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
code ends
end start 
```

## debug读取软盘0面0道1扇区到文件

(测试环境BOCHS + MS-DOS7.1)

书299页代码编译连接生成4.exe

下面用debug把0扇区写到文件4.txt
```
C:\ASMSTUDY>4.exe 运行后0扇区写入到了0:200开始的512b内存中
C:\ASMSTUDY>debug
-rcx
cx 0000
:1ff 此处是大小0到1ff就是200h即512b
-rcs
cs 0A7F
:10 段地址cs=10，ip=100，即从20:0开始
-n4.txt n为新建，4.txt为文件名
-w w即写入
Writing 001FF bytes
-_
完毕
```

### 实验17 编写包含多个功能子程序的中断例程
```asm
assume cs:code
data segment
    db 512 dup(0)
data ends
code segment
start:  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;安装int 7ch号中断例程
        mov ax, cs
        mov ds, ax
        mov si, offset rwfloppy
 
        mov ax, 0
        mov es, ax
        mov di, 200h
        mov cx, offset rwfloppyend - offset rwfloppy
        cld
        rep movsb
 
        mov word ptr es:[7ch*4], 200h
        mov word ptr es:[7ch*4+2], 0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;测试
        mov ax, data
        mov es, ax
        mov si, 0h
         
        mov di, 0
        mov cx, 2880    ;2880个扇区
s:
        mov ah, 0       ;读
        mov al, 1       ;读入扇区数
        mov dl, 0       ;软驱A
        mov bx, di      ;逻辑扇区号
        int 7ch
 
        mov ah, 1       ;写
        mov al, 1       ;写入扇区数
        mov dl, 1       ;软驱B
        mov bx, di      ;逻辑扇区号
        int 7ch
        inc di
        loop s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
        mov ax, 4c00h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;功能：使用逻辑扇区号读写软盘
;参数：(ah) = 0 表示读，1 表示写
;      (al) = 要读写的扇区数
;      (dl) = 驱动器号，0：软盘A，1：软盘B
;      (bx) = 要读写的逻辑扇区号
;      es:si 指向存储读出数据或写入数据的内存区
rwfloppy:   cmp ah, 1
            ja ok               ;大于1跳出
            push bx             ;保护bx
            push cx             ;保护cx
            push dx             ;保护dx
            add ah, 2           ;读或写：0+2 or 1+2
            push ax             ;保存写入的扇区数和功能号(al)和(ah)
            push dx             ;保存驱动器号(dl)
            mov ax, bx
            mov dx, 0       
            mov bx, 1440        
            div bx 
            mov bx, dx          ;(bx) = (bx)%1440
            pop dx              ;恢复驱动器号(dl)
            mov dh, al          ;面： (dh) = (bx)/1440 
            mov ax, bx
            mov bl, 18
            div bl
            mov ch, al          ;磁道号：(ch) = ((bx)%1440)/18
            mov cl, ah
            inc cl              ;扇区号：(cl) = ((bx)%1440)%18+1
            mov bx, si
            pop ax              
            int 13h             ;调用bios中断
            sub ah, 2           ;恢复ax
            pop dx              ;恢复dx
            pop cx              ;恢复cx
            pop bx              ;恢复bx
ok:         iret
         
rwfloppyend:    nop
code ends
end start 
```

## 课程设计2
```asm
;课程设计2 ( 0.1版)
;功能：此为安装程序，使得电脑可以从软盘A启动，启动后有以下功能
;      功能界面，F1键改变显示颜色
;      1键重启
;      2键从c盘启动
;      3显示时间，按ESC键返回
assume cs:code
data segment
    db 510 dup(0)
    dw 0aa55h
data ends
code segment
start:  call int7ch
        call copytoa0
        call copytoa1
        mov ax, 4c00h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;安装int 7ch号中断例程
int7ch:     mov ax, cs
            mov ds, ax
            mov si, offset rwfloppy
 
            mov ax, 0
            mov es, ax
            mov di, 200h
            mov cx, offset rwfloppyend - offset rwfloppy
            cld
            rep movsb
 
            mov word ptr es:[7ch*4], 200h
            mov word ptr es:[7ch*4+2], 0
            ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;功能：使用逻辑扇区号读写软盘
;参数：(ah) = 0 表示读，1 表示写
;      (al) = 要读写的扇区数
;      (dl) = 驱动器号，0：软盘A，1：软盘B
;      (bx) = 要读写的逻辑扇区号
;      es:si 指向存储读出数据或写入数据的内存区
rwfloppy:   push bx             ;保护bx
            push cx             ;保护cx
            push dx             ;保护dx
            add ah, 2           ;读或写：0+2 or 1+2
            push ax             ;保存写入的扇区数和功能号(al)和(ah)
            push dx             ;保存驱动器号(dl)
            mov ax, bx
            mov dx, 0       
            mov bx, 1440        
            div bx 
            mov bx, dx          ;(bx) = (bx)%1440
            pop dx              ;恢复驱动器号(dl)
            mov dh, al          ;面： (dh) = (bx)/1440 
            mov ax, bx
            mov bl, 18
            div bl
            mov ch, al          ;磁道号：(ch) = ((bx)%1440)/18
            mov cl, ah
            inc cl              ;扇区号：(cl) = ((bx)%1440)%18+1
            mov bx, si
            pop ax              
            int 13h             ;调用bios中断
            ;call debug
            sub ah, 2           ;恢复ax
            pop dx              ;恢复dx
            pop cx              ;恢复cx
            pop bx              ;恢复bx
            iret
rwfloppyend:    nop
 
copytoa0:
        mov ax, cs
        mov ds, ax
        mov si, offset asmedusystem
 
        mov ax, data
        mov es, ax
        mov di, 0
        mov cx, offset asmedusystemend - offset asmedusystem
        cld
        rep movsb        
 
        mov ax, data
        mov es, ax
        mov si, 0        
         
        mov ah, 1      ;写
        mov al, 1      ;写入扇区数
        mov dl, 0      ;软驱A
        mov bx, 0      ;逻辑扇区号
        int 7ch
 
        ret
;C盘引导区备份到软盘A的1号扇区
copytoa1:         
        mov ax, data 
        mov es, ax
        mov bx, 0   
        mov ah, 2       ;读磁盘
        mov al, 1       ;读取扇区数
        mov ch, 0       ;磁道号
        mov cl, 1       ;扇区号(逻辑0号)
        mov dh, 0       ;磁头号
        mov dl, 80h     ;驱动器号
        int 13h
 
 
        mov ax, data
        mov es, ax
        mov si, 0              
        mov ah, 1      ;写
        mov al, 1      ;写入扇区数
        mov dl, 0      ;软驱A
        mov bx, 1      ;逻辑扇区号
        int 7ch
 
        ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
org 7c00h
asmedusystem:
          call  init
       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;显示系统界面
init: jmp initstart
    table db '[1] reset pc',             0
          db '[2] start system',         0
          db '[3] clock',                0
          db '[4] set clock',            0
          
initstart:   call clear
             mov bh, 2   ;绿色
show:        mov bl, 4   ;6行字符
             call puts
             jmp short show
             ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
;显示时间
showtime:
        call clear
showtime_:        call clock
        in al, 60h
        cmp al, 1   ;按键esc
        je  init  ;重启
        jmp showtime_
        ret  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;显示以0结束的字符串
puts:   push ax
        mov ax, 0b800h 
        mov ds, ax
        mov si, 0
        mov di, 0
        mov ch, 0
puts_:  cmp bl, 0
        je short putsok
        mov cl, table[di]
        jcxz putsnext
        mov [si+50+160*10], cl
        push ax
 
        in al, 60h
        cmp al, 2   ;按键1
        je  resetpc  ;重启
        cmp al, 3   ;按键2
        je startdiskc ;c盘启动
        cmp al, 4   ;按键3
        je  showtime ;显示时间
        cmp al, 3bh ;按键F1
        jne nof1    ;改变颜色        
         
        inc bh
nof1:   mov [si+50+160*10+1], bh
        pop ax
        add si, 2
        inc di
        jmp short puts_
putsnext:  
           add ax, 0ah
           mov ds, ax
           dec bl
           inc di
           mov si, 0
           
           jmp short puts_
putsok: pop ax
        ret
       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;重新启动计算机
resetpc:  
    db 0eah, 0, 0, 0ffh, 0ffh ;jmp ffff:0000
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;引导现有的操作系统(引导C盘)
startdiskc:
       mov ax, cs
       mov ds, ax
       mov si, offset startdiskc_
 
       mov ax, 0
       mov es, ax
       mov di, 200h
       mov cx, offset startdiskcend_ - offset startdiskc_
       cld
       rep movsb
       db 0eah, 0, 2, 0, 0 ;jmp 0000:0200
 
startdiskc_:   mov ax, 0 
                mov es, ax
                mov bx, 7c00h   
                mov ah, 2       ;读磁盘
                mov al, 1       ;读取扇区数
                mov ch, 0       ;磁道号
                mov cl, 2       ;扇区号(1号逻辑)
                mov dh, 0       ;磁头号
                mov dl, 0       ;驱动器号
                int 13h
                db 0eah, 0, 7ch, 0, 0
startdiskcend_:        ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;
;清屏
clear:  push bx
        push cx
        push es
        mov bx, 0b800h
        mov es, bx
        mov bx, 0
        mov cx, 2000
clear_:  mov byte ptr es:[bx], ' '
        mov byte ptr es:[bx+1], 111b
        add bx, 2
        loop clear_
        pop es
        pop cx
        pop bx         
        ret
 
;;;;;;;;;;;;;;;;;;;;;
;clock
clock:  jmp clock_
    time db 9, '/', 8, '/', 7, ' ', 4, ':', 2, ':', 0 
clock_: mov si, 0
        mov ax, 0b800h
        mov es, ax
        mov cx, 11
        mov di, 0
s:      push cx
        cmp byte ptr time[si], 9
        mov al, time[si]
        ja s0
        mov al, time[si]
        out 70h, al
        in al, 71h
        mov ah, al
        mov cl, 4
        shr ah, cl
        and al, 00001111b
        add ax, 3030h                            ;转换为ascii
        mov byte ptr es:[160*12+30*2+di], ah     ;十位
        add di, 2
s0:     mov byte ptr es:[160*12+30*2+di], al     ;个位 或分隔符
        inc si
        add di, 2
        pop cx
        loop s 
         
        ret
 
asmedusystemend: nop
 
code ends
end start
```