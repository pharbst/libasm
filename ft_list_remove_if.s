extern free
section .text
	global ft_list_remove_if

	; rdi list head **
	; rsi data ref
	; rdx cmp func
	; rcx free_fct

ft_list_remove_if:
	test rdi, rdi
	jz .end
	test rdx, rdx
	jz .end
	test rcx, rcx
	jz .end

	push rbx
	push r12
	push r13
	push r14
	push r15

	mov r15, rdi					; head ** in r15
	mov rbx, rdx					; rbx = cmp_fct
	mov r12, rcx					; r12 = free_fct
	mov r13, rsi					; r13 = data_ref

	.head:
		.head.loop:
			mov rdx, [r15]
			test rdx, rdx
			jz .behind_head

			mov rdi, [r15]			; load data
			mov rdi, [rdi]
			mov rsi, r13			; load original data_ref
			call rbx				; call cmp_fct
			test eax, eax			
			jnz .behind_head

			; remove head node and update pointer
			mov r14, [r15]
			mov rdx, [r14 + 8]
			mov [r15], rdx
			mov rdi, [r14]
			call r12
			mov rdi, r14
			call free wrt ..plt
			jmp .head.loop

	.behind_head:
		mov r14, [r15]				; r14 = *head = current

	.search_loop:
		test r14, r14
		jz .end

		mov rdx, [r14 + 8]			; rdx = r14->next = current->next = next
		test rdx, rdx
		jz .end

		mov rdi, [rdx]				; rdi = r14->next->data = current->next->data = next->data
		mov rsi, r13				; rsi = data_ref
		call rbx
		test eax, eax
		jnz .search_loop.continue

		mov rdx, [r14 + 8]			; rdx = r14->next = current->next = next
		mov rcx, [rdx + 8]
		mov [r14 + 8], rcx
		mov rdi, [rdx]
		call r12
		mov rdi, rdx
		call free wrt ..plt
		jmp .search_loop

		.search_loop.continue:
			mov r14, [r14 + 8]
			jmp .search_loop

	.end:
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		ret
