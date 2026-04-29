extern __errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> buffer size

section .text
	global ft_read
ft_read:
	mov rax, 0
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
