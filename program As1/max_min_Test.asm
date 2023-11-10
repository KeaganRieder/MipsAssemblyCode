# CPSC 3615 Programming assignment 1
# By Keagan Rieder
# Code to allow input size of list and elements
# and then outputing the list after finding the
# min and max numbers of that list

# text section of the program
# initalzing/setting up size of the list and other varibles
.text 
main:

#prombting user to input size of the list
la $a0 prompt_input_size # load address of prompt string to address a0
li $v0 4                 # print string, syscall, v0 = 4
syscall

# inputing the size of syscall of v0 = 5
li $v0,5 # Load Immediate value of 5 to address v0
syscall

# copying size from v0 to the varible size
la $t0, size    # load the address of size to t0
sw $v0, 0($t0)  # store $v0 to the adress of t0
move $a1, $v0   # copy the size to a1

# inputting the elements of the list
li $s1, 0       # setting the value of index of s1 to be initally 0
la $t0, list    # loading the adress of the list in $t0
li $t2, 0       # setting the offset t2 to be initally 0

#
#promting user to input element for current index of the list
input_loop:
 addi $s1, $s1, 1                #increase index by 1
 bgt $s1, $a1, end_input_loop    #ends input loop if the current value of index>size

# print proment to user to have them input element
la $a0, prompt_input_element
li $v0, 4
syscall

# taking the input
li $v0, 5
syscall

add $t3, $t0, $t2   # calculating the address to store data
sw $v0, 0($t3)      # saving the input
addi $t2, $t2, 4    # moving to next space

j input_loop        #jumping to start of loop 

end_input_loop:

# printing the elemnts in the list

# prompt 
la $a0, prompt_output_element    # load adrees of prompt to a0
li $v0, 4                        # print string, syscall, v0 = 4
syscall

la $t0, size    # loading address of size to t0
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
li $v0, 10
syscall

#varibles 
.data
list: .space 40 # allocate space for list
size: .word 0   # varible to store size of list

#prompt varibles
prompt_input_size:  .asciiz "Please enter size of list: \n"
prompt_input_element: .asciiz "please enter the element: \n "
prompt_output_element: .asciiz "The provided list:"
prompt_space: .asciiz " "