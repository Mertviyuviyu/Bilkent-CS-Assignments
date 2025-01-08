.data

askB: .asciiz "Enter B: "
askC: .asciiz "Enter C: "
askD: .asciiz "Enter D: "
promptA: .asciiz "(C-B)*(C mod B) is: "
space: .asciiz " "

.text

main:
	#ask b
	li $v0, 4
	la $a0, askB
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 # t0 = B
	
	#ask c
	li $v0, 4
	la $a0, askC
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 # t1 = C
	
	#ask d
	#li $v0, 4
	#la $a0, askD
	#syscall
	
	#li $v0, 5
	#syscall
	#move $t2, $v0 # t2 = D

	sub $t3, $t1, $t0 # t3 = C-B
	rem $t4, $t1, $t0 # t4  C mod B
	mul $t5, $t4, $t3 # t5 = (C-B)*(C mod B)
	
	li $v0, 4
	la $a0, promptA
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 10
	syscall
