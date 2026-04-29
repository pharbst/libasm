
	; rdi -> string 1
	; rsi -> string 2

section .text
	global ft_strcmp			; global symbol
ft_strcmp:
	xor rax, rax				; setting rax to 0
	xor rcx, rcx
	xor rdx, rdx
	.loop:
		movzx eax, byte [rdi + rcx]
		movzx edx, byte [rsi + rcx]
		test eax, eax
		jz .last
		test edx, edx
		jz .last
		sub eax, edx
		jnz .end
		inc rcx
		jmp .loop

	.last:
		sub eax, edx

	.end:
		ret						; return rax as result

section .note.GNU-stack noalloc noexec nowrite progbits
