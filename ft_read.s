extern __errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> buffer size

section .text
	global _ft_read
ft_read:
	mov rax, 0
	syscall
	js .error
	ret

	.error
		neg rax
		mov edx, eax
		call __errno_location wrt ..plt
		mov [rax], edx
		mov rax, -1
		ret
