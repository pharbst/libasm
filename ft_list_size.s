section .text
	global ft_list_size

	; rdi list pointer

ft_list_size:
	xor rax, rax
	test rdi, rdi
	jz .end
	mov rdx, rdi
	.loop:
		inc rax
		cmp rdx, [rdi + 8]
		je .end
		mov rsi, rdi
		mov rdi, [rsi + 8]
		test rdi, rdi
		jz .end
		jmp .loop
	.end:
		ret

section .note.GNU-stack noalloc noexec nowrite progbits
