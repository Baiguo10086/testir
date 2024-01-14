.data
array: .space 400
_prmpt: .asciiz "Enter an integer: "
_eol: .asciiz "\n"
.globl main
.text
read:
  li $v0, 4
  move $s6, $a0
  la $a0, _prmpt
  syscall
  move $a0, $s6
  li $v0, 5
  syscall
  jr $ra
write:
  li $v0, 1
  syscall
  li $v0, 4
  move $s6, $a0
  la $a0, _eol
  syscall
  move $a0, $s6
  move $v0, $0
  jr $ra
fact:
  li $t5, 1
  beq $a0, $t5, label1
  j label2
label1:
  move $v0, $a0
  jr $ra
label2:
  addi $s0, $a0, -1
  sw $s0, array + 0 
  addi $sp, $sp, -8 
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  lw $a0, array + 0
  jal fact
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  addi $sp, $sp, 8 
  move $s0, $v0
  sw $s0, array + 4
  lw $t0, array + 4 
  mul $s0, $a0, $t0
  sw $s0, array + 8 
  lw $t0, array + 8 
  move $v0, $t0
  jr $ra
main:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal read
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  move $s0, $v0
  move $s0, $v0
  sw $s0, array + 12
  lw $t0, array + 12 
  move $s0, $t0
  sw $s0, array + 16 
  lw $t0, array + 16 
  li $t5, 1
  bgt $t0, $t5, label3
  j label4
label3:
  addi $sp, $sp, -8 
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  lw $a0, array + 16
  jal fact
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  addi $sp, $sp, 8 
  move $s0, $v0
  sw $s0, array + 20
  lw $t0, array + 20 
  move $s0, $t0
  sw $s0, array + 24 
  j label5
label4:
  li $s0, 1
  sw $s0, array + 24 
label5:
  move $t7,$a0 
  move $a0, $s0
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal write
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  move $a0,$t7 
  li $v0, 0
  jr $ra