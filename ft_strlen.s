
section.text
    global _ft_strlen       ; global symbol
_ft_strlen:
    xor rax, rax            ; set rax to null
    .loop:
        cmp byte [rdi], 0   ; compare *rdi with 0
        je .return          ; jump equal to return
        inc rdi             ; increment rdi pointer
        inc rax             ; increment counter
        jmp .loop           ; jump back to .loop
    .return:
        ret                 ; return rax
