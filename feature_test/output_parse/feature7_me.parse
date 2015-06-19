	.text
	.globl main
main:
	sub $sp $sp 12
	sub $s7 $sp 8192
	sw $ra 0($sp)
	sw $fp 4($sp)
	sw $0 8($sp)
	move $fp $sp
	sub $sp $sp 4
	ble $sp $s7 STKOV
	li $t9 1
	sw $t9 -4($fp)
	b L2
L1:
	li $t9 0
	sw $t9 -4($fp)
L2:
	li $v0 0
	move $sp $fp
	lw $fp 4($sp)
	lw $ra 0($sp)
	add $sp $sp 12
	jr $ra
BADRNG:
	la $a0 badrngstr
	b failure
BADDIV:
	la $a0 baddivstr
	b failure
BADCAS:
	la $a0 badcasstr
	b failure
BADPTR:
	la $a0 badptrstr
	b failure
BADSUB:
	la $a0 badsubstr
	b failure
STKOV:
	la $a0 stkovstr
	b failure
HEAPOV:
	la $a0 heapovstr
	b failure
failure:
	jal wstr
	li $v0 10
	syscall
wstr:
	li $v0 4
	syscall
	jr $ra
wint:
	li $v0 1
	syscall
	jr $ra
wln:
	li $v0 4
	la $a0 nlstr
	syscall
	jr $ra
copy:
	lb $a3 0($a0)
	sb $a3 0($a1)
	add $a0 $a0 1
	add $a1 $a1 1
	sub $a2 $a2 1
	bgtz $a2 copy
	jr $ra
alloc:
	lw $a1 heapptr
	sub $a0 $a1 $a0
	sw $a0 heapptr
	la $a1 heap
	blt $a0 $a1 HEAPOV
	jr $ra
	.data
nlstr:     .asciiz "\n"
badrngstr: .asciiz "\nValue out of range in assignment\n"
baddivstr: .asciiz "\nDivision by zero\n"
badcasstr: .asciiz "\nValue not handled in case statement\n"
badptrstr: .asciiz "\nAttempt to use a null pointer\n"
badsubstr: .asciiz "\nSubscript out of bounds\n"
stkovstr:  .asciiz "\nStack overflow\n"
heapovstr: .asciiz "\nOut of heap space\n"
          .align 2
heap:     .space 8192
heapptr:  .word heapptr
