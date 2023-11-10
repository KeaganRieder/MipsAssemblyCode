# CPSC 3615 Assignment 3
# By Keagan Rieder
# Code to allow user to input n which is 0<n<12 and then
# calculate the !n

.data
# list varibles
n: .word 0   #  initalize n to 0
result: .word 1   # initalize result to 1

#prompts
prompt_input_n:  .asciiz "please enter a value for n which is ensures the following 0<n<12: \n> "
prompt_input_less_error:  .asciiz "Error n is less 0, ensure it's greater then 0"
prompt_input_greater_error:  .asciiz "Error n is greater then 12, ensure it's less then 12"
prompt_output_n:  .asciiz "The n factorial is: "
new_line:  .asciiz "\n"

#initalizing things
.text
main:
    # input/getting the value of n and 
    # ensuring it's with rules
    input:
        la $a0 prompt_input_n
        li $v0 4
        syscall

        li $v0, 5 # read user input
        syscall

        # checking if inputs valid
        check_if_valid_n:
            # check if n is less then 0
            bgt $v0, 0, greater_than_0
            # input value is less then 0
            la $a0 prompt_input_less_error
            li $v0 4
            syscall
            la $a0 new_line
            li $v0 4
            syscall

            j input

            # check if it's greater then 12
            greater_than_0:
            blt $v0, 12, valid_n

            # input value is greater then 12
            la $a0 prompt_input_greater_error
            li $v0 4
            syscall
            la $a0 new_line
            li $v0 4
            syscall
            j input
        
    valid_n:

        li $t0, 1 # counter for loop
        la $t1, n
        sw $v0 0($t1) # set n to valid inputed value
        move $t1, $v0
        li $t2, 1 # setting the inital result to be 1

# calcutalting n factorial
calculate_n_factorial:
    bgt $t0, $t1, done # check if branch $t0 > $t1
    mul $t2, $t2, $t0  # multiply result by n
    addi $t0, $t0, 1 #increment loop counter
    j calculate_n_factorial

done:
    sw $t2, result
    
# output
output_n_factorial:
    la $a0 prompt_output_n
    li $v0 4
    syscall
    
    lw $a0, result
    li $v0, 1
    syscall

# exit program
exit:
    li $v0, 10
    syscall

