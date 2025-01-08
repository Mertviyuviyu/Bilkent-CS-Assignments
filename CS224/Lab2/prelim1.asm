.data

arrayAddres: .word 0
arraySize: .word 0
ask_size: .asciiz "Enter array size: "
ask_element: .asciiz "Enter element: "
newline: .asciiz "\n"
show_array: .asciiz "Array is: "
show_freq: .asciiz "Frequency Table is: "
space: .asciiz " "
FreqTable: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


.text

main:
	jal createArray
	# v0 = array size, v1 = array address
	
	move $a0, $v0
	move $a1, $v1
	la $a2, FreqTable
	#inputs for findFreq
	
	jal findFreq
	
	li $a0, 11
	la $a1, FreqTable
	la $a2, show_freq
	#using printArray subprogram for printing FreqTable
	
	jal printArray
	
	li $v0, 10
	syscall
	

# no input | return v0 = size v1 = array address
createArray:
	li $v0, 4
	la $a0, ask_size
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 # s0 = size
	
	sll $v0, $v0, 2
	move $a0, $v0 # a0 = size * 4 because of int array
	li $v0, 9
	syscall
	move $s1, $v0 # s1 = array address
	
	addi $sp, $sp, -12
	sw $ra, 0($sp) # save ra = sp
	sw $s0, 4($sp) # size = sp+4
	sw $s1, 8($sp) # address = sp+8
	
	move $a0, $s0 
	move $a1, $s1
	
	jal initializeArray
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	la $a2, show_array
	#load size and array address and message to send to printArray
	
	jal printArray
	
	lw $ra, 0($sp) #restore ra
	lw $v0, 4($sp) #restore size to send to main
	lw $v1, 8($sp) #restore array address to send to main
	
	addi $sp, $sp, 12 #move stackpointer back
	
	jr $ra

# a0 = size, # a1 = array address # a2 = freq table address
findFreq:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	
findFreqLoop:
	beq  $s0, 0, findFreqDone
	lw $s3, 0($s1) # s3 = current element
	bge $s3, 10, incrementHigh
	ble $s3, 9, incrementLow
	
incrementLow:
	sll $s3, $s3, 2 # s3 * 4 for array loc
	add $s4, $s3, $s2 # s4 = location in freqTable
	
	lw $s5, 0($s4)
	addi $s5, $s5, 1
	sw $s5, 0($s4)
	
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	j findFreqLoop

incrementHigh:
	lw $s5, 40($s2)
	addi $s5, $s5, 1
	sw $s5, 40($s2)
	
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	j findFreqLoop	
	
findFreqDone:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
#input a0 = size, a1 = array address | void	
initializeArray:
	move $s0, $a0 # s0 = size
	move $s1, $a1 # s1 = array,
	
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
initializeArrayLoop:
	beq $s0, 0, initializeArrayDone
	
	li $v0, 4
	la $a0, ask_element
	syscall
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	sw $s2, 0($s1)
	
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	j initializeArrayLoop

initializeArrayDone:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
#input a0 = size, a1 = array address, a2 = message | void	
printArray:
	move $s0, $a0
	move $s1, $a1
	
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
	li $v0, 4
	move $a0, $a2
	syscall
	
printArrayLoop:
	beq $s0, 0, printArrayDone
	
	li $v0, 1
	lw $a0, 0($s1)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	j printArrayLoop
	
printArrayDone:
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra
