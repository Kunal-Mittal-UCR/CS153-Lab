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

HALT
;local data
jump_to_subroutine .FILL x3200
array_pointer .FILL x4000
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
	
.orig x4000
ARRAY .BLKW #100
