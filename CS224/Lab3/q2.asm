.data

ask_key: .asciiz "Enter product number (-1 to stop): "
ask_data: .asciiz "Enter number of copies: "
newline: .asciiz "\n"
arrow: .asciiz " --> "
openPar: .asciiz "("
closePar: .asciiz ")"
comma: .asciiz ", "
show_org: .asciiz "Original List: "
show_rev: .asciiz "Reverse List: "


.text

main:
	jal createList
	move $s0, $v0
	
	li $v0, 4
	la $a0, show_org
	syscall
	
	move $a0, $s0
	jal printList
	
	li $v0, 4
	la $a0, newline
	syscall
	
	move $a0, $s0
	jal reverseList
	move $s0, $v0
	
	li $v0, 4
	la $a0, show_rev
	syscall
	
	move $a0, $s0
	jal printList
	
	li $v0, 10
	syscall
	
# no input | output v0 = linkedlist head
createList:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	li $s0, 0
createListLoop:
	la $a0, ask_key
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0 # t0 = product Num
	beq $t0, -1, createListEnd
	
	la $a0, ask_data
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 # t1 = copies
	
	#new node
	li $v0, 9
	li $a0, 12
	syscall
	
	sw $t0, 0($v0)
	sw $t1, 4($v0)
	sw $0, 8($v0) # next = 0
	
	beq $s0, 0, addHead
	
	move $s2, $s0 #curr 
	li $s3, 0 #prev
	
createList_findPos:
	beq $s2, 0, insertLast
	lw $t3, 0($s2) # t3 = curr productNum
	bgt $t3, $t0, insertBetween
	move $s3, $s2 # prev = curr
	lw $s2, 8($s2) # curr = curr.next
	j createList_findPos
	
insertBetween:
	beq $s3, 0, addHead
	sw $s2, 8($v0) # insert.next = curr
	sw $v0 8($s3) # prev.next = insert
	# finally prev -> insert -> curr
	j createListLoop

addHead:
	sw $s0, 8($v0) # curr.next = head (s0)
	move $s0, $v0 # head = curr
	j createListLoop
insertLast:
	sw $v0, 8($s3)
	j createListLoop
	
createListEnd:
	move $v0, $s0 # return head with v0
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
#input: a0 = head of linkedlist | output: none
printList:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	move $s0, $a0
printListLoop:
	beq $s0, 0, printListEnd
	
	la $a0, arrow
	li $v0, 4
	syscall
	
	la $a0, openPar
	li $v0, 4
	syscall
	
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	
	la $a0, comma
	li $v0, 4
	syscall
	
	li $v0, 1
	lw $a0, 4($s0)
	syscall
	
	la $a0, closePar
	li $v0, 4
	syscall
	
	lw $s0, 8($s0)
	j printListLoop
	
printListEnd:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
# a0 = head of ori | v0 = reverse head
reverseList:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)

	li $s0, 0 # pre
	move $s1, $a0 # curr
	li $s2, 0  # next

reverseListLoop:
	beq $s1, 0, reverseListDone
	
	lw $s2, 8($s1)
	sw $s0, 8($s1)
	
	move $s0, $s1
	move $s1, $s2
	
	j reverseListLoop
	
reverseListDone:
	move $v0, $s0
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)	
	addi $sp, $sp, 16
	
	jr $ra
	