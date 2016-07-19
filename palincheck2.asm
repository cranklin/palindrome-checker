; assemble:
; nasm -f elf palincheck2.asm
; ld -m elf_i386 -s -o palincheck2 palincheck2.o
; run:
; ./palincheck2 racecar
section .data
    SYS_EXIT    equ 1
    SYS_WRITE   equ 4
    STDOUT      equ 1
    NUL         equ 0
    TRAP        equ 0x80

section .text
    global _start

_start:
    pop ebx     ; number of args
    pop ebx     ; name of program
    pop ebx     ; actual argument

    push ebx
    mov ecx, 0  ; counter
    dec ebx
count:
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    jnz count

done_counting:
    dec ecx         ; ecx should contain string length
    pop ebx         ; restore ebx with string
    mov edx, ebx
    add edx, ecx
    dec edx
    mov ecx, ebx    ; move string pointer to ecx

compareString:
    cmp byte [ecx], 0xa    ; check if linefeed
    je set_true

    mov ah, byte [edx]
    cmp byte [ecx], ah
    jne set_false

    cmp ecx, edx    ; pointers have passed each other
    jae set_true

    inc ecx     ; increment the pointer to the next char
    dec edx     ; decrement the pointer to the prev char
    jmp compareString

set_true:
    mov ebx, 0  ; success
    jmp exit

set_false:
    mov ebx, 1  ; fail

exit:
    mov eax, SYS_EXIT
    int TRAP
