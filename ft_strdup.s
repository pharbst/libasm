extern malloc
extern ft_strlen
extern ft_strcpy

	; rdi -> string to duplicate

section .text
	global ft_strdup			; global symbol
ft_strdup:
	push rbx					; push rbx
	mov rbx, rdi				; store original pointer in a local stable register
	call ft_strlen wrt ..plt	; call strlen
	inc rax						; increment for 0 byte
	mov rdi, rax				; put return of strlen into rdi
	call malloc wrt ..plt		; call malloc
	mov rsi, rbx				; get the original pointer of the string to duplicate in rsi
	mov rdi, rax				; store malloc result in rdi for strcpy
	mov rbx, rax				; save the original pointer from malloc into local stable register
	call ft_strcpy wrt ..plt	; call strcpy with rdi destination pointer and rsi src pointer, strcpy returns rdi in rax
	pop rbx						; recover pre function state of rbx
	ret							; return the pointer to the duplicated string

section .note.GNU-stack noalloc noexec nowrite progbits
