section .text
    global ft_is_whitespace

    ; dil (rdi destination index low) char to check if whitespace ("\r\t\v\f\n" and ' ')

    cmp dil, ' '
    je .is_ws
    cmp dil, 9
    jb .not_ws
    cmp dil, 13
    jbe .is_ws

    .not_ws:
        mov rax, 0
        ret

    .is_ws:
        mov rax, 1
        ret

section .note.GNU-stack noalloc noexec nowrite progbits
