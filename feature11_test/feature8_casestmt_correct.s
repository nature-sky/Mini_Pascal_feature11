	%INCLUDE "libasm.h"
	SECTION .text
	GLOBAL main
main:
	sub esp, 4
	mov eax, esp
	sub eax, 8192
	mov [stklimit], eax
	push ebp
	mov ebp, esp
	sub ebp, 4
	mov eax, [stklimit]
	cmp ebp, eax
	jle STKOV
	mov edx, 2
	mov [ebp - 4], edx
	mov eax, [ebp - 4]
	jmp L2
L3:
	lea edx, [LS1]
	call WriteString
	jmp L1
L4:
	lea edx, [LS2]
	call WriteString
	jmp L1
L2:
	mov ebx, 3
	cmp eax, ebx
	je L4
	mov ebx, 2
	cmp eax, ebx
	je L4
	mov ebx, 1
	cmp eax, ebx
	je L4
	mov ebx, 0
	cmp eax, ebx
	je L3
	jmp BADCAS
L1:
	mov eax, 0
	pop ebp
	add esp, 4
	ret
BADRNG:
	mov edx, badrngstr
	jmp failure
BADDIV:
	mov edx, baddivstr
	jmp failure
BADCAS:
	mov edx, badcasstr
	jmp failure
BADPTR:
	mov edx, badptrstr
	jmp failure
BADSUB:
	mov edx, badsubstr
	jmp failure
STKOV:
	mov edx, stkovstr
	jmp failure
HEAPOV:
	mov edx, heapovstr
	jmp failure
failure:
	call WriteString
	call Exit
copy:
	mov edx, [esi]
	mov [edi], edx
	inc esi
	inc edi
	loop copy
	ret
alloc:
	mov ebx, heapptr
	mov edx, eax
	sub edx, ebx
	mov [heapptr], edx
	lea ebx, [heap]
	cmp edx, ebx
	jl HEAPOV
	ret
	SECTION .data
badrngstr: DB 0x0A, "Value out of range in assignment", 0x0A, 0x00
baddivstr: DB 0x0A, "Division by zero", 0x0A, 0x00
badcasstr: DB 0x0A, "Value not handled in case statement", 0x0A, 0x00
badptrstr: DB 0x0A, "Attempt to use a null pointer", 0x0A, 0x00
badsubstr: DB 0x0A, "Subscript out of bounds", 0x0A, 0x00
stkovstr:  DB 0x0A, "Stack overflow", 0x0A, 0x00
heapovstr: DB 0x0A, "Out of heap space", 0x0A, 0x00
LS2:	DB "other", 0x00
LS1:	DB "0", 0x00
          ALIGN 4
heap:     TIMES 8192 DB 0
heapptr:  DD 0
stklimit: DD 0
