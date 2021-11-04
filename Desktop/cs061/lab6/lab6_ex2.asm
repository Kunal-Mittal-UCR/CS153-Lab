;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 024
; TA: Katsubh Singh
; 
;=================================================
.orig x3000
LD R6, jump_to_subroutine_x3200
jsrr R6
LEA R0, Newline
PUTS
LD R6, jump_to_subroutine_x3400
jsrr R6


HALT
;local data
jump_to_subroutine_x3200 .FILL x3200
jump_to_subroutine_x3400 .FILL x3400
Newline .STRINGZ "\n"

.orig x3200
;-------------------------------------------------------------------------
; Subroutine: Converts binary to an actual number
;
;Prints out the 16bit binary of the power of 2 value
; Return Value: R2 (returns the 16 bit value)
;-------------------------------------------------------------------------
	ST R7, backup_r7_3200
	AND R0, R0,#0
	LEA R0, PROMPT_16
	PUTS;outputs prompt
	LD R1, COUNTER
	GETC
	OUT;Just for the letter b
	AND R2, R2, #0
	CONVERT_LOOP
		GETC
		OUT
		ADD R2, R2, R2
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R2, R2, R0
		ADD R1, R1, #-1
		BRp CONVERT_LOOP
	
	LD R7, backup_r7_3200
	ret
;local data
backup_r7_3200 .BLKW #1
COUNTER .FILL #16
PROMPT_16 .STRINGZ "Enter b followed by 16 bit binary \n"

.orig x3400
;-------------------------------------------------------------------------
; Subroutine: MOST SIGNIFICANT BIT
; Parameter (R3): The address of what I want to print out
;
;Prints out the 16bit binary of the power of 2 value
; Return Value: NONE
;-------------------------------------------------------------------------

	ST R7, backup_r7_3400
	ST R2, backup_r2_3400
	ST R1, backup_r1_3400
	ST R3, backup_r3_3400
	ST R4, backup_r4_3400
	
	ADD R1, R2, #0
	AND R2, R2, #0
	Add R2, R2, #15
	AND R3, R3, #0
	Add R3, R3, #4

	IF_STATEMENT ;determines the leading bit
			AND R0, R0, #0
			ADD R1, R1, #0
			BRzp PRINT_POS
			ADD R0, R0, #1
	PRINT_POS
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT

	WHILE_LOOP_3200
		ADD R1, R1, R1
		ADD R2, R2, #-1
		BRn END_OF_PROGRAM
		ADD R3, R3, #-1
		BRz PRINT_SPACE
		BRp IF_STATEMENT
		
	PRINT_SPACE
		AND R0, R0, #0
		ADD R0, R0, #15
		ADD R0, R0, #15
		ADD R0, R0, #2
		OUT
		ADD R3, R3, #4
		BR IF_STATEMENT
		
END_OF_PROGRAM

AND R0, R0, #0
ADD R0, R0, #10
OUT
	
	LD R7, backup_r7_3400
	LD R1, backup_r1_3400
	LD R2, backup_r2_3400
	LD R3, backup_r3_3400
	LD R4, backup_r4_3400
	ret

;local data
backup_r7_3400 .BLKW #1
backup_r1_3400 .BLKW #1
backup_r2_3400 .BLKW #1
backup_r3_3400 .BLKW #1
backup_r4_3400 .BLKW #1
