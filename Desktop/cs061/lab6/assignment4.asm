;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 024
; TA: Katsubh Singh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R5
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

START
; output intro prompt
LD R0, introPromptPtr
PUTS


; Set up flags, counters, accumulators as needed
AND R1, R1, #0		;R1 will be the neg flag
AND R2, R2, #0		;R2 Stores the amount of max digits
AND R5, R5, #0		;R5 Stores the number
ADD R2, R2, #5

AND R3, R3, #0		;loading the register with -48 bc im too dumb to use a pointer and too lazy to type it every time
ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12

; Get first character, test for '\n', '+', '-', digit/non-digit 	
GETC
OUT
AND R4, R4, #0		;temp variable that tests each condition
					; is very first character = '\n'? if so, just quit (no message)!
;Just checks to see if \n(10) is there
ADD R4, R0, #-10
BRz DONE
					; is it = '+'? if so, ignore it, go get digits
IF_POS_SIGN
	ADD R4, R0, R3 	;+(43)
	ADD R4, R4, #5
	BRz TO_DIGITS

					; is it = '-'? if so, set neg flag, go get digits
IF_NEG_SIGN
	ADD R4, R0, R3	;-(45)
	ADD R4, R4, #3
	BRz FLAG_NEGATIVE			
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
IF_LESS_ZERO
	ADD R4, R0, R3	;0(48)
	BRn ERROR_MESSAGE
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
IF_GREATER_NINE
	ADD R4, R0, R3	;9(57)
	ADD R4, R4, #-9
	BRnz PASSED_ALL_TESTS		
					;if none of the above, first character is first numeric digit - convert it to number & store in target register!
ERROR_MESSAGE
	AND R0, R0, #0
	ADD R0, R0, #10
	OUT
	LD R0, errorMessagePtr
	PUTS
	BR START
	
FLAG_NEGATIVE
	ADD R1, R1, #1 ;1 means neg, 0 is pos
	
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
TO_DIGITS
	GETC
	OUT
	
	ADD R4, R0, #-10 ;checks for the newline
	BRz IS_POSITIVE	 ;remember to end with a newline!
	
	ADD R4, R0, R3
	BRn ERROR_MESSAGE ;if neg start over
	
	ADD R4, R4, #-9		;if x>9 start over
	BRp ERROR_MESSAGE

PASSED_ALL_TESTS
	AND R6, R6, #0
	ADD R6, R6, #10 ;sets counter to multiply by 10
	ADD R4, R5, #0
	AND R5, R5, #0
	MULT_10
		ADD R5, R5, R4
		ADD R6, R6, #-1
		BRp MULT_10
	
	ADD R0, R0, R3 ;converts from char to num
	ADD R5, R5, R0
	ADD R2, R2, #-1
	BRp	TO_DIGITS
			
AND R0, R0, #0
ADD R0, R0, #10 ;newline
OUT

IS_POSITIVE
	ADD R1, R1, #0
	BRz DONE
					
	NOT R5, R5
	ADD R5, R5, #1
	
DONE				
					HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200


;------------
; Remote data
;------------
					.ORIG xB000			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xB200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
