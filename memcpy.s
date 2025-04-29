section .text
	global _memcpy
_memcpy:
	test rdx, rdx
	jz .return
	cmp rdx, 64
	jl .byte_loop
	mov rcx, rdx
	shr rcx, 3
	.8_byte_loop:
		test rcx, rcx
		jz .byte_loop
		mov rax, [rsi]
		mov [rdi], rax
		add rsi, 8
		add rdi, 8
		dec rcx
		jmp .8_byte_loop
	.byte_loop:
		and rdx, 7
		test rdx, rdx
		jz .return
		mov al, byte [rsi]
		mov byte [rdi], al
		inc rdi
		inc rsi
		dec rdx
		jmp .byte_loop
	.return:
	ret