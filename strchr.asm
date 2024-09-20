section .text
    global .strchr
.strchr:
    mov rax, rsi
    .loop:
        cmp byte [rax], dil
        je .return
        inc rax
        jmp .loop
    .return:
        ret