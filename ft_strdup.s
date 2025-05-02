extern malloc
extern _ft_strlen
extern _ft_strcpy

	; rdi -> string to duplicate

section.text
	global _ft_strdup		; global symbol
_ft_strdup:
	push rdi		; save rdi original pointer to the stack
	call _ft_strlen	; call strlen
	inc rax			; incremnt for 0 byte
	mov rdi, rax	; put return of strlen into rdi
	call malloc		; call malloc
	mov rdi, rax	; store malloc result in rdi for strcpy
	pop rsi			; get the original pointer of the string to duplicate in rsi
	push rax		; save the original pointer from malloc onto the stack
	call _ft_strcpy	; call strcpy with rdi deestination pointer and rsi src pointer
	pop rax			; get back the original pointer from malloc
	ret				; return the pointer to the duplicated string