section .data

menu db 10,"----------------------------------",10
     db "MENU",10
     db "[A]dd",10
     db "[S]ubtract",10
     db "[M]ultiply",10
     db "[D]ivide",10
     db "----------------------------------",10
     db "Enter your choice: "
menuLen equ $-menu

prompt1 db 10,"Enter first number: "
prompt1Len equ $-prompt1

prompt2 db "Enter second number: "
prompt2Len equ $-prompt2

sumMsg db 10,"The sum is: "
sumMsgLen equ $-sumMsg

diffMsg db 10,"The difference is: "
diffMsgLen equ $-diffMsg

prodMsg db 10,"The product is: "
prodMsgLen equ $-prodMsg

quotMsg db 10,"The quotient is: "
quotMsgLen equ $-quotMsg

invalidMsg db 10,"Invalid menu choice!",10
invalidMsgLen equ $-invalidMsg

divZeroMsg db 10,"ERROR: Division by zero is not allowed!",10
divZeroMsgLen equ $-divZeroMsg

againMsg db 10,"Do you want to try again (Y/N)? "
againMsgLen equ $-againMsg

exitMsg db 10,"Thank you for using the Calculator Program.",10
exitMsgLen equ $-exitMsg

newline db 10
newlineLen equ $-newline

clearCmd db 27,"[2J",27,"[H"
clearLen equ $-clearCmd

section .bss

choice resb 2

inputBuffer resb 32

num1 resd 1
num2 resd 1
result resd 1

asciiBuffer resb 16

section .text
global _start


_start:

mainLoop:

    call clearScreen
    call displayMenu
    call getChoice

    mov al,[choice]

    cmp al,'A'
    je doAdd

    cmp al,'a'
    je doAdd

    cmp al,'S'
    je doSub

    cmp al,'s'
    je doSub

    cmp al,'M'
    je doMul

    cmp al,'m'
    je doMul

    cmp al,'D'
    je doDiv

    cmp al,'d'
    je doDiv

    ; Invalid choice
    mov eax,4
    mov ebx,1
    mov ecx,invalidMsg
    mov edx,invalidMsgLen
    int 80h

    call tryAgain
    jmp mainLoop


doAdd:

    call getTwoNumbers
    call addNumbers

    mov eax,4
    mov ebx,1
    mov ecx,sumMsg
    mov edx,sumMsgLen
    int 80h

    mov eax,[result]
    call printInteger

    call printNewLine
    call tryAgain

    jmp mainLoop


doSub:

    call getTwoNumbers
    call subtractNumbers

    mov eax,4
    mov ebx,1
    mov ecx,diffMsg
    mov edx,diffMsgLen
    int 80h

    mov eax,[result]
    call printInteger

    call printNewLine
    call tryAgain

    jmp mainLoop


doMul:

    call getTwoNumbers
    call multiplyNumbers

    mov eax,4
    mov ebx,1
    mov ecx,prodMsg
    mov edx,prodMsgLen
    int 80h

    mov eax,[result]
    call printInteger

    call printNewLine
    call tryAgain

    jmp mainLoop


doDiv:

    call getTwoNumbers
    call divideNumbers

    call tryAgain
    jmp mainLoop

displayMenu:

    mov eax,4
    mov ebx,1
    mov ecx,menu
    mov edx,menuLen
    int 80h

    ret


getChoice:

    mov eax,3
    mov ebx,0
    mov ecx,choice
    mov edx,2
    int 80h

    ret


getTwoNumbers:

    mov eax,4
    mov ebx,1
    mov ecx,prompt1
    mov edx,prompt1Len
    int 80h

    call getNumber
    mov [num1],eax

    mov eax,4
    mov ebx,1
    mov ecx,prompt2
    mov edx,prompt2Len
    int 80h

    call getNumber
    mov [num2],eax

    ret


getNumber:

    mov eax,3
    mov ebx,0
    mov ecx,inputBuffer
    mov edx,31
    int 80h

    mov esi,inputBuffer
    xor eax,eax

convertLoop:

    mov bl,[esi]

    cmp bl,10
    je convertDone

    cmp bl,13
    je convertDone

    sub bl,'0'

    imul eax,eax,10

    movzx ebx,bl
    add eax,ebx

    inc esi
    jmp convertLoop

convertDone:
    ret


addNumbers:

    mov eax,[num1]
    add eax,[num2]

    mov [result],eax
    ret


subtractNumbers:

    mov eax,[num1]
    sub eax,[num2]

    mov [result],eax
    ret


multiplyNumbers:

    mov eax,[num1]
    imul eax,[num2]

    mov [result],eax
    ret

divideNumbers:

    mov ebx,[num2]

    cmp ebx,0
    je divideByZero

    mov eax,[num1]
    cdq
    idiv ebx

    mov [result],eax

    mov eax,4
    mov ebx,1
    mov ecx,quotMsg
    mov edx,quotMsgLen
    int 80h

    mov eax,[result]
    call printInteger

    call printNewLine
    ret

divideByZero:

    mov eax,4
    mov ebx,1
    mov ecx,divZeroMsg
    mov edx,divZeroMsgLen
    int 80h

    ret


printInteger:

    mov edi,asciiBuffer
    add edi,15

    mov byte [edi],0

    cmp eax,0
    jne convertPositive

    dec edi
    mov byte [edi],'0'
    jmp printResult

convertPositive:

    mov ebx,10

nextDigit:

    xor edx,edx
    div ebx

    add dl,'0'

    dec edi
    mov [edi],dl

    test eax,eax
    jnz nextDigit

printResult:

    mov eax,4
    mov ebx,1
    mov ecx,edi

    mov edx,asciiBuffer
    add edx,15
    sub edx,edi

    int 80h

    ret

clearScreen:

    mov eax,4
    mov ebx,1
    mov ecx,clearCmd
    mov edx,clearLen
    int 80h

    ret


printNewLine:

    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,newlineLen
    int 80h

    ret


tryAgain:

    mov eax,4
    mov ebx,1
    mov ecx,againMsg
    mov edx,againMsgLen
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,choice
    mov edx,2
    int 80h

    mov al,[choice]

    cmp al,'Y'
    je continueProgram

    cmp al,'y'
    je continueProgram

    cmp al,'N'
    je exitProgram

    cmp al,'n'
    je exitProgram

    jmp exitProgram

continueProgram:
    ret


exitProgram:

    mov eax,4
    mov ebx,1
    mov ecx,exitMsg
    mov edx,exitMsgLen
    int 80h

    mov eax,1
    xor ebx,ebx
    int 80h