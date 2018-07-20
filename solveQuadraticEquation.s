.data
	message1: .asciiz "Give a: "
	message2: .asciiz "\nGive b: "
	message3: .asciiz "\nGive c: "
	message4: .asciiz " < 0, no roots!"
	message5: .asciiz " == 0, one (double) root!"
	message6: .asciiz "\nRoots r1, r2 = "
	message7: .asciiz " > 0, two roots!"
	message8: .asciiz "\nRoot r1 = "
	message9: .asciiz "\nRoot r2 = "
	messageD: .asciiz "\nD = "
	messageExit: .asciiz "\nExiting program..."
	newLine: .asciiz "\n"
	float0: .float 0.0
	floatNegative: .float -1.0
	float4: .float 4.0
	float2: .float 2.0
.text
.globl __start
__start:
	# loaf float 0, float -1.0, float 4, float 2
	l.d $f8, float0
	l.d $f28, floatNegative
	l.d $f30, float4
	l.d $f26, float2

	# request a
	li $v0, 4
	la $a0, message1
	syscall
	
	# read a
	li $v0, 6
	syscall
	
	# store a
	add.s $f2, $f0, $f8
	
	# provide feedback to user
	li $v0, 2
	add.s $f12, $f2, $f8
	syscall

	# request b
	li $v0, 4
	la $a0, message2
	syscall
	
	# read b
	li $v0, 6
	syscall
	
	# store b
	add.s $f4, $f0, $f8
	
	# provide feedback to user
	li $v0, 2
	add.s $f12, $f4, $f8
	syscall

	# request c
	li $v0, 4
	la $a0, message3
	syscall
	
	# read c
	li $v0, 6
	syscall
	
	# store c
	add.s $f6, $f0, $f8
	
	# provide feedback to user
	li $v0, 2
	add.s $f12, $f6, $f8
	syscall
	
	# b^2
	mul.s $f10, $f4, $f4
	
	# 4*a*g
	mul.s $f14, $f2, $f6
	mul.s $f14, $f14, $f30

	sub.s $f14, $f10, $f14
	
	li $v0, 4
	la $a0, messageD
	syscall
	li $v0, 2
	add.s $f12, $f14, $f8
	syscall
	
	# check D
	c.le.s $f14, $f8
	bc1t DeltaNoPositive
	sqrt.s $f14, $f14
	mul.s $f4, $f4, $f28
	add.s $f16, $f4, $f14
	mul.s $f14, $f14, $f28
	add.s $f18, $f4, $f14
	mul.s $f2, $f2, $f26
	div.s $f16, $f16, $f2
	div.s $f18, $f18, $f2
	li $v0, 4
	la $a0, message7
	syscall
	li $v0, 4
	la $a0, message8
	syscall
	li $v0, 2
	add.s $f12, $f16, $f8
	syscall
	li $v0, 4
	la $a0, message9
	syscall
	li $v0, 2
	add.s $f12, $f18, $f8
	syscall
	j Exit	
	
DeltaNoPositive:
	c.eq.s $f14, $f8
	bc1t DeltaZero
	li $v0, 4
	la $a0, message4
	syscall
	j Exit
	
DeltaZero:
	mul.s $f4, $f4, $f28
	mul.s $f2, $f2, $f26
	div.s $f16, $f4, $f2
	li $v0, 4
	la $a0, message5
	syscall
	li $v0, 4
	la $a0, message6
	syscall
	li $v0, 2
	add.s $f12, $f16, $f8
	syscall
	
	# exit program
Exit:
	li $v0, 4
	la $a0, messageExit
	syscall
	li $v0, 10
	syscall