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
				LD R6, subroutine_3200
				jsrr R6
				ADD R1, R1, #1
				LD R6, subroutine_3400
				jsrr R6


HALT
;local data
subroutine_3200 .FILL x3200
subroutine_3400 .FILL x3400
;Subroutine FillRegister
;Take a hard coded value and store it in a register and return it

.orig x3200
	ST R7, BACKUP_R7_3200
	
	LD R1, Random_Value
	
	LD R7, BACKUP_R7_3200
	ret
	
;local data
BACKUP_R7_3200 .BLKW #1
Random_Value .FILL #32767

;subroutine displayNum
;Use the harcoded value and display it to console
.orig x3400
	ST R7, BACKUP_R7_3400
	ST R1, BACKUP_R1_3400
	LD R6, HARD_CODED_48
	
	ADD R2, R1, #0 ;adds contents of R1 to R2
	BRzp NOT_NEG
	
	LD R0, NEGATIVE_SIGN
	OUT
	NOT R2, R2
	ADD R2, R2, #1
	
	NOT_NEG
	AND R3, R3, #0
	LD R4, NEGATIVE_10K ;starting -10k loop test stuff
	AND R5, R5, #0
	FIVE_DIGITS
		ADD R2, R2, R4
		BRn END_FIVE_DIGITS
		ADD R5, R5, #1
		BR FIVE_DIGITS
	
	END_FIVE_DIGITS
	
	NOT R4, R4
	ADD R4, R4, #1
	ADD R2, R2, R4
	
	ADD R5, R5, #0
	BRz FOUR_DIGITS_SETUP ;now we need to set up stuff for 4 digits 
	ADD R3, R3, #1
	ADD R0, R5, R6
	OUT
	
	FOUR_DIGITS_SETUP
		LD R4, NEGATIVE_1K ;starting -1k loop test stuff
		AND R5, R5, #0
		FOUR_DIGITS
			ADD R2, R2, R4
			BRn END_FOUR_DIGITS
			ADD R5, R5, #1
			BR FOUR_DIGITS
		
		END_FOUR_DIGITS
		
		NOT R4, R4
		ADD R4, R4, #1
		ADD R2, R2, R4
		
		ADD R3, R3, #0 ;0 means leading zeroes
		BRp PRINT_FOUR_DIGITS
		
		ADD R5, R5, #0
		BRz THREE_DIGITS_SETUP ;now we need to set up stuff for 3 digits 
		
		PRINT_FOUR_DIGITS
		
		ADD R3, R3, #1
		ADD R0, R5, R6
		OUT
		
	THREE_DIGITS_SETUP
		LD R4, NEGATIVE_100 ;starting -100 loop test stuff
		AND R5, R5, #0
		THREE_DIGITS
			ADD R2, R2, R4
			BRn END_THREE_DIGITS
			ADD R5, R5, #1
			BR THREE_DIGITS
		
		END_THREE_DIGITS
		
		NOT R4, R4
		ADD R4, R4, #1
		ADD R2, R2, R4
		
		ADD R3, R3, #0 ;0 means leading zeroes
		BRp PRINT_THREE_DIGITS
		
		ADD R5, R5, #0
		BRz TWO_DIGITS_SETUP ;now we need to set up stuff for 3 digits 
		
		PRINT_THREE_DIGITS
		
		ADD R3, R3, #1
		ADD R0, R5, R6
		OUT
	
	TWO_DIGITS_SETUP
		AND R4, R4, #0 ;starting -10 loop test stuff
		ADD R4, R4, #-10
		AND R5, R5, #0
		TWO_DIGITS
			ADD R2, R2, R4
			BRn END_TWO_DIGITS
			ADD R5, R5, #1
			BR TWO_DIGITS
		
		END_TWO_DIGITS
		
		NOT R4, R4
		ADD R4, R4, #1
		ADD R2, R2, R4
		
		ADD R3, R3, #0 ;0 means leading zeroes
		BRp PRINT_TWO_DIGITS
		
		ADD R5, R5, #0
		BRz SINGLE_DIGITS_SETUP ;now we need to set up stuff for 3 digits 
		
		PRINT_TWO_DIGITS
		
		ADD R3, R3, #1
		ADD R0, R5, R6
		OUT
	
	SINGLE_DIGITS_SETUP
	ADD R0, R2, R6
	OUT
	
	LD R1, BACKUP_R1_3400
	LD R7, BACKUP_R7_3400
	
	ret
;local data
BACKUP_R7_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
HARD_CODED_48 .FILL #48
NEGATIVE_10K .FILL #-10000
NEGATIVE_1K .FILL #-1000
NEGATIVE_100 .FILL #-100
NEGATIVE_SIGN .FILL '-'

.END
