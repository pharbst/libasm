section .text
    global _strlen

_strlen:
    xor rax, rax
    .loop:
        cmp byte [rdi], 0
        je .return
        inc rdi
        inc rax
        jmp .loop
    .return:
        ret