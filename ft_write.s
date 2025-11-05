section .text
    global ft_write
    extern __errno_location

ft_write:
    mov     rax, 1
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
