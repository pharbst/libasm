extern ft_strchr
extern ft_is_whitespace
extern ft_strlen
section .text
    global ft_atoi_base

    ; rdi source string
    ; rsi base string

ft_atoi_base:
    xor rcx, rcx                                ; position = 0
    mov rdx, rdi                                ; make the register rdi free for the is whitespace function
    xor rdi, rdi
    mov r8, 1                                   ; if no sign set pos sign but dont increment counter


    .skip_ws:                                   ; short loop to skip whitespace
        mov dil, [rdx + rcx]                    ; move the first char into rdi (destination index low)
        call ft_is_whitespace wrt ..plt         ; call is whitespace and wrt ..plt (with respect to ..procedure linkage table)
        test rax, rax                           ; set cpu flags for return value
        jz .check_sign                          ; jump if zero flag is triggert
        inc rcx                                 ; increment counter
        jmp .skip_ws                            ; jump back to skip_ws


    .check_sign:
        mov dil, [rdx + rcx]
        cmp dil, '-'                            ; if char is '-' set neg sign and increment counter
        je .set_neg
        cmp dil, '+'                            ; if char is '+' set pos sign and increment counter
        je .set_pos
        jmp .base_len


        .set_neg:
            imul r8, -1
        .set_pos:
            inc rcx
            jmp .check_sign


    .base_len:
        mov rdi, rsi                            ; move the base string into rdi for downstream function calls they all need base string as first input
        call ft_strlen wrt ..plt                ; the length of the base string will be the multiplier for the actual formatting arithmetic
        mov r9, rax                             ; store that multipier in r9

    xor r10, r10                                ; value = 0

    .loop:
        xor rsi, rsi
        mov sil, [rdx + rcx]
        test sil, sil
        jz .end
                ; safe rdi cause strchr mutates rdi
        mov r11, rdi
        call ft_strchr wrt ..plt                ; call strchr with base string rdi and current char sil
        mov rdi, r11
        test rax, rax
        jz .end
        sub rax, rdi                            ; calculate actual index

        imul r10, r9
        add r10, rax

        inc rcx
        jmp .loop

    .end:
        imul r10, r8
        mov rax, r10
        ret

section .note.GNU-stack noalloc noexec nowrite progbits
