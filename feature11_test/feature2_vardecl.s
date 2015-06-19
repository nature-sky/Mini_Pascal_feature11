%include "./lib/libasm.h"
	SECTION .text
	GLOBAL main
main:
	mov [bottom],esp
	sub dword[bottom],8192
	push ebp
	mov ebp,esp
	sub esp,4
	cmp esp,[bottom]
	jle STKOV
	mov eax,10
	mov [ebp-4],eax
	mov eax,[ebp-4]
	mov eax,[ebp+8]
	mov [ebp+8],eax
	call wint
	call wln
	mov eax,0
	mov esp,ebp
	pop ebp
	ret
BADRNG:
	lea ecx,[badrngstr]
	mov [ebp+8],ecx
	jmp failure
BADDIV:
	lea ecx,[baddivstr]
	mov [ebp+8],ecx
	jmp failure
BADCAS:
	lea ecx,[badcasstr]
	mov [ebp+8],ecx
	jmp failure
BADPTR:
	lea ecx,[badptrstr]
	mov [ebp+8],ecx
	jmp failure
BADSUB:
	lea ecx,[badsubstr]
	mov [ebp+8],ecx
	jmp failure
STKOV:
	lea ecx,[stkovstr]
	mov [ebp+8],ecx
	jmp failure
HEAPOV:
	lea ecx,[heapovstr]
	mov [ebp+8],ecx
	jmp failure
failure:
	call wstr
	call Exit
wstr:
	call WriteString
	mov esp,ebp
	pop ebp
	ret
wint:
	call WriteInt
	mov esp,ebp
	pop ebp
	ret
wln:
	mov eax,nlstr
	call WriteChar
	mov esp,ebp
	pop ebp
	ret
copy:
	mov ecx,[ebp+8]
	mov [ebp+20],ecx
	mov edx,[ebp+20]
	mov [ebp+12],edx
	add word[ebp+8],1
	add word[ebp+12],1
	sub word[ebp+16],1
	cmp word[ebp+12],0
	jg copy
	mov esp,ebp
	pop ebp
	ret
alloc:
	mov dword[ebp+12], heapptr
	mov ecx,[ebp+8]
	mov edx,[ebp+12]
	sub ecx,edx
	mov ecx,[ebp+8]
	mov [heapptr],ecx
	lea ecx,[heap]
	mov [ebp+12],ecx
	mov ecx,[ebp+8]
	mov edx,[ebp+12]
	cmp ecx,edx
	jl HEAPOV
	mov esp,ebp
	pop ebp
	ret
	SECTION .data
nlstr db 10
badrngstr db 10,"Value out of range in assignment$",10
baddivstr db 10,"Division by zero$",10
badcasstr db 10,"Value not handled in case statement$",10
badptrstr db 10,"Attempt to use a null pointer$",10
badsubstr db 10,"Subscript out of bounds$",10
stkovstr db 10,"Stackoverflow$",10
heapovstr db 10,"Out of heap space$",10
	SECTION   .bss
heap        resb 8192
	SECTION .data
            align 2
heapptr     dd heap
bottom      dd 0
