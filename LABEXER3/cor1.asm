%macro print_text 2
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro

%macro defmsg 2+
%1: db %2
%1_len equ $-%1
%endmacro

%macro get_field 3
    print_text %1, %2
    mov edi, %3
    call read_input
%endmacro

%macro show_field 3
    print_text %1, %2
    mov esi, %3
    call print_proc
    print_text nl, 1
%endmacro

%macro file_field 2
    mov esi, %1
    call write_str
    mov esi, %2
    call write_str
    mov esi, nl
    call write_str
%endmacro

section .data
defmsg menu, "====================================", 10, "               COR", 10, "====================================", 10, 10, "1. Input", 10, "2. Output", 10, "3. Write", 10, "4. Read", 10, "5. Exit", 10, 10, "Enter your choice: "
defmsg m_invalid, "Invalid choice.", 10, 10
defmsg m_success, "Data entered successfully.", 10, 10
defmsg m_written, "Data successfully written to cor.txt", 10, 10
defmsg m_reading, "Reading cor.txt...", 10, 10
defmsg m_noread, "Unable to open cor.txt. Use option 3 first.", 10, 10
defmsg m_nowrite, "Unable to create cor.txt.", 10, 10
defmsg m_crlf, 10
nl: db 10, 0

defmsg p_snum, "Student Number: "
defmsg p_name, "Student Name: "
defmsg p_phone, "Phone Number: "
defmsg p_zip, "Zip Code: "
defmsg p_college, "College: "
defmsg p_program, "Program: "
defmsg p_year, "Year Level: "
defmsg p_sy, "School Year: "
defmsg p_addr, "Address: "
defmsg p_units, "Total Units: "

defmsg o_title, 10, "====================================", 10, "      CERTIFICATE OF REGISTRATION", 10, "====================================", 10
defmsg o_status, "Enrollment Status : ENROLLED", 10
defmsg o_snum, "Student #         : "
defmsg o_name, "Name              : "
defmsg o_phone, "Phone Number      : "
defmsg o_zip, "Zip Code          : "
defmsg o_college, "College           : "
defmsg o_program, "Program           : "
defmsg o_year, "Year Level        : "
defmsg o_sy, "School Year       : "
defmsg o_addr, "Address           : "

defmsg o_sched, 10, "====================================================================================================================", 10, "Course    Title                                   Section Units Days Time                           Room", 10, "====================================================================================================================", 10, 10, "CCS0021   INFORMATION MANAGEMENT (LEC)            TN24    2     T    16:00-18:40                   ONLINE", 10, "CCS0021L  INFORMATION MANAGEMENT (LAB)            TN24    1     F    16:00-18:50                   ONLINE", 10, "CS0001    DISCRETE STRUCTURES 1                   TN24    3    S/W   15:00-16:50                   F710/F710", 10, "CS0003    COMPUTER SYSTEMS & ARCHITECTURE         TN24    2     F    10:00-12:40                   ONLINE", 10, "CS0003L   COMPUTER SYSTEMS & ARCHITECTURE LAB     TN24    1    TH    10:00-12:50                   E610", 10, "CS0070    OBJECT ORIENTED PROGRAMMING             TN24    2     F    07:00-09:40                   ONLINE", 10, "CS0070L   OBJECT ORIENTED PROGRAMMING LAB         TN24    1    TH    07:00-09:50                   E609", 10, "GED0021   SPECIALIZED ENGLISH PROGRAM 2           TN24    3    S/W   11:00-12:50                   F607/F607", 10, "GED0075   LINEAR ALGEBRA                          TN24    3    F/T   13:00-14:50                   ONLINE/ONLINE", 10, "GED0081   COLLEGE PHYSICS 1 LECTURE               TN24    2     T    07:00-09:40                   ONLINE", 10, "GED0081L  COLLEGE PHYSICS 1 LABORATORY            TN24    1     S    07:00-09:50                   F1003", 10, 10
defmsg o_tunits, "TOTAL UNITS : "

defmsg o_assess, 10, "=========================================================", 10, "                      ASSESSMENT", 10, "=========================================================", 10, 10
defmsg o_tuition, "Tuition Fee (units)                    "
defmsg o_fees, "Miscellaneous Fee                      12305.00", 10, "ID Validation Fee                      80.00", 10, "ITE Computer Laboratory Fee CCS0021    4008.00", 10, "ITE Computer Laboratory Fee CS0003     4008.00", 10, "ITE Computer Laboratory Fee CS0070     4008.00", 10, "Science Lab Fee GED0081                4104.00", 10, 10
defmsg o_total, "TOTAL ASSESSMENT                       "
defmsg o_dot00, ".00", 10

fname: db "cor.txt", 0
w_status: db "Enrollment Status : ENROLLED", 10, 0
w_snum: db "Student Number : ", 0
w_name: db "Name : ", 0
w_phone: db "Phone Number : ", 0
w_zip: db "Zip Code : ", 0
w_college: db "College : ", 0
w_program: db "Program : ", 0
w_year: db "Year Level : ", 0
w_sy: db "School Year : ", 0
w_addr: db "Address : ", 0
w_units: db "Units : ", 0
w_tuition: db "Tuition Fee : ", 0
w_total: db "Total Assessment : ", 0

section .bss
inbuf:      resb 128
f_snum:     resb 128
f_name:     resb 128
f_phone:    resb 128
f_zip:      resb 128
f_college:  resb 128
f_program:  resb 128
f_year:     resb 128
f_sy:       resb 128
f_addr:     resb 128
units:      resd 1
tuition:    resd 1
total:      resd 1
fd:         resd 1
numbuf:     resb 16
filebuf:    resb 4096

section .text
global _start

print_proc:
    pusha
    xor edx, edx
.len:
    cmp byte [esi+edx], 0
    je .wr
    inc edx
    jmp .len
.wr:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 80h
    popa
    ret

read_input:
    push ebx
    push ecx
    push edx
    mov eax, 3
    mov ebx, 0
    mov ecx, edi
    mov edx, 127
    int 80h
    cmp eax, 0
    jle .eof
    mov ecx, eax
    dec ecx
    cmp byte [edi+ecx], 10
    je .term
    inc ecx
.term:
    mov byte [edi+ecx], 0
    mov eax, ecx
    jmp .done
.eof:
    mov byte [edi], 0
    mov eax, -1
.done:
    pop edx
    pop ecx
    pop ebx
    ret

atoi:
    push ebx
    push esi
    xor eax, eax
.loop:
    movzx ebx, byte [esi]
    sub ebx, '0'
    cmp ebx, 9
    ja .end
    imul eax, 10
    add eax, ebx
    inc esi
    jmp .loop
.end:
    pop esi
    pop ebx
    ret

itoa:
    push ebx
    push edx
    mov esi, numbuf + 15
    mov byte [esi], 0
    mov ebx, 10
.loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .loop
    pop edx
    pop ebx
    ret

print_number:
    push eax
    push esi
    call itoa
    call print_proc
    pop esi
    pop eax
    ret

write_str:
    pusha
    xor edx, edx
.len:
    cmp byte [esi+edx], 0
    je .wr
    inc edx
    jmp .len
.wr:
    mov eax, 4
    mov ebx, [fd]
    mov ecx, esi
    int 80h
    popa
    ret

write_num:
    pusha
    call itoa
    call write_str
    mov esi, nl
    call write_str
    popa
    ret

compute_tuition:
    mov eax, [units]
    imul eax, 2108
    mov [tuition], eax
    ret

compute_assessment:
    mov eax, [tuition]
    add eax, 12305
    add eax, 80
    add eax, 4008
    add eax, 4008
    add eax, 4008
    add eax, 4104
    mov [total], eax
    ret

input_proc:
    get_field p_snum, p_snum_len, f_snum
    get_field p_name, p_name_len, f_name
    get_field p_phone, p_phone_len, f_phone
    get_field p_zip, p_zip_len, f_zip
    get_field p_college, p_college_len, f_college
    get_field p_program, p_program_len, f_program
    get_field p_year, p_year_len, f_year
    get_field p_sy, p_sy_len, f_sy
    get_field p_addr, p_addr_len, f_addr
    print_text p_units, p_units_len
    mov edi, inbuf
    call read_input
    mov esi, inbuf
    call atoi
    mov [units], eax
    call compute_tuition
    call compute_assessment
    print_text m_success, m_success_len
    ret

output_proc:
    print_text o_title, o_title_len
    print_text o_status, o_status_len
    show_field o_snum, o_snum_len, f_snum
    show_field o_name, o_name_len, f_name
    show_field o_phone, o_phone_len, f_phone
    show_field o_zip, o_zip_len, f_zip
    show_field o_college, o_college_len, f_college
    show_field o_program, o_program_len, f_program
    show_field o_year, o_year_len, f_year
    show_field o_sy, o_sy_len, f_sy
    show_field o_addr, o_addr_len, f_addr
    print_text o_sched, o_sched_len
    print_text o_tunits, o_tunits_len
    mov eax, [units]
    call print_number
    print_text nl, 1
    print_text o_assess, o_assess_len
    print_text o_tuition, o_tuition_len
    mov eax, [tuition]
    call print_number
    print_text o_dot00, o_dot00_len
    print_text o_fees, o_fees_len
    print_text o_total, o_total_len
    mov eax, [total]
    call print_number
    print_text o_dot00, o_dot00_len
    print_text m_crlf, m_crlf_len
    ret

write_file:
    mov eax, 8
    mov ebx, fname
    mov ecx, 0o644
    int 80h
    cmp eax, 0
    jl .err
    mov ebx, eax
    mov eax, 6
    int 80h
    mov eax, 5
    mov ebx, fname
    mov ecx, 513
    mov edx, 0o644
    int 80h
    cmp eax, 0
    jl .err
    mov [fd], eax
    mov esi, w_status
    call write_str
    file_field w_snum, f_snum
    file_field w_name, f_name
    file_field w_phone, f_phone
    file_field w_zip, f_zip
    file_field w_college, f_college
    file_field w_program, f_program
    file_field w_year, f_year
    file_field w_sy, f_sy
    file_field w_addr, f_addr
    mov esi, w_units
    call write_str
    mov eax, [units]
    call write_num
    mov esi, w_tuition
    call write_str
    mov eax, [tuition]
    call write_num
    mov esi, w_total
    call write_str
    mov eax, [total]
    call write_num
    mov eax, 6
    mov ebx, [fd]
    int 80h
    print_text m_written, m_written_len
    ret
.err:
    print_text m_nowrite, m_nowrite_len
    ret

read_file:
    mov eax, 5
    mov ebx, fname
    xor ecx, ecx
    xor edx, edx
    int 80h
    cmp eax, 0
    jl .err
    mov [fd], eax
    print_text m_reading, m_reading_len
.loop:
    mov eax, 3
    mov ebx, [fd]
    mov ecx, filebuf
    mov edx, 4095
    int 80h
    cmp eax, 0
    jle .close
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, filebuf
    int 80h
    jmp .loop
.close:
    mov eax, 6
    mov ebx, [fd]
    int 80h
    print_text m_crlf, m_crlf_len
    ret
.err:
    print_text m_noread, m_noread_len
    ret

_start:
.menu:
    print_text menu, menu_len
    mov edi, inbuf
    call read_input
    cmp eax, -1
    je .exit
    mov al, [inbuf]
    cmp al, '1'
    je .opt1
    cmp al, '2'
    je .opt2
    cmp al, '3'
    je .opt3
    cmp al, '4'
    je .opt4
    cmp al, '5'
    je .exit
    print_text m_invalid, m_invalid_len
    jmp .menu
.opt1:
    call input_proc
    jmp .menu
.opt2:
    call output_proc
    jmp .menu
.opt3:
    call write_file
    jmp .menu
.opt4:
    call read_file
    jmp .menu
.exit:
    mov eax, 1
    xor ebx, ebx
    int 80h