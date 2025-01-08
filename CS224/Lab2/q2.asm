.data

ask_reg: .asciiz "Enter register value (integer): "
show_hex: .asciiz "Hexadecimal of register: "
show_reverse: .asciiz "Hexadecimal of reversed register: "
newline: .asciiz "\n"
ask_continue: .asciiz "Do you want to continue (y or n): "
show_invalid: .asciiz "Invalid character! \n"
goodbye: .asciiz "Goodbye!"
buff: .space 4

.text

main:
	jal askRegister
	move $t0, $v0
	
	move $a0, $t0
	la $a1, show_hex
	jal printHex
	
	move $a0, $t0
	jal reverseRegister
	
	move $a0, $v0
	la $a1, show_reverse
	jal printHex
	
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
	
# a0 = value of register to get printed, a1 = message address
printHex:
	move $s0, $a0
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $v0, 4
	move $a0, $a1
	syscall
	
	li $v0, 34
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

# a0 = input num | v0 = reversed of input
reverseRegister:
	move $s0, $a0
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $s1, 0 # result
	li $s2, 32 # counter
	
reverseRegisterLoop:
	beq $s2, 0, reverseRegisterDone
	
	andi $s4, $s0, 1
	sll $s1, $s1, 1
	or $s1, $s1, $s4
	srl $s0, $s0, 1
	addi $s2, $s2, -1
	
	j reverseRegisterLoop
reverseRegisterDone:
	move $v0, $s1
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	
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
	
