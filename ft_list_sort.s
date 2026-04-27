section .text
	global ft_list_sort

	; rdi
	; rsi

ft_list_sort:
	; if (!rdi || !rdi->next || !rsi)
	; return
	.check_parameter:
		test rdi, rdi
		jz .end
		test rsi, rsi
		jz .end
		mov rdx, [rdi]
		test rdx, rdx
		jz .end

	push rbx
	push r12
	push r13
	push r14
	mov rbx, rsi					; rbx holds function pointer
	mov r12, rdi					; r12 holds original double pointer

	mov r13, [r12]					; r13 holds r13 = *begin_list

	.iterate_list_a:
		; while (r13 && r13->next)
		test r13, r13				; if !r13
		jz .end.pop
		mov r14, [r13 + 8]			; r14 = r13->next
		test r14, r14				; if !r14
		jz .end.pop

		.iterate_list_b:
			; while (r14)
			test r14, r14
			jz .iterate_list_a.tail

			mov rdi, [r13]			; r13->data
			mov rsi, [r14]			; r14->data
			call rbx
			cmp eax, 0
			jle .iterate_list_b.tail
			mov rax, [r13]
			mov rcx, [r14]
			mov [r13], rcx
			mov [r14], rax

			.iterate_list_b.tail:
				mov r14, [r14 + 8]
				jmp .iterate_list_b

		.iterate_list_a.tail:
			mov r13, [r13 + 8]
			jmp .iterate_list_a

	.end.pop:
		pop r14
		pop r13
		pop r12
		pop rbx

	.end:
		ret
