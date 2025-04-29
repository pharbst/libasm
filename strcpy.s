section .text
	global _strcpy

	# rdi -> dest pointer must have enough writable memory which must not overlap with the src pointer memory
	# rsi -> src pointer to valid c string

_strcpy:
	xor rax, rax		; setting rax to 0
	mov rax, rdi		; writing the pointer into return register to increment rdi without loosing the original pointer
	.loop:
		mov al, [rsi]	; load byte pointed by rsi into acc low register
		mov [rdi], al	; write that byte into memory pointed by rdi
		cmp al, 0		; compare acc low register with 0
		je .return		; jump if equal
		inc rsi			; increment rsi
		inc rdi			; increment rdi
		jmp .loop		; jump back to beeginnning of the loop
	.return:
		ret				; return the pointer in rax
