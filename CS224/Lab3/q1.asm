.data

ask_first: .asciiz "Enter first number (0 to exit): "
ask_second: .asciiz "Enter second number (0 to exit): "
show_result: .asciiz "Result: "
newline: .asciiz "\n"

.text

main:
	li $v0, 4
	la $a0, ask_first
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	beq $s0, 0, exit
	
	li $v0, 4
	la $a0, ask_second
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	

	beq $s1, 0, exit
	
	move $a0, $s0
	move $a1, $s1
	jal division
	
	move $s2, $v0
	
	li $v0, 4
	la $a0, show_result
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j main
# a0 = first , a1 = second | v0 = result
division:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	blt $a0, $a1, endDiv
	
	sub $a0, $a0, $a1

	jal division
	addi $v0, $v0, 1
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
endDiv:
	li $v0, 0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

exit:
	li $v0, 10
	syscall
