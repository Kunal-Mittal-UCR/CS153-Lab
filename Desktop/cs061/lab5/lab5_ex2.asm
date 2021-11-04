;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 024
; TA: Katsubh Singh
; 
;=================================================
.orig x3000

LD R1, array_pointer
LD R2, jump_to_subroutine
jsrr R2
ADD R0, R1, #0
PUTS

LD R2, jump_to_subroutine2
jsrr R2
LEA R0, the_string
PUTS
LD R0, array_pointer
PUTS

ADD R4, R4, #0
BRz is_false

	LEA R0, is_palindrome_true
	PUTS
	BR done
	
is_false
	LEA R0, not_palindrome
	PUTS

done


HALT
;local data
jump_to_subroutine .FILL x3200
jump_to_subroutine2 .FILL x3400
array_pointer .FILL x4000
the_string .STRINGZ "\nThe string "
not_palindrome .STRINGZ " IS NOT a palindrome \n"
is_palindrome_true .STRINGZ " IS a palindrome \n"
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;
;terminated by the [ENTER] key (the "sentinel"), and has stored
;
;the received characters in an array of characters starting at (R1).
;
;the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of ​ non-sentinel​ chars read from the user.
;
;R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.orig x3200

	ST r7, backup_r7_3200
	ST r1, backup_r1_3200
	AND R5, R5, #0

	WHILE_LOOP
		GETC
		OUT
		STR R0, R1, #0
		ADD R1, R1, #1
		ADD R5, R5, #1
		ADD R0, R0, #-10
	BRnp WHILE_LOOP
	ADD R1, R1, #-1
	STR R0, R1, #0
	ADD R5, R5, #-1
	LD r1, backup_r1_3200
	LD r7, backup_r7_3200
	ret
	
	
;local data
	backup_r7_3200 .BLKW #1
	backup_r1_3200 .BLKW #1
	
	
.orig x3400
;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;
;is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------	

	ST R7, backup_r7_3400
	ST R1, backup_r1_3400
	ST R5, backup_r5_3400
	
	ADD R5, R5, R1 ;end of array +1
	ADD R5, R5, #-1;end of array
	AND R3, R3, #0 ;check 1
	AND R4, R4, #0 ;check 2
	
	WHILE_LOOP2
		NOT R6, R5 ;R6=-R5
		ADD R6, R6, #1 ;2s complement
		ADD R6, R6, R1
		BRzp is_palindrome
		
		LDR R3, R1, #0 ;R3=array[beginning]
		LDR R4, R5, #0 ;R4=array[end]
		
		ADD R1, R1, #1 ;increments beginning of array
		ADD R5, R5, #-1 ;decrements end of array
		
		NOT R2, R3 ;R2=-R3
		ADD R2, R2, #1 ;2s complement stored in r2
		ADD R4, R4, R2 ;checks for palindrome
		BRz WHILE_LOOP2
	AND R4, R4, #0
	BR FINISHED
	 
	is_palindrome
	AND R4, R4, #0
	ADD R4, R4, #1
	
	FINISHED 
	
	LD R1, backup_r1_3400
	LD R5, backup_r5_3400
	LD R7, backup_r7_3400
	ret
	
;local data
	backup_r7_3400 .BLKW #1
	backup_r1_3400 .BLKW #1
	backup_r5_3400 .BLKW #1

.orig x4000
ARRAY .BLKW #100
