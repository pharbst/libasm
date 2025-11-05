section .text
    global ft_strlen

ft_strlen:
    xor     rax, rax
.loop:
    cmp     byte [rdi], 0
    je      .return
    inc     rdi
    inc     rax
    jmp     .loop
.return:
    ret

section .note.GNU-stack noalloc
