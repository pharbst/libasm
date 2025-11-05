section .text
    global ft_strdup
    extern ft_strlen
    extern ft_strcpy
    extern malloc

ft_strdup:
    mov     rdx, rdi
    call    ft_strlen
    inc     rax
    mov     rdi, rax
    call    malloc
    test    rax, rax
    je      .malloc_fail
    mov     rsi, rdx
    mov     rdi, rax
    call    ft_strcpy
    ret
.malloc_fail:
    ret

section .note.GNU-stack noalloc
