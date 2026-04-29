
; rdi -> dest pointer must have enough writable memory which must not overlap with the src pointer memory
; rsi -> src pointer to valid c string

section .text
	global ft_strcpy			; global symbol
ft_strcpy:
	xor rax, rax				; setting rax to 0
	xor rdx, rdx
	xor rcx, rcx
	mov rax, rdi				; writing the pointer into return register to increment rdi without loosing the original pointer
	.loop:
		mov dl, [rsi + rcx]		; load byte pointed by rsi into acc low register
		mov [rdi + rcx], dl		; write that byte into memory pointed by rdi
		cmp dl, 0				; compare acc low register with 0
		je .return				; jump if equal
		inc rcx
		jmp .loop				; jump back to beginning of the loop
	.return:
		ret						; return the pointer in rax

section .note.GNU-stack noalloc noexec nowrite progbits
