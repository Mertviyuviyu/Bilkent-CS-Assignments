.data

ask_size: .asciiz "Enter the matrix size N for (NxN) matrix: "
newline:    .asciiz "\n"
space: .asciiz " "
show_rowsum: .asciiz "Row by row sum of matrix:  "
show_colsum: .asciiz "Col by col sum of matrix: "
ask_row: .asciiz "Enter row (1-indexed): "
ask_col: .asciiz "Enter col (1-indexed): "
show_specific: .asciiz "Specified element is: "
menu: .asciiz "\n1. Print Matrix\n2. Find Sum Row by Row\n3. Find Sum Column by Column\n4. Display Specific Element\n5. Exit\nEnter your choice: "

.text

main:
	li $v0, 4
	la $a0, ask_size
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	move $s2, $v0
	
	mul $s0, $s0, $s0
	sll $s0, $s0, 2  # s0*4 for arr size
	
	move $a0, $s0
	li $v0, 9
	syscall
	
	srl $s0, $s0, 2 # s0 = N^2
	move $s1, $v0 # s1 = arr adress #s2 = N
	
	move $a0, $s1 # a0 = arr address
	move $a1, $s0 # a1 = arr size (N^2)
	jal initMatrix
	
	j user_interface
user_interface:
	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, call_printMatrix
	beq $t0, 2, call_findSumRow
	beq $t0, 3, call_findSumCol
	beq $t0, 4, call_displaySpecific
	beq $t0, 5, exit_program
	j user_interface
call_printMatrix:
	move $a0, $s1 #a0 = arr address
	move $a1, $s2 #a1 = N
	jal printMatrix
	j user_interface

call_findSumRow:
	move $a0, $s1 #a0 = arr address
	move $a1, $s2 #a1 = N
	jal findSumRow
	j user_interface

call_findSumCol:
	move $a0, $s1 #a0 = arr address
	move $a1, $s2 #a1 = N
	jal findSumCol
	j user_interface

call_displaySpecific:
	move $a0, $s1 #a0 = arr address
	move $a1, $s2 #a1 = N
	jal displaySpecific
	j user_interface

exit_program:
	li $v0, 10
	syscall		
	
initMatrix:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	move $s0, $a0 #s0 = array
	move $s1, $a1 #s1 = size
	li $s2, 0
	li $s3, 1
	
initMatrixLoop:
	beq $s1,$s2, initMatrixEnd
	sw $s3, 0($s0)
	#addi $s3,$s3, 1 commented for analysis causing overflow for large values
	addi $s0, $s0, 4
	addi $s2, $s2, 1
	j initMatrixLoop
initMatrixEnd:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra

printMatrix:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	move $s0, $a0 #adress
	move $s1, $a1 # N
	mul $s2, $a1, $a1 # s2 = N^2
	li $s3, 0
	li $t6, 0
	move $s4, $a0 #s4 = address
	
printMatrixLoop:
	beq $s3, $s1, printMatrixNext
	
	lw $a0, 0($s0)
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	mul $t5, $s1, 4
	add $s0, $s0, $t5
	addi $s3, $s3, 1
	addi $t6, $t6, 1
	
	j printMatrixLoop
printMatrixNext:
	beq $t6, $s2, printMatrixEnd
	
	li $s3, 0
	addi $s4, $s4, 4
	move $s0, $s4
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j printMatrixLoop
printMatrixEnd:
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra

findSumRow:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	move $s0, $a0 #adress
	move $s1, $a1 # N
	mul $s2, $a1, $a1 # s2 = N^2
	li $s3, 0
	li $t6, 0
	move $s4, $a0 #s4 = address
	li $t7, 0

findSumRowLoop:
	beq $s3, $s1, findSumRowNext
	
	lw $a0, 0($s0)	
	add $t7, $t7, $a0
	
	mul $t5, $s1, 4
	add $s0, $s0, $t5
	addi $s3, $s3, 1
	addi $t6, $t6, 1
	
	j findSumRowLoop
findSumRowNext:
	beq $t6, $s2, findSumRowEnd
	
	li $s3, 0
	addi $s4, $s4, 4
	move $s0, $s4
	
	j findSumRowLoop
findSumRowEnd:
	li $v0, 4
	la $a0, show_rowsum
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
findSumCol:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	move $s0, $a0 #adress
	move $s1, $a1 # N
	mul $s2, $a1, $a1 # s2 = N^2
	li $s3, 0
	li $t7, 0 #counter
findSumColLoop:
	beq $s3, $s2, findSumColEnd
	
	lw $a0, 0($s0)	
	add $t7, $t7, $a0
	
	addi $s0, $s0, 4
	addi $s3, $s3, 1
	
	j findSumColLoop
findSumColEnd:	
	li $v0, 4
	la $a0, show_colsum
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
displaySpecific:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	move $s0, $a0 #adress
	move $s1, $a1 # N
	mul $s2, $a1, $a1 # s2 = N^2
	
	la $a0, ask_row
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t6, $v0 #t6 = row
	addi $t6, $t6, -1
	
	li $v0,4
	la $a0, ask_col
	syscall
	
	li $v0, 5
	syscall
	move $t7, $v0 #t7 = col
	addi $t7, $t7, -1
	
	mul $t6, $t6, 4
	add $s0, $s0, $t6
	
	mul $t7, $t7, 4
	mul $t7, $t7, $s1
	
	add $s0, $s0, $t7
	
	la $a0, show_specific
	li $v0, 4
	syscall
	
	lw $a0, 0($s0)
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
