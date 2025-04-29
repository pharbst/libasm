section .text
	global _strcpy
_strcpy:
	 
	.loop
		
		je .return
		
		jmp .loop
	.return:
		mov rax, rdi
		ret