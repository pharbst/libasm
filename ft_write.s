extern errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> size

section .text
	global _ft_write		; global symbol
_ft_write:
	mov rax, SYS_WRITE
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
