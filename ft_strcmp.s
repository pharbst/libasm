section .text
    global ft_strcmp

ft_strcmp:
.loop:
    movzx   eax, byte [rdi]
    movzx   edx, byte [rsi]
    cmp     eax, edx
    jne     .diff
    test    al, al
    je      .equal
    inc     rdi
    inc     rsi
    jmp     .loop
.diff:
    sub     eax, edx
    ret
.equal:
    xor     eax, eax
    ret

section .note.GNU-stack noalloc
