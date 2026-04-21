extern __errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> size

section .text
	global _ft_write		; global symbol
_ft_write:
	mov rax, 1
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
