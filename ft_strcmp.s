
	; rdi -> string 1
	; rsi -> string 2

section.text
	global _ft_strcmp		; global symbol
_ft_strcmp:
	xor rax, rax				; setting rax to 0
	.loop:
		movzx eax, byte [rdi]	; load unsigned char into 32bit eax register and fill rest with 0
		movzx ecx, byte [rsi]	; load unsigned char into 32bit ecx register and fill rest with 0
		cmp eax, ecx			; compare the bytes
		jne .sub				; jump if bytes are different
		test al, al				; check if byte was 0 byte
		je .return				; jump to return
		inc rdi					; increment s1 pointer
		inc rsi					; increment s2 pointer
		jmp .loop				; jump back to beginning of .loop
	.sub:
		sub eax, ecx			; subtract (unsigned char s1 - unsigned char s2) and store result in eax
	.return:
		ret						; return rax as result
