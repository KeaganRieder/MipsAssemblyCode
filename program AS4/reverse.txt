# CPSC 3615 Assignment 3
# By Keagan Rieder
# Code to allow user to input there full name and then print
# out characters of there first and last names in revsere order

.data
inputed_name: .space 100 			#array for name input
reversed_orderd_name: .space 100 	#array to store reversed version of name
prompt_input_name: .asciiz "enter your first name and last, ensuring a space seperates them \n> "
prompt_output_reverse: .asciiz "your named when the charcters are reverse is:\n"

.text
main:

    la $a0, prompt_input_name		 # load address of "prompt_input_name" to a0
    li $v0, 4 					 	 # li: load integer, set v0 as 4 for output string function in syscall
    syscall

    #taking the input
    li $v0, 8	            # v0=8 for input integer function in syscall
    la $a0, inputed_name	# loading the address of inputed_name in $a1	
    li $a1, 100
    syscall

    li $t1, 0 # counter	being set to 0

find_name_length:

    add $t2, $a0, $t1
        
    lb $t3, 0($t2)					#load byte address of current iteration
        
    beqz $t3, length_found 				#if array is 0, go to end_count
        
    addi $t1, $t1, 1				#loop/array counter
        
    j find_name_length

length_found:

    #assign variables
    li $s1, 0					# use s1 to represent the inputed_name size, initialize s1 as 0
    addi $s1, $t1, -1				

    #reinitializing temps
    li $t1, 0
    li $t2, 0

    la $s2, reversed_orderd_name


reverse_name:
    blt $s1, $zero, done_reversing	# if array size-1 is < 0, go to done_reverse

    add $t3, $s2, $t2				# move iteration from array to i

    lb $t1, inputed_name($s1)			# load memory of inputed_name from current index iteration

    sb $t1, 0($t3)					# overwrite current memory

    addi $t2, $t2, 1				# add 1 to array iteration

    addi $s1, $s1, -1				# -1 to inputed_name size iteration
    j reverse_name


done_reversing:
  
output_reversed_name:
   #printing the prompt for output
    la $a0, prompt_output_reverse		
    li $v0, 4 					 		 
    syscall

    la $a0, reversed_orderd_name		
    li $v0, 4 					 		 
    syscall

li $v0, 10 #v0=10, exit function
syscall




