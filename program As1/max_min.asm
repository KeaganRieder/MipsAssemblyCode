# CPSC 3615 Programming assignment 1
# By Keagan Rieder
# Code to allow input size of list and elements
# and then outputing the list after finding the
# min and max numbers of that list

# varibles
.data
list_size:   .word 0            # Variable to store the list size
list:        .space 100         # Allocate space for the list (adjust size as needed)

# variables to store minimum and maximum values
min_value:   .word 0
max_value:   .word 0

#varibles for prompts to user
prompt_input_size:  .asciiz "Please enter size of list: \n> "
prompt_input_element: .asciiz "please enter the element: \n> "
prompt_output_element: .asciiz "The provided list: "
prompt_output_max: .asciiz "\nThe Max element is: "
prompt_output_min: .asciiz "\nThe min element is: "
prompt_space: .asciiz " "

# text section of the program
# initalzing/setting up size of the list and other varibles
.text 
main:

    #prombting user to input size of the list
    la $a0 prompt_input_size # load address of prompt string to address a0
    li $v0 4                 # print string
    syscall

    # inputing the size of syscall of v0 = 5
    li $v0, 5                # read user input
    syscall

    # copying size from v0 to the varible size
    la $t0, list_size    # load the address of size to t0
    sw $v0, 0($t0)       # store $v0 to the address of t0
    move $a1, $v0        # copy the size to a1

    # inputting the elements of the list
    li $s1, 0       # set the value of index of s1 to be initally 0
    la $t0, list    # load the address of the list in $t0
    li $t2, 0       # set the offset t2 to be initally 0

#promting user to input element for current index of the list
input_loop:
    addi $s1, $s1, 1                #increase index by 1
    bgt $s1, $a1, end_input_loop    #ends input loop if the current value of index>size

    # print proment to user to have them input element
    la $a0, prompt_input_element    # load address of prompt_input_element
    li $v0, 4                       # print string
    syscall

    # take the input
    li $v0, 5   # read user input
    syscall

    #add element to the list
    add $t3, $t0, $t2   # calculating the address to store data
    sw $v0, 0($t3)      # saving the input

    addi $t2, $t2, 4    # moving to next index
    j input_loop  
end_input_loop:

#loop to find min max value
#initalizing min and max values
    la $t1, min_value   # load address of min to t1
    lw $t1, 0($t0)      # set inital min value to be first element of list

    la $t4, max_value   # load address of max to t4
    lw $t4, 0($t0)      # set inital max value to be first element of list

    li $s1, 0       # setting the value of index of the s1 to be 0
    la $t0, list    # loading the address of list in $t0
    li $t2, 0       # t2 is the offset and is initally set to 0
min_max_loop:
    addi $s1, $s1, 1                #increase index by 1
    bgt $s1, $a1, end_min_max_loop    #ends input loop if the current value of index>size

    add $t3, $t0, $t2   # calculating current address
    lw $t5, 0($t3)
    blt $t5, $t1,   update_min #check if current element in list is greater then max value
    bgt $t5, $t4, update_max #check if current element in list is greater then max value
    j continue_loop
update_min:
    lw $t1,  0($t3) # updating min
    j continue_loop
update_max:
    lw  $t4,  0($t3) # updating max

continue_loop:
    addi $t2, $t2, 4 # moving to next index
    j min_max_loop  # Continue the loop
end_min_max_loop:


# printing the elemnts in the list
    # prompt 
    la $a0, prompt_output_element    # load adrees of prompt to a0
    li $v0, 4                        # print string, syscall, v0 = 4
    syscall

    la $t0, list_size    # loading address of size to t0
    lw $a1, 0($t0)  # copy the size to a1

    li $s1, 0       # setting the value of index of the s1 to be 0
    la $t0, list    # loading the address of list in $t0
    li $t2, 0       # t2 is the offset and is initally set to 0

# loop to output the list
output_loop:
    addi $s1, $s1, 1                # increment the index by 1
    bgt $s1, $a1, end_output_loop   # end output if index is greater then size

    #printing the elemnt
    add $t3, $t0, $t2   # calculating the address for current element
    lw $a0, 0($t3)      # load the current element to a0, and syscall
    li $v0, 1

    syscall

    #print spaces
    la $a0, prompt_space    # load address of prompt space
    li $v0, 4               # print string, syscall, v0 = 4
    syscall

    addi $t2, $t2, 4 # offset to next space

    j output_loop

end_output_loop:

#print min and max values
# # Load and print the minimum value
la $a0, prompt_output_min   # Load address of the "The min element is:" message
li $v0, 4                   # Print string
syscall

move $a0, $t1           # Load the minimum value
li $v0, 1                   # Print integer
syscall

la $a0, prompt_output_max   # Load address of the "The min element is:" message
li $v0, 4                   # Print string
syscall

move $a0, $t4           # Load the max value
li $v0, 1               # Print integer
syscall



#exit program
li $v0, 10
syscall


