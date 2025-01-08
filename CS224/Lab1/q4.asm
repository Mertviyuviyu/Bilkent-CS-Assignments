.data

       .align 4
array: .space 400

buffer: .space 4
ask_size: .asciiz "Enter array size (max 100): "
ask_element: .asciiz "Enter element: "
str_menu: .asciiz "\na. Find the maximum number\nb. Find the number of times the maximum number appears in the array.\nc. Find divisor count of maximum number\nd. Quit\nEnter choice: "
show_arr: .asciiz "Array is: "
space: .asciiz " "
show_max:    .asciiz "Maximum number: "
show_count:  .asciiz "Count of maximum number: "
show_div:    .asciiz "Number of divisors: "
show_invalid:.asciiz "Invalid option. Please try again."
goodbye_msg: .asciiz "Goodbye!"

.text

main:
	li $v0, 4
	la $a0, ask_size
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 # t0 = size
	
	la $t1, array
	move $t2, $t0 # t2 = size for count

element_loop:
	beq $t2, $0, print_arr
	
	li $v0, 4
	la $a0, ask_element
	syscall
	
	li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	j element_loop

print_arr:
	move $t2, $t0
	la $t1, array
	
	li $v0, 4
	la $a0, show_arr
	syscall
	
print_arr_loop:
	beq $t2, 0, find_max
	#print val
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	#print space
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	j print_arr_loop
	
find_max:
	la $t1, array # t1 = start of arr
	lw $t4, 0($t1) # t4 = first element which will hold max
	move $t6, $t0 #t6 = size
	
find_max_loop:
	beq $t6, 0, count_max
	lw $t5, 0($t1) # t5 = next element
	addi $t1, $t1, 4
	addi $t6, $t6, -1
	ble $t4, $t5, new_max
	j find_max_loop
new_max:
	move $t4, $t5 # t4 = t5 (new max)
	j find_max_loop
	
count_max:
	la $t1, array
	move $t6, $t0 # t6 = size
	li $t7, 0 #count
	
count_max_loop:
	beq $t6, 0, find_divisor # bura calc divisor
	lw $t8, 0($t1)
	addi $t1, $t1, 4
	addi $t6, $t6, -1
	beq $t8, $t4, incr_max
	j count_max_loop
incr_max:
	addi $t7, $t7, 1
	j count_max_loop
	
find_divisor:
	la $t1, array
	move $t2, $t0 # t2 = size
	li $t8, 0 # counter
divisor_loop:
	beq $t2, 0, menu
	lw $t5, 0($t1) # current element
	beq $t5, $t4, skip_divisor # t5 = max so skip
	rem $t6, $t4, $t5 # t6 = max mod current
	beq $t6, 0, increment_divisor # if rem is 0 increment divisor count
	j skip_divisor # does not divide max so skip
skip_divisor:
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	j divisor_loop
increment_divisor:
	addi $t8, $t8, 1
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	j divisor_loop
	
# t0 t4 t7 t8 dont change
menu:
	li $v0, 4
	la $a0, str_menu
	syscall
	
	#read char
	li $v0, 8
	la $a0, buffer
	li $a1, 4
	syscall 
	
	lb $t2, buffer # t2 = choice
	
	li $t3, 'a'
	beq $t2, $t3, print_max
	li $t3, 'b'
	beq $t2, $t3, print_count
	li $t3, 'c'
	beq $t2, $t3, print_divisor
	li $t3, 'd'
	beq $t2, $t3, quit
	j invalid
	
print_max:
	li $v0, 4
	la $a0, show_max
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	j menu
	
print_count:
	li $v0, 4
	la $a0, show_count
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	j menu
	
print_divisor:
	li $v0, 4
	la $a0, show_div
	syscall
	
	li $v0, 1
	move $a0, $t8
	syscall
	
	j menu

invalid:
	li $v0, 4
	la $a0, show_invalid
	syscall
	
	j menu
quit:
	li $v0, 4
	la $a0, goodbye_msg
	syscall
	
	li $v0, 10
	syscall
	
	
	
	
	
	
