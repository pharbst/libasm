extern malloc
extern ft_strlen
extern ft_strcpy

	; rdi -> string to duplicate

section .text
	global ft_strdup			; global symbol
ft_strdup:
	push rdi					; save rdi original pointer to the stack
	call ft_strlen wrt ..plt	; call strlen
	inc rax						; incremnt for 0 byte
	mov rdi, rax				; put return of strlen into rdi
	call malloc wrt ..plt		; call malloc
	mov rdi, rax				; store malloc result in rdi for strcpy
	pop rsi						; get the original pointer of the string to duplicate in rsi
	push rax					; save the original pointer from malloc onto the stack
	call ft_strcpy wrt ..plt	; call strcpy with rdi deestination pointer and rsi src pointer
	pop rax						; get back the original pointer from malloc
	ret							; return the pointer to the duplicated string

section .note.GNU-stack noalloc noexec nowrite progbits
