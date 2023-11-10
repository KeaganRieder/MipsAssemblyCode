# CPSC 3615 Lab 4
# By Keagan Rieder
# Code to allow user to input size of an array and then add element
# then takes the inputed array sorts it and then outputs that sorted
# array back to the user


#varible decleration
.data
# list varibles
integer1: .word 0   # allocate space for integer1
integer2: .word 0   # allocate space for integer2
result: .word 0   # allocate space for results


# prompt varibles
prompt_input_integer1:  .asciiz "Please enter integer on the left side of the equation: \n> "
prompt_input_integer2:  .asciiz "Please enter integer on the right side of the equation: \n> "
prompt_output_zero_error:  .asciiz "\nError: attempted to divied by zero"
prompt_output_addition_result: .asciiz "\nThe result from addition is: "
prompt_output_subtraction_result: .asciiz "\nThe result from subtraction is: "
prompt_output_multiplication_result: .asciiz "\nThe result from multiplication is: "
prompt_output_division_result: .asciiz "\nThe result from division is: "
prompt_space: .asciiz " "

# initalizing Varibles
# and perfom inital set up
.text
main:

    # getting the value of integer 1
    la $a0 prompt_input_integer1 
    li $v0 4
    syscall

    li $v0, 5 # read user input
    syscall
    
    la $t0 integer1
    sw $v0 0($t0)
    move $t0,$v0

    # getting the value of integer 2
    la $a0 prompt_input_integer2 
    li $v0 4
    syscall

    li $v0, 5 # read user input
    syscall
    
    la $t1 integer2
    sw $v0 0($t1)
    move $t1,$v0

    #setting results up
   
#doing operations on numbers
addition_operation:
    add $t2, $t0, $t1
    sw $t2, result

output_addition_Results:
    # outputting prompt
    la $a0, prompt_output_addition_result    
    li $v0, 4                      
    syscall

    # outputing results
    lw $a0, result 
    li $v0, 1
    syscall
subtraction_operation:
    sub $t2, $t0, $t1
    sw $t2, result
output_subtraction_Results:
    # outputting prompt
    la $a0, prompt_output_subtraction_result    
    li $v0, 4                      
    syscall

    # outputing results
    lw $a0, result 
    li $v0, 1
    syscall

multiplication_operation:
    mult $t0, $t1
    mflo $t2  #moving result to t2
    sw $t2, result # storing result
output_multiplication_Results:
    #outputting prompt
    la $a0, prompt_output_multiplication_result  
    li $v0, 4                      
    syscall

    # outputing results
    lw $a0, result 
    li $v0, 1
    syscall

division_operation:
    beq $t1, $0, output_divided_by_zero_error # checking if divisor(t1) is equail to zero, then outputting error
    
    div  $t0, $t1
    mflo $t2 #moving result to t2
    sw $t2, result # storing result

output_division_Results:
    # outputting prompt
    la $a0, prompt_output_division_result   
    li $v0, 4                      
    syscall
    
    # outputing results
    lw $a0, result 
    li $v0, 1
    syscall
    j exit

output_divided_by_zero_error:
    # outputting prompt
    la $a0, prompt_output_zero_error    
    li $v0, 4                      
    syscall
    j exit

exit:
    # exit program
    li $v0, 10
    syscall