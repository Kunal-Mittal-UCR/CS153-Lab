;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 
; TA: Katsubh Singh
; 
;=================================================
.orig x3000
LD R6, jump_to_subroutine_x3200
AND R1, R1, #0
ADD R1, R1, #10
LD R3, ARRAY_POINTER
AND R4, R4, #0
ADD R4, R4, #1

WHILE_LOOP
	STR R4, R3, #0
	ADD R3, R3, #1
	ADD R4, R4, R4
	ADD R1, R1, #-1
	BRp WHILE_LOOP
END_OF_WHILE_LOOP

LD R3, ARRAY_POINTER
LDR R2, R3, #6

ADD R1, R1, #10

OUTPUT_LOOP
	jsrr R6
	ADD R3, R3, #1
	ADD R1, R1, #-1
	BRp OUTPUT_LOOP
END_OF_OUTPUT_LOOP


HALT
;Data
ARRAY_POINTER .FILL x4000
jump_to_subroutine_x3200 .FILL x3200

.orig x3200
;-------------------------------------------------------------------------
; Subroutine: MOST SIGNIFICANT BIT
; Parameter (R3): The address of what I want to print out
;
;Prints out the 16bit binary of the power of 2 value
; Return Value: NONE
;-------------------------------------------------------------------------

	ST R7, backup_r7_3200
	ST R1, backup_r1_3200
	ST R3, backup_r3_3200
	ST R4, backup_r4_3200
	
	LDR R1, R3, #0
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
	
	LD R7, backup_r7_3200
	LD R1, backup_r1_3200
	LD R3, backup_r3_3200
	LD R4, backup_r4_3200
	ret

;local data
backup_r7_3200 .BLKW #1
backup_r1_3200 .BLKW #1
backup_r3_3200 .BLKW #1
backup_r4_3200 .BLKW #1

;Remote Data
.orig x4000
ARRAY_1 .BLKW #10
