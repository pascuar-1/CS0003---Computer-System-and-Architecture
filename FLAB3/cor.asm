%macro print_text 2
    mov ecx, %1
    mov edx, %2
    call print_proc
%endmacro

section .data

newline db 10
nl_len equ $-newline

title db 10,"==============================================================",10
      db "           CERTIFICATE OF REGISTRATION (COR)",10
      db "==============================================================",10
title_len equ $-title

enrolled db "Enrollment Status : ENROLLED",10
enrolled_len equ $-enrolled

pStudent db "Enter Student Number : "
pStudent_len equ $-pStudent

pName db "Enter Name : "
pName_len equ $-pName

pPhone db "Enter Phone Number : "
pPhone_len equ $-pPhone

pZip db "Enter Zip Code : "
pZip_len equ $-pZip

pCollege db "Enter College : "
pCollege_len equ $-pCollege

pProgram db "Enter Program : "
pProgram_len equ $-pProgram

pYear db "Enter Year Level : "
pYear_len equ $-pYear

pSY db "Enter School Year : "
pSY_len equ $-pSY

pAddress db "Enter Address : "
pAddress_len equ $-pAddress

pUnits db 10,"Enter Total Units : "
pUnits_len equ $-pUnits

lblStudent db "Student # : "
lblStudent_len equ $-lblStudent

lblName db "Name : "
lblName_len equ $-lblName

lblPhone db "Phone : "
lblPhone_len equ $-lblPhone

lblZip db "Zip Code : "
lblZip_len equ $-lblZip

lblCollege db "College : "
lblCollege_len equ $-lblCollege

lblProgram db "Program : "
lblProgram_len equ $-lblProgram

lblYear db "Year Level : "
lblYear_len equ $-lblYear

lblSY db "School Year : "
lblSY_len equ $-lblSY

lblAddress db "Address : "
lblAddress_len equ $-lblAddress

pressEnter db 10,"Press ENTER to view schedule...",10
pressEnter_len equ $-pressEnter

subjects db 10,\
"====================================================================================================================",10,\
"Course    Title                                   Section Units Days Time                           Room",10,\
"====================================================================================================================",10,\
"CCS0021   INFORMATION MANAGEMENT (LEC)            TN24    2     T    16:00-18:40                   ONLINE",10,\
"CCS0021L  INFORMATION MANAGEMENT (LAB)            TN24    1     F    16:00-18:50                   ONLINE",10,\
"CS0001    DISCRETE STRUCTURES 1                   TN24    3    S/W   15:00-16:50 / 15:00-16:50    F710 / F710",10,\
"CS0003    COMPUTER SYSTEMS & ARCHITECTURE         TN24    2     F    10:00-12:40                   ONLINE",10,\
"CS0003L   COMPUTER SYSTEMS & ARCHITECTURE (LAB)   TN24    1    TH    10:00-12:50                   E610",10,\
"CS0070    OBJECT ORIENTED PROGRAMMING             TN24    2     F    07:00-09:40                   ONLINE",10,\
"CS0070L   OBJECT ORIENTED PROGRAMMING-LAB         TN24    1    TH    07:00-09:50                   E609",10,\
"GED0021   SPECIALIZED ENGLISH PROGRAM 2           TN24    3    S/W   11:00-12:50 / 11:00-12:50    F607 / F607",10,\
"GED0075   LINEAR ALGEBRA                          TN24    3    F/T   13:00-14:50 / 13:00-14:50    ONLINE / ONLINE",10,\
"GED0081   COLLEGE PHYSICS 1 LECTURE              TN24    2     T    07:00-09:40                   ONLINE",10,\
"GED0081L  COLLEGE PHYSICS 1 LABORATORY           TN24    1     S    07:00-09:50                   F1003",10,\
"====================================================================================================================",10

subjects_len equ $-subjects

miscFee dd 12305
idFee dd 80
lab1 dd 4008
lab2 dd 4008
lab3 dd 4008
scienceLab dd 4104

assessmentTitle db 10,10,\
"==============================================================",10,\
"                      ASSESSMENT",10,\
"==============================================================",10

assessmentTitle_len equ $-assessmentTitle

tuitionLabel db "Tuition Fee (21)                         "
tuitionLabel_len equ $-tuitionLabel

fee1 db "Miscellaneous Fee                        12305.00",10
fee1_len equ $-fee1

fee2 db "ID Validation Fee                           80.00",10
fee2_len equ $-fee2

fee3 db "ITE Computer Laboratory Fee (CCS0021)     4008.00",10
fee3_len equ $-fee3

fee4 db "ITE Computer Laboratory Fee (CS0003)      4008.00",10
fee4_len equ $-fee4

fee5 db "ITE Computer Laboratory Fee (CS0070)      4008.00",10
fee5_len equ $-fee5

fee6 db "Science Lab Fee (GED0081)                 4104.00",10,10
fee6_len equ $-fee6

totalLabel db "TOTAL ASSESSMENT                         "
totalLabel_len equ $-totalLabel

peso00 db ".00",10
peso00_len equ $-peso00

section .bss

student resb 50
name resb 100
phone resb 50
zipcode resb 20
college resb 50
program resb 50
yearlvl resb 20
sy resb 20
address resb 150

unitsStr resb 20

units resd 1
tuition resd 1
assessment resd 1

numBuffer resb 20
dummy resb 2

section .text
global _start

_start:

print_text pStudent,pStudent_len
mov ecx,student
mov edx,50
call read_input

print_text pName,pName_len
mov ecx,name
mov edx,100
call read_input

print_text pPhone,pPhone_len
mov ecx,phone
mov edx,50
call read_input

print_text pZip,pZip_len
mov ecx,zipcode
mov edx,20
call read_input

print_text pCollege,pCollege_len
mov ecx,college
mov edx,50
call read_input

print_text pProgram,pProgram_len
mov ecx,program
mov edx,50
call read_input

print_text pYear,pYear_len
mov ecx,yearlvl
mov edx,20
call read_input

print_text pSY,pSY_len
mov ecx,sy
mov edx,20
call read_input

print_text pAddress,pAddress_len
mov ecx,address
mov edx,150
call read_input

print_text title,title_len
print_text enrolled,enrolled_len

print_text lblStudent,lblStudent_len
call display_student

print_text lblName,lblName_len
call display_name

print_text lblPhone,lblPhone_len
call display_phone

print_text lblZip,lblZip_len
call display_zip

print_text lblCollege,lblCollege_len
call display_college

print_text lblProgram,lblProgram_len
call display_program

print_text lblYear,lblYear_len
call display_year

print_text lblSY,lblSY_len
call display_sy

print_text lblAddress,lblAddress_len
call display_address

print_text pressEnter,pressEnter_len

mov eax,3
mov ebx,0
mov ecx,dummy
mov edx,2
int 80h

print_text subjects,subjects_len

print_text pUnits,pUnits_len

mov eax,3
mov ebx,0
mov ecx,unitsStr
mov edx,20
int 80h

mov esi,unitsStr
call atoi
mov [units],eax

mov eax,[units]
mov ebx,2108
mul ebx
mov [tuition],eax

mov eax,[tuition]
add eax,[miscFee]
add eax,[idFee]
add eax,[lab1]
add eax,[lab2]
add eax,[lab3]
add eax,[scienceLab]
mov [assessment],eax

print_text assessmentTitle,assessmentTitle_len

print_text tuitionLabel,tuitionLabel_len
mov eax,[tuition]
call print_number
print_text peso00,peso00_len

print_text fee1,fee1_len
print_text fee2,fee2_len
print_text fee3,fee3_len
print_text fee4,fee4_len
print_text fee5,fee5_len
print_text fee6,fee6_len

print_text totalLabel,totalLabel_len
mov eax,[assessment]
call print_number
print_text peso00,peso00_len

mov eax,1
xor ebx,ebx
int 80h

print_proc:
    push ebx
    mov eax,4
    mov ebx,1
    int 80h
    pop ebx
    ret

read_input:
    mov eax,3
    mov ebx,0
    int 80h
    ret

display_student:
    mov ecx,student
    mov edx,50
    call print_proc
    ret

display_name:
    mov ecx,name
    mov edx,100
    call print_proc
    ret

display_phone:
    mov ecx,phone
    mov edx,50
    call print_proc
    ret

display_zip:
    mov ecx,zipcode
    mov edx,20
    call print_proc
    ret

display_college:
    mov ecx,college
    mov edx,50
    call print_proc
    ret

display_program:
    mov ecx,program
    mov edx,50
    call print_proc
    ret

display_year:
    mov ecx,yearlvl
    mov edx,20
    call print_proc
    ret

display_sy:
    mov ecx,sy
    mov edx,20
    call print_proc
    ret

display_address:
    mov ecx,address
    mov edx,150
    call print_proc
    ret

atoi:
    xor eax,eax

atoi_loop:
    movzx ebx,byte [esi]
    cmp bl,10
    je atoi_done
    cmp bl,13
    je atoi_done
    cmp bl,0
    je atoi_done
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc esi
    jmp atoi_loop

atoi_done:
    ret

print_number:
    mov ecx,numBuffer+19
    mov byte [ecx],0
    mov ebx,10

convert_loop:
    dec ecx
    xor edx,edx
    div ebx
    add dl,'0'
    mov [ecx],dl
    test eax,eax
    jnz convert_loop

    mov eax,4
    mov ebx,1
    mov edx,numBuffer+19
    sub edx,ecx
    int 80h
    ret