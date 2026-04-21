extern errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> buffer size

section .text
	global _ft_read
_ft_read:
	mov rax, SYS_READ
	syscall
	js .error
	ret

	.error
		neg rax
		mov edx, rax
		call errno_location
		mov [rax], edx
		mov rax, -1
		ret
