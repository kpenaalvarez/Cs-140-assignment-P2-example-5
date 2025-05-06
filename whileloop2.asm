# Title:	lab  A P2		Filename: whileloop2.asm
# Author: 	Kevin Peña	Date: 5/6/25
# Description:
# Input:
# Output:
################# Data segment #####################
.data
num:    .word 10, 20, 30, 40, 50  
N:      .word 45                   
################# Code segment #####################
.text
.globl main

main:
    # Initialize
    li  $t1, 0   # i = 0 (stored in $t1)
    la  $t0, num   # Load the address of num[] into $t0
    la  $t2, N   # Load address of N
    lw  $t2, 0($t2)  # Load N (45) into $t2

    # Initialize result register
    li  $t6, -1    # Set $t6 to -1 initially (indicating not found yet)

loop:
    # Load num[i] into $t3
    mul $t3, $t1, 4   # Multiply i by 4 (offset in bytes)
    add $t4, $t0, $t3    # Add offset to the base address of num[] to get num[i]
    lw  $t3, 0($t4)    # Load num[i] into $t3

    # Check if num[i] <= N
    ble $t3, $t2, continue_loop   # If num[i] <= N, continue the loop

    # If num[i] > N, store the index in $t6
    move $t6, $t1    # Store index in $t6 (the final result)

    # Exit the loop
done:
    # Print the result (index)
    li  $v0, 1   # Print integer syscall
    move $a0, $t6   # Move result into $a0 for printing
    syscall

    # Exit program
    li  $v0, 10    # Exit syscall
    syscall

continue_loop:
    # Increment i
    addi $t1, $t1, 1               # i += 1

    # Repeat the loop
    j loop