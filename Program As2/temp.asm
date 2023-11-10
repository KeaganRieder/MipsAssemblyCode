multiplication_operation:

output_multiplication_Results:
    #outputting prompt
    la $a0, prompt_output_multiplication_results    
    li $v0, 4                      
    syscall
    #outputing results

division_operation:

output_division_Results:
    #outputting prompt
    la $a0, prompt_output_division_results    
    li $v0, 4                      
    syscall
    
    #outputing results

    subtraction_operation:
    sub $t2, $t0, $t1

output_subtraction_Results:
    #outputting prompt
    la $a0, prompt_output_subtraction_results    
    li $v0, 4                      
    syscall

    #outputing results
    lw $a0, 0($t2) #outputing results of addition
    li $v0, 1
    syscall

   # sw 0 0($t2)
