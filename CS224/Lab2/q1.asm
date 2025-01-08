.data

ask_reg: .asciiz "Enter register value (integer): "
ask_continue: .asciiz "Do you want to continue (y or n): "
show_invalid: .asciiz "Invalid character! \n"
new_line: .asciiz "\n"
show_hex: .asciiz "Hexadecimal of register: "
show_hamming: .asciiz "Hamming Distance is: "
newline: .asciiz "\n"
goodbye: .asciiz "Goodbye!"
buff: .space 4

.text

main:
	jal askRegister
	move $t0, $v0 # t0 = first reg
	jal askRegister
	move $t1, $v0 # t1 = second reg	
	
	move $a0, $t0
	jal printHex
	move $a0, $t1
	jal printHex
	
	move $a0, $t0
	move $a1, $t1
	
	jal calculateHamming
	
	move $t2, $v0 # t2 = hamming dsitance
	
	li $v0, 4
	la $a0, show_hamming
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	jal askContinue
	
		
	#exit
	li $v0, 4
	la $a0, goodbye
	syscall

	li $v0, 10
	syscall
	
	
# no input | output v0 = integer read from the user
askRegister:
	li $v0, 4
	la $a0, ask_reg
	syscall
	
	li $v0, 5
	syscall
	jr $ra

# a0 = value of register to get printed
printHex:
	move $s0, $a0
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $v0, 4
	la $a0, show_hex
	syscall
	
	li $v0, 34
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, new_line
	syscall
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

# a0 = first reg, a1 = second reg | v0 = hamming distance
calculateHamming:
	xor $s0, $a0, $a1
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $s2, 0 # counter
	
calculateHammingLoop:
	beq $s0, 0, calculateHammingDone
	
	andi $s1, $s0, 1 # to get the value of LSB ( s1 & 0000000000001)
	beq $s1, 0, calculateHammingSkip
	
	addi $s2, $s2, 1
	srl $s0, $s0, 1
	j calculateHammingLoop

calculateHammingSkip:
	srl $s0, $s0, 1
	j calculateHammingLoop

calculateHammingDone:
	lw $s0, 0($sp)
	addi $sp, $sp, 4 # restore s0
	
	move $v0, $s2 # move result to v0
	
	jr $ra
	
askContinue:
	li $v0, 4
	la $a0, ask_continue
	syscall
	
	li $v0, 8
	la $a0, buff
	li $a1, 4
	syscall
	
	lb $s0, buff
	li $s1, 'y'
	beq $s0, $s1, askContinueCont
	li $s1, 'n'
	beq $s0, $s1, askContinueBye
	
	j askContinueInvalid
	
askContinueCont:
	j main
	
askContinueBye:
	jr $ra
	
askContinueInvalid:
	li $v0, 4
	la $a0, show_invalid
	syscall
	j askContinue
