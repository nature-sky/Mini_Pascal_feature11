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
	jmp L1
	mov eax, 10
	call WriteInt
	call Crlf
	jmp L2
L1:
	mov edx, 99
	mov [ebp - 4], edx
L2:
	mov eax, [ebp - 4]
	call WriteInt
	call Crlf
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
          ALIGN 4
heap:     TIMES 8192 DB 0
heapptr:  DD 0
stklimit: DD 0
