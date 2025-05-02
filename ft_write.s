extern errno_location

	; rdi -> fd
	; rsi -> char *buff
	; rdx -> size

section .text
	global _ft_write		; global symbol
_ft_write:
	xor rax, rax
	mov ebx, edi			; mov fd into ebx
	mov ecx, esi			; mov char *buff into ecx
	mov eax, 4				; set syscall number 4 for write
	int 0x80				; interrupt and call kernel
	test rax, rax			; check system call return >= 0
	jns .return				; jump if signed flag is false means rax contains bytes written
	neg rax					; negate result to get errno value
	mov rdi, rax			; move errno value into rdi
	call errno_location		; call errno to set error code
	mov rax, -1				; set rax to -1
	.return:
		ret
