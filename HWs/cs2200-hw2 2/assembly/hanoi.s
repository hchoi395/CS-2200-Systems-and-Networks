!============================================================
! CS 2200 Homework 2 Part 2: Tower of Hanoi
!
! Apart from initializing the stack,
! please do not edit mains functionality. You do not need to
! save the return address before jumping to hanoi in
! main.
!============================================================

main:
    add     $zero, $zero, $zero     ! TODO: Here, you need to get the address of the stack
    lea     $sp,    stack                                ! using the provided label to initialize the stack pointer.
                                    ! load the label address into $sp and in the next instruction,
    lw      $sp, 0($sp)             ! use $sp as base register to load the value (0xFFFF) into $sp.


    lea     $at, hanoi              ! loads address of hanoi label into $at

    lea     $a0, testNumDisks2      ! loads address of number into $a0
    lw      $a0, 0($a0)             ! loads value of number into $a0

    jalr    $ra, $at                ! jump to hanoi, set $ra to return addr
    halt                            ! when we return, just halt

hanoi:
    add     $zero, $zero, $zero     ! TODO: perform post-call portion of
    addi    $sp,    $sp,    -1                                   ! the calling convention. Make sure to
    sw      $fp,   0($sp)
    addi    $fp,   $sp,   0                                ! save any registers you will be using!

    add     $zero, $zero, $zero     ! TODO: Implement the following pseudocode in assembly:
    addi    $t0,   $zero,  2
    blt     $t0,   $a0,    else
    addi    $t0,   $zero,   1
    blt     $t0,    $a0,    else                             !    GOTO base
    br  base

else:
    add     $zero, $zero, $zero     ! TODO: perform recursion after decrementing
    addi    $a0,   $a0,   -1                                ! the parameter by 1. Remember, $a0 holds the
    addi    $sp,   $sp,   -1
    sw      $ra,   0($sp)
    addi    $sp,   $sp,    -1
    sw      $a0,   0($sp)
    lea     $at,   hanoi
    jalr    $ra,   $at 
    lw      $ra,   -1($fp)
    addi    $sp, $sp, 2

    add     $zero, $zero, $zero     ! TODO: Implement the following pseudocode in assembly:
    add     $v0,    $v0,    $v0
    addi    $v0,    $v0,    1                                ! $v0 = 2 * $v0 + 1
    br teardown                                ! RETURN $v0

base:
    add     $zero, $zero, $zero     ! TODO: Return 1
    addi    $v0,    $v0,    1
teardown:
    add     $zero, $zero, $zero     ! TODO: perform pre-return portion
    lw      $fp,   0($fp)
    addi    $sp,    $sp,    1                                ! of the calling convention
    jalr    $zero, $ra              ! return to caller



stack: .word 0xFFFF                 ! the stack begins here


! Words for testing \/

! 1
testNumDisks1:
    .word 0x0001

! 10
testNumDisks2:
    .word 0x000a

! 20
testNumDisks3:
    .word 0x0014
