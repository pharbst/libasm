extern __errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> size

section .text
	global ft_write		; global symbol
ft_write:
	mov rax, 1
	syscall
	test eax, eax
	js .error
	ret

	.error:
		neg eax
		mov edx, eax
		call __errno_location wrt ..plt
		mov [rax], edx
		mov rax, -1
		ret

section .note.GNU-stack noalloc noexec nowrite progbits
