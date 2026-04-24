section .text
    global ft_strchr

    ; rdi char * to string
    ; sil (rsi source index low) char to search for in string

    ; return first occurance of char in string

ft_strchr:
    .loop:
        xor rax, rax
        mov al, [rdi]
        cmp al, sil
        je .found
        test al, al
        jz .not_found
        inc rdi
        jmp .loop

    .found:
        mov rax, rdi
        ret

    .not_found:
        xor rax, rax
        ret

section .note.GNU-stack noalloc noexec nowrite progbits
