extern malloc
section .text
	global ft_list_push_front

	; rdi double pointer e.g list head pointer
	; rsi data pointer

ft_list_push_front:
	push r12
	push r13
	mov r12, rdi
	mov r13, rsi
	mov rdi, 16
	call malloc wrt ..plt
	mov rdi, r12
	mov rsi, r13
	pop r13
	pop r12
	test rax, rax
	jz .end
	mov [rax], rsi
	mov rcx, [rdi]
	mov [rax + 8], rcx
	mov [rdi], rax
	.end:
		ret

section .note.GNU-stack noalloc noexec nowrite progbits
