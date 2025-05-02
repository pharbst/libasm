extern errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> buffer size
section.text
	global _ft_read
_ft_read:
	xor rax, rax
	mov ebx, edi
	mov ecx, esi
	; mov edx, rdx
	mov eax, 3
	int 0x80
	test rax, rax
	jns .return
	neg rax
	mov rdi, rax
	call errno_location
	mov rax, -1
	.return:
		ret
