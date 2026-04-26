extern ft_strchr
extern ft_is_whitespace
extern ft_strlen
section .text
    global ft_atoi_base

    ; rdi source string stored in r12
    ; rsi base string stored in r13
    ; store them somewhere else

ft_atoi_base:

    push r12                                    ; push calee saved registers to the stack to store stable local values
    push r13
    ; push r14
    ; push rbx

    mov r12, rdi                                ; move values to stable registers
    mov r13, rsi

    mov r8, 1                                   ; if no sign set pos sign but dont increment counter

    xor rax, rax                                ; set registers to 0
    xor rcx, rcx
    xor rdi, rdi
    xor rsi, rsi
    xor r10, r10

    .check_base:                                ; validate base string for duplicate chars
        mov dil, [r13 + rcx]
        test dil, dil
        jz .skip_ws

        call ft_is_whitespace wrt ..plt
        test rax, rax
        jnz .end                             ; base contains whitespace

        cmp dil, '-'
        je .end
        cmp dil, '+'
        je .end

        mov sil, dil
        mov rdi, r13
        add rdi, rcx
        add rdi, 1
        call ft_strchr wrt ..plt
        test rax, rax
        jnz .end                                ; base contains duplicate char
        xor rdi, rdi
        inc rcx
        jmp .check_base

    .skip_ws:                                   ; skip leading whitespaces in number string
        xor rcx, rcx
        xor rdi, rdi
        .skip_ws.loop:
            mov dil, [r12 + rcx]
            call ft_is_whitespace wrt ..plt
            test rax, rax
            jz .check_sign
            inc rcx
            jmp .skip_ws.loop

    .check_sign:
        mov dil, [r12 + rcx]
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
        mov rdi, r13                            ; move the base string into rdi for downstream function calls they all need base string as first input
        call ft_strlen wrt ..plt                ; the length of the base string will be the multiplier for the actual formatting arithmetic
        mov r9, rax                             ; store that multipier in r9

    xor r10, r10                                ; value = 0

    .loop:
        xor rsi, rsi
        mov sil, [r12 + rcx]
        test sil, sil
        jz .end

        mov rdi, r13
        call ft_strchr wrt ..plt                ; call strchr with base string rdi and current char sil
        test rax, rax
        jz .end
        sub rax, r13                            ; calculate actual index

        imul r10, r9
        add r10, rax

        inc rcx
        jmp .loop

    .end:
        ; pop rbx
        ; pop r14
        pop r13
        pop r12
        imul r10, r8
        mov rax, r10
        ret

section .note.GNU-stack noalloc noexec nowrite progbits
