section .text
    global ft_strcpy

ft_strcpy:
    mov     rax, rdi
.copy:
    mov     dl, [rsi]
    mov     [rdi], dl
    inc     rsi
    inc     rdi
    test    dl, dl
    jne     .copy
    ret

section .note.GNU-stack noalloc
