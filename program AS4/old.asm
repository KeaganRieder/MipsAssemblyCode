# CPSC 3615 Assignment 3
# By Keagan Rieder
# Code to allow user to input there full name and then print
# out characters of there first and last names in revsere order

.data
#varibles
name_input_buffer: .word 128
first_name: .space 128  # users first name
last_name: .space 128   # users last name

#prompts
prompt_input_name:  .asciiz "enter your first name and last, ensuring a space seperates them \n> "
prompt_output_name:  .asciiz "your named when the charcters are reverse is:\n"
prompt_output_error:  .asciiz "Error: name lacks space please re-enter\n>"
prompt_output_found:  .asciiz "Space Found \n "
space: .asciiz " "

.text
main:
    input_name: 
        la $a0 prompt_input_name
        li $v0 4
        syscall

        la $a0, name_input_buffer   # setting the input to the buffer "name_input_buffer"
        li $v0, 8                   # read user input as string
        syscall
    
        #la $a1, name_input_buffer
        li $t0, 0 # initalize counter to be 0
                         
        j find_space 

    find_space:
        add $t2, $a0, $t0              #move pointer to next position
        lb  $t3, 0($t2)             # loading bit of currernt pointer $a1
        beq $t3, 32, space_found    # found the space (char 32 in ascii)
        beqz $t3, space_not_found   # reached end of input and no space found, get user to renter
        addi $t0, $t0, 1  
        j find_space

    space_found:
        la $a1, first_name     
        move $t1, $t0		# saving end of the first name
        li $t2, 0           # set the inital length of the first name to be 0
        j reverse_name

    space_not_found:
        la $a0, prompt_output_error   
        li $v0, 4                       
        syscall
                
        la $a0, name_input_buffer   # setting the input to the buffer "name_input_buffer"
        li $v0, 8                   # read user input as string
        syscall
        j find_space

    reverse_name:
        reverse_first_name:
            beqz $t1, reverse_last_name
            sub $t1, $t1, 1  # decrease the position of first name letter
            add $t3, $a0, $t1
            add $t4, $a1, $t2
           
            lb $t5, 0($t3)
            sb $t5, 0($t4)

            add $t2, $t2, 1 # increase the size of the first name
           
            j reverse_first_name

        reverse_last_name:  
            #adding space
            move $t1, $t0

            # beqz $t1, reverse_last_name
            add $t3, $a0, $t1
            add $t4, $a1, $t2
            
            lb $t5, 0($t3)
            sb $t5, 0($t4)

            add $t2, $t2, 1 # increase the size of the first name
            
            find_last_name_length:
                add $t3, $a0, $t1
                lb $t4, 0($t3)
                beqz $t4, found_last_name_end # reached end of teh string 
                add $t1, $t1, 1 
                
                j find_last_name_length

            found_last_name_end:
                #la $a0, name_input_buffer
                #sub $t1, $t1,1
            reverse_last_name_loop:
                beq	$t0, $t1, output_reversed_name	# if $t0 == $t1 then goto target
            
                # beqz $t1, reverse_last_name
                sub $t1, $t1, 1  # decrease the position of first name letter
                add $t3, $a0, $t1
                add $t4, $a1, $t2
            
                lb $t5, 0($t3)
                sb $t5, 0($t4)

                add $t2, $t2, 1 # increase the size of the first name

                j reverse_last_name_loop

    output_reversed_name:
        la $a0, prompt_output_name   
        li $v0, 4                       
        syscall

        la $a0, first_name
        li $v0, 4                   
        syscall         

    done:
        #exit program
        li $v0, 10
        syscall