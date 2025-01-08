.data

	.align 4
array:  .space 80
ask_size: .asciiz "Size of array between 1 and 20: "
ask_element: .asciiz "Enter a array element: "
newline: .asciiz "\n"
space: .asciiz " "
display_first: .asciiz "First array: "
display_final: .asciiz "Final array: "

.text

main:
	#ask size
	li $v0, 4
	la $a0, ask_size
	syscall
	
	li $v0, 5
	syscall
	move $t0, $2 # t0 = size
	move $t3, $t0
	
	#check 1-20
	li $t9, 0
	blt $t0, $t9, exit
	li $t9, 20
	bgt $t0, $t9, exit
	
	la $t1, array # t1 = start of arr
	
element_loop:
	beq $t3, 0, exit_element_loop #exit when all elements are processed
	
	#ask for element
	li $v0, 4
	la $a0, ask_element
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t3, $t3, -1
	j element_loop
	
exit_element_loop:

	#display normal array
	li $v0, 4
	la $a0, display_first
	syscall
	
	li $t4, 0
	la $t1, array
	
original_print_loop:
	beq $t4, $t0, exit_original 
	
	#print element
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	#print space
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t4, $t4, 1
	addi $t1, $t1, 4
	
	j original_print_loop
	
exit_original:
	
	li $v0, 4
	la $a0, newline
	syscall
	
	la $t2, array # t2 = start of arr
	addi $t1, $t1, -4 # t1 = end of arr
	move $t3, $t0 
	li $t8, 2
	div  $t3, $t8
	mflo $t3 # t3 = size/2
	
swap:
	beq $t3, $0, exit_swap
	
	lw $t6, 0($t2) #Start
	lw $t7, 0($t1) #End
	
	#Swap
	sw $t7, 0($t2)
	sw $t6, 0($t1)
	
	addi $t2, $t2, 4
	addi $t1, $t1, -4
	addi $t3, $t3, -1
	j swap
	
exit_swap:
	li $v0, 4
	la $a0, display_final
	syscall
	
	li $t4, 0
	la $t1, array

swapped_print_loop:

	beq $t4, $t0, exit
	
	#print element
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	#print space
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t4, $t4, 1
	addi $t1, $t1, 4
	
	j swapped_print_loop
		
exit:
	li $v0, 10
	syscall
