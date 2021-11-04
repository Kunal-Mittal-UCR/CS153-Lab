;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC	;outputs the values
OUT
ADD R1, R0, #0
LD R0, newline
OUT
GETC
OUT
ADD R2, R0, #0
LD R0, newline
OUT

ADD R0, R1, #0	;num1
OUT
LEA R0, MINUS_SIGN	;minus sign
PUTS
ADD R0, R2, #0	;num2
OUT
LEA R0, EQUALS_SIGN	;equal sign
PUTS

ADD R1, R1, #-12
ADD R1, R1, #-12
ADD R1, R1, #-12
ADD R1, R1, #-12

ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12

NOT R3, R2	;flips R2
ADD R3, R3, #1	;2s complement stuff
ADD R4, R1, R3



IF_STATEMENT
	ADD R4, R4, #0
	BRzp IS_POS
IS_NEG
	LD R0, MINUS_SIGN_NO_SPACE
	OUT
	NOT R4, R4	;converts back to positve
	ADD R4, R4, #1
IS_POS
	

ADD R4, R4, #12
ADD R4, R4, #12
ADD R4, R4, #12
ADD R4, R4, #12
ADD R0, R4, #0
OUT
LD R0, newline
OUT



HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
MINUS_SIGN .STRINGZ " - "
EQUALS_SIGN .STRINGZ " = "
MINUS_SIGN_NO_SPACE .FILL #45




;---------------	
;END of PROGRAM
;---------------	
.END

