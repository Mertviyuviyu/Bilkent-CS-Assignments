
.data

askB: .asciiz "Enter B: "
askC: .asciiz "Enter C: "
askD: .asciiz "Enter D: "
promptA: .asciiz "A is: "
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
	li $v0, 4
	la $a0, askD
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0 # t2 = D

	move $t3, $t0 # t3 = B also
	li $t4, 0 # t4 = counter
	
division:

	blt $t3, $t1, end_div # if B < C end loop
	sub $t3, $t3, $t1 # B = B - C
	addi $t4, $t4, 1 # increment counter
	j division
	
end_div:

	# t4 = B/C # t0 = B # t1 = C # t2 = D
	move $t3, $t2 # t3 = D
	
modulo:

	blt $t3, $t0, end_modulo
	sub $t3, $t3, $t0 # D = D - B
	j modulo
	
end_modulo:
	# t3 = D mod B # t4 = B/C # t0 = B # t1 = C # t2 = D
	
	# t4 = (B/C + (D mod B) - C)
	add $t4, $t4, $t3
	sub $t4, $t4, $t1
	move $t3, $t0 # t3 = B
	li $t5, 0 #counter
	
second_div:

	blt $t4, $t3, print_result
	sub $t4, $t4, $t3 # t4 = t4 - B
	addi $t5, $t5, 1
	j second_div

print_result:
	
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
	
	