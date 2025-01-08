.data
ask_reg: .asciiz "Enter reg number(0-31): "
show_count: .asciiz "Chosen register usage count: "
newline: .asciiz "\n"


.text

main:
	la $a0, ask_reg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	blt $s0, 0, exit
	bgt $s0, 31, exit
	
	move $a0, $s0
	jal countReg
	
	move $s1, $v0
	
	li $v0, 4
	la $a0, show_count
	syscall
	
	li $v0, 1
	move  $a0, $s1
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
	j main

countReg:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)	
	sw $s4, 16($sp)
	
	move $s0, $a0 # s0 = reg num
	move $s1, $0 # count
	
	la $s2, countReg # start point
	la $s3, endPoint
	
instructionLoop:
	bge $s2, $s3, endCount
	
	lw $s4, 0($s2) 
	
	srl $t0, $s4, 26 # t0 = opcode
	beq $t0, 0, rType
	j iType
	
rType:
	srl $t1, $s4, 21
	andi $t1, $t1, 31 # 31 = 11111 in binary
	bne $t1, $s0, rTypeRT
	addi $s1, $s1, 1
	
rTypeRT:
	srl $t1, $s4, 16
	andi $t1, $t1, 31 # 31 = 11111 in binary
	bne $t1, $s0, rTypeRD
	addi $s1, $s1, 1
	
rTypeRD:
	srl $t1, $s4, 11
	andi $t1, $t1, 31 # 31 = 11111 in binary
	bne $t1, $s0, nextInstruction
	addi $s1, $s1, 1
	j nextInstruction
	
iType:
	srl $t1, $s4, 21
	andi $t1, $t1, 31 # 31 = 11111 in binary
	bne $t1, $s0, iTypeRT
	addi $s1, $s1, 1
	
iTypeRT:
	srl $t1, $s4, 16
	andi $t1, $t1, 31 # 31 = 11111 in binary
	bne $t1, $s0, nextInstruction
	addi $s1, $s1, 1
	j nextInstruction
	
nextInstruction:
	addi $s2, $s2, 4
	j instructionLoop
	
endCount:
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)	
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra
	
endPoint:
exit:

	li $v0, 10
	syscall	
	
	
	
