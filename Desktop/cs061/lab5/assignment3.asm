;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 024
; TA: Katsubh Singh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
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

WHILE_LOOP
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

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA00	; The address where value to be displayed is stored


.ORIG xCA00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
