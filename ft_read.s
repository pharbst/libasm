section .text
    global ft_read
    extern __errno_location

ft_read:
    mov     rax, 0
    syscall
    cmp     rax, 0
    jge     .done
    mov     rdx, rax
    neg     rdx
    call    __errno_location wrt ..plt
    mov     [rax], rdx
    mov     rax, -1
.done:
    ret

section .note.GNU-stack noalloc
