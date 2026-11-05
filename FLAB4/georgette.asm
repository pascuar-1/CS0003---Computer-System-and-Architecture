

SYS_EXIT   equ 1

SYS_READ   equ 3

SYS_WRITE  equ 4

SYS_OPEN   equ 5

SYS_CLOSE  equ 6

STDIN      equ 0

STDOUT     equ 1

O_RDONLY   equ 0


O_WRITEFLG equ 0x1 | 0x40 | 0x200 | 0x400

FILEMODE   equ 0644q


%macro print 2

    push eax

    push ebx

    push ecx

    push edx

    mov eax, SYS_WRITE

    mov ebx, STDOUT

    mov ecx, %1

    mov edx, %2

    int 80h

    pop edx

    pop ecx

    pop ebx

    pop eax

%endmacro


%macro input 2

    push ebx

    push ecx

    push edx

    mov eax, SYS_READ

    mov ebx, STDIN

    mov ecx, %1

    mov edx, %2

    int 80h

    pop edx

    pop ecx

    pop ebx

%endmacro


%macro fwrite 2

    push eax

    push ebx

    push ecx

    push edx

    mov eax, SYS_WRITE

    mov ebx, [fileHandle]

    mov ecx, %1

    mov edx, %2

    int 80h

    pop edx

    pop ecx

    pop ebx

    pop eax

%endmacro


section .data

menuText    db 10

            db "====================================", 10

            db "         GEORGETTE EATERY", 10

            db "====================================", 10, 10

            db "A. Rice : Plain Rice          Php 5.00", 10

            db "B. Rice : Java Rice           Php 10.00", 10

            db "C. Ulam 1: Fish              Php 35.00", 10

            db "D. Ulam 2: Pork              Php 50.00", 10

            db "E. Ulam 3: Vegetables        Php 20.00", 10

            db "F. Dessert: Saging con yelo  Php 60.00", 10, 10

            db "Enter your choice [A-F]: "

menuLen     equ $ - menuText


plainRice       db "Plain Rice"

plainRiceLen    equ $ - plainRice

javaRice        db "Java Rice"

javaRiceLen     equ $ - javaRice

fish            db "Fish"

fishLen         equ $ - fish

pork            db "Pork"

porkLen         equ $ - pork

vegetables      db "Vegetables"

vegetablesLen   equ $ - vegetables

sagingConYelo   db "Saging con yelo"

sagingConYeloLen equ $ - sagingConYelo


pricePlainRice  db "Php 5.00", 10

pricePlainRiceLen equ $ - pricePlainRice

priceJavaRice   db "Php 10.00", 10

priceJavaRiceLen equ $ - priceJavaRice

priceFish       db "Php 35.00", 10

priceFishLen    equ $ - priceFish

pricePork       db "Php 50.00", 10

priceProkLen    equ $ - pricePork

priceVeg        db "Php 20.00", 10

priceVegLen     equ $ - priceVeg

priceSaging     db "Php 60.00", 10

priceSagingLen  equ $ - priceSaging


lineRice1   db "Plain Rice          Php 5.00", 10

lineRice1Len equ $ - lineRice1

lineRice2   db "Java Rice           Php 10.00", 10

lineRice2Len equ $ - lineRice2

lineFish    db "Fish                Php 35.00", 10

lineFishLen equ $ - lineFish

linePork    db "Pork                Php 50.00", 10

lineProkLen equ $ - linePork

lineVeg     db "Vegetables          Php 20.00", 10

lineVegLen  equ $ - lineVeg

lineSaging  db "Saging con yelo     Php 60.00", 10

lineSagingLen equ $ - lineSaging


itemTable:

    dd plainRice,     plainRiceLen,     pricePlainRice, pricePlainRiceLen, lineRice1,  lineRice1Len

    dd javaRice,      javaRiceLen,      priceJavaRice,  priceJavaRiceLen,  lineRice2,  lineRice2Len

    dd fish,          fishLen,          priceFish,      priceFishLen,      lineFish,   lineFishLen

    dd pork,          porkLen,          pricePork,      priceProkLen,      linePork,   lineProkLen

    dd vegetables,    vegetablesLen,    priceVeg,       priceVegLen,       lineVeg,    lineVegLen

    dd sagingConYelo, sagingConYeloLen, priceSaging,    priceSagingLen,    lineSaging, lineSagingLen

ITEM_SIZE equ 24


receiptFile db "receipt.txt", 0


msgInvalid  db 10, "Invalid choice!", 10, "Please try again.", 10

msgInvalidLen equ $ - msgInvalid

msgOrdered  db 10, "You ordered:", 10

msgOrderedLen equ $ - msgOrdered

msgNewline  db 10

msgNewlineLen equ $ - msgNewline

msgPrice    db "Price: "

msgPriceLen equ $ - msgPrice

msgAgain    db 10, "Do you want to order again? [Y/N]: "

msgAgainLen equ $ - msgAgain

msgYNBad    db "Please answer Y or N.", 10

msgYNBadLen equ $ - msgYNBad

msgThanks   db 10, "Thank you! Please come again!", 10

msgThanksLen equ $ - msgThanks

msgHeader   db 10, "====================================", 10

            db "         GEORGETTE EATERY", 10

            db "             RECEIPT", 10

            db "====================================", 10

msgHeaderLen equ $ - msgHeader

msgFooter   db "====================================", 10

msgFooterLen equ $ - msgFooter

msgOpenErr  db "Error: cannot open receipt.txt", 10

msgOpenErrLen equ $ - msgOpenErr


section .bss

fileHandle  resd 1

selIndex    resd 1

inBuf       resb 64

readBuf     resb 256


section .text

global _start

_start:


    mov eax, SYS_OPEN

    mov ebx, receiptFile

    mov ecx, O_WRITEFLG

    mov edx, FILEMODE

    int 80h

    test eax, eax

    js  open_failed

    mov [fileHandle], eax

order_loop:

    call displayMenu            

    call processOrder           

    test eax, eax

    jz  order_loop             

ask_again:

    print msgAgain, msgAgainLen

    input inBuf, 64

    cmp eax, 0

    jle do_exit                 

    mov al, [inBuf]

    cmp al, 'Y'

    je  order_loop

    cmp al, 'y'

    je  order_loop

    cmp al, 'N'

    je  do_exit

    cmp al, 'n'

    je  do_exit

    print msgYNBad, msgYNBadLen

    jmp ask_again

do_exit:

    call exitProgram            

open_failed:

    print msgOpenErr, msgOpenErrLen

    mov eax, SYS_EXIT

    mov ebx, 1

    int 80h



displayMenu:

    print menuText, menuLen

    ret


processOrder:

    push ebx

    push ecx

    push edx

    push esi

    input inBuf, 64

    cmp eax, 0

    jle po_eof

    movzx eax, byte [inBuf]

    cmp al, 'a'

    jb  po_check

    cmp al, 'f'

    ja  po_check

    sub al, 32                  

po_check:

    cmp al, 'A'

    jb  po_invalid

    cmp al, 'F'

    ja  po_invalid

    sub eax, 'A'                

    mov [selIndex], eax

    imul esi, eax, ITEM_SIZE

    add esi, itemTable          

    print msgOrdered, msgOrderedLen

    mov ecx, [esi]              

    mov edx, [esi+4]

    mov eax, SYS_WRITE

    mov ebx, STDOUT

    int 80h

    print msgNewline, msgNewlineLen

    print msgPrice, msgPriceLen

    mov ecx, [esi+8]            

    mov edx, [esi+12]

    mov eax, SYS_WRITE

    mov ebx, STDOUT

    int 80h

    call writeReceipt           

    mov eax, 1

    jmp po_done

po_invalid:

    print msgInvalid, msgInvalidLen

    xor eax, eax

    jmp po_done

po_eof:

    call exitProgram            

po_done:

    pop esi

    pop edx

    pop ecx

    pop ebx

    ret


writeReceipt:

    push eax

    push ecx

    push edx

    mov ecx, [esi+16]           ; receipt line ptr

    mov edx, [esi+20]           ; receipt line length

    fwrite ecx, edx

    pop edx

    pop ecx

    pop eax

    ret



displayReceipt:

    push ebx

    push ecx

    push edx

    push esi

    print msgHeader, msgHeaderLen

    mov eax, SYS_OPEN

    mov ebx, receiptFile

    mov ecx, O_RDONLY

    xor edx, edx

    int 80h

    test eax, eax

    js  dr_error

    mov esi, eax                ; ESI = read fd

dr_loop:

    mov eax, SYS_READ

    mov ebx, esi

    mov ecx, readBuf

    mov edx, 256

    int 80h

    cmp eax, 0

    jle dr_close

    mov edx, eax                ; bytes read

    mov eax, SYS_WRITE

    mov ebx, STDOUT

    mov ecx, readBuf

    int 80h

    jmp dr_loop

dr_close:

    mov eax, SYS_CLOSE

    mov ebx, esi

    int 80h

    print msgFooter, msgFooterLen

    jmp dr_done

dr_error:

    print msgOpenErr, msgOpenErrLen

dr_done:

    pop esi

    pop edx

    pop ecx

    pop ebx

    ret



exitProgram:

    print msgThanks, msgThanksLen

    mov eax, SYS_CLOSE          ; close the write handle

    mov ebx, [fileHandle]

    int 80h

    call displayReceipt         ; reopen read-only and display

    mov eax, SYS_EXIT

    xor ebx, ebx

    int 80h

    ret
 