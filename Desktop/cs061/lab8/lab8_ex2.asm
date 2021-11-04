;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 024
; TA: Katsubh Singh
; 
;=================================================
.orig x3000
			
			LEA R0, prompt
			PUTS
			
			GETC
			OUT
			ADD R1, R0, #0
			AND R0, R0, #0
			ADD R0, R0, #10
			OUT
		
			LD R6, subroutine_3200
			jsrr R6
			
			LEA R0, resultPrompt_FIRST
			PUTS
			AND R0, R0, #0
			ADD R0, R1, #0
			OUT
			
			LEA R0, resultPrompt_SECOND
			PUTS
			AND R0, R0, #0
			ADD R0, R0, R2
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
			AND R0, R0, #0
			ADD R0, R0, #10
			OUT

HALT
;local data
subroutine_3200 .FILL x3200
prompt .STRINGZ "Enter a character \n"
resultPrompt_FIRST .STRINGZ "The number of 1’s in '"
resultPrompt_SECOND .STRINGZ "' is: "
;Subroutine FillRegister
;Take a hard coded value and store it in a register and return it

.orig x3200
	ST R7, BACKUP_R7_3200
	ST R1, BACKUP_R1_3200
	
	AND R2, R2, #0
	AND R3, R3, #0
	ADD R3, R3, #12
	ADD R3, R3, #4
	
	
	CHECK_ONES
		ADD R1, R1, #0
		BRzp LEFT_SHIFT
		ADD R2, R2, #1	;if value is neg, it means it has a leading 1 so add 1 to the counter
		
		LEFT_SHIFT
		ADD R1, R1, R1
		ADD R3, R3, #-1
		BRp CHECK_ONES
		
	LD R1, BACKUP_R1_3200
	LD R7, BACKUP_R7_3200
	ret
	
;local data
BACKUP_R7_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1

.END
