;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
MAIN_LOOP
	LD R6, subroutineM_x3200
	jsrr R6
	SUB1
		ADD R5, R1, #-1
		BRnp SUB2
		LD R6, subroutine1_x3400
		jsrr R6
		ADD R5, R2, #0
		BRz SUB1_0
		LEA R0, allbusy
		PUTS
		BR MAIN_LOOP
		SUB1_0
			LEA R0, allnotbusy
			PUTS
			BR MAIN_LOOP
	SUB2
		ADD R5, R1, #-2
		BRnp SUB3
		LD R6, subroutine2_x3600
		jsrr R6
		ADD R5, R2, #0
		BRz SUB2_0
		LEA R0, allfree
		PUTS
		BR MAIN_LOOP
		SUB2_0
			LEA R0, allnotfree
			PUTS
			BR MAIN_LOOP
	SUB3
		ADD R5, R1, #-3
		BRnp SUB4
		LD R6, subroutine3_x3800
		jsrr R6
		LEA R0, busymachine1
		PUTS
		LD R6, subroutineh2_x4800
		jsrr R6
		LEA R0, busymachine2
		PUTS
		BR MAIN_LOOP
	SUB4
		ADD R5, R1, #-4
		BRnp SUB5
		LD R6, subroutine4_x4000
		jsrr R6
		LEA R0, freemachine1
		PUTS
		LD R6, subroutineh2_x4800
		jsrr R6
		LEA R0, freemachine2
		PUTS
		BR MAIN_LOOP
	SUB5
		ADD R5, R1, #-5
		BRnp SUB6
		LD R6, subroutineh1_x4600
		jsrr R6
		LD R6, subroutine5_x4200
		jsrr R6
		LEA R0, status1
		PUTS
		LD R6, subroutineh2_x4800
		jsrr R6
		ADD R5, R2, #0
		BRz SUB5_0
		LEA R0, status3
		PUTS
		BR MAIN_LOOP
		SUB5_0
			LEA R0, status2
			PUTS
			BR MAIN_LOOP
	SUB6
		ADD R5, R1, #-6
		BRnp SUB7
		LD R6, subroutine6_x4400
		jsrr R6
		ADD R5, R1, #1
		BRnp VALID_S6
		LEA R0, firstfree2
		PUTS 
		BR MAIN_LOOP
		
		VALID_S6
			LEA R0, firstfree1
			PUTS
			LD R6, subroutineh2_x4800
			jsrr R6
			AND R0, R0, #0
			ADD R0, R0, #10
			OUT
			BR MAIN_LOOP
	SUB7
		LEA R0, goodbye
		PUTS

HALT
;---------------	
;Data
;---------------
;Subroutine pointers
subroutineM_x3200 .FILL x3200
subroutine1_x3400 .FILL x3400
subroutine2_x3600 .FILL x3600
subroutine3_x3800 .FILL x3800
subroutine4_x4000 .FILL x4000
subroutine5_x4200 .FILL x4200
subroutine6_x4400 .FILL x4400
subroutineh1_x4600 .FILL x4600
subroutineh2_x4800 .FILL x4800



;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"

.orig x3200
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_3200
LD R2, NEG_NUM_49

MENU_LOOP_3200
	LD R0, Menu_string_addr
	PUTS
	GETC
	OUT
	ADD R1, R2, R0
	BRn INVALID_3200
	ADD R1, R1, #-6
	BRp INVALID_3200
	BR WORKING_MENU
	BR MENU_LOOP_3200
	
	INVALID_3200
		AND R0, R0, #0
		ADD R0, R0, #10
		OUT
		LEA R0, Error_msg_1
		PUTS
		BR MENU_LOOP_3200
	WORKING_MENU
		ADD R1, R1, #7
		AND R0, R0, #0
		ADD R0, R0, #10
		OUT
;HINT Restore
LD R7, BACKUP_R7_3200
ret
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000
BACKUP_R7_3200 .BLKW #1
NEG_NUM_49 .FILL #-49

.orig x3400
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_3400
LDI R2, BUSYNESS_ADDR_ALL_MACHINES_BUSY
ADD R2, R2, #0
	BRz END_3400
AND R2, R2, #0
ADD R2, R2, #-1

END_3400
ADD R2, R2, #1
;HINT Restore
LD R7, BACKUP_R7_3400
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB400
BACKUP_R7_3400 .BLKW #1

.orig x3600
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_3600
LDI R2, BUSYNESS_ADDR_ALL_MACHINES_FREE
ADD R2, R2, #1
	BRnp FAIL_3600
ADD R2, R2, #1
	BR SUCCESS_3600
FAIL_3600
AND R2, R2, #0
SUCCESS_3600
;HINT Restore
LD R7, BACKUP_R7_3600
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB400
BACKUP_R7_3600 .BLKW #1

.orig x3800
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_3800
AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #1
AND R1, R1, #0

LDI R2, BUSYNESS_ADDR_NUM_BUSY_MACHINES

COUNT_BUSY_3800
	ADD R2, R2, #0
	BRn LEFT_SHIFT_3800
	ADD R1, R1, #1
	LEFT_SHIFT_3800
		ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp COUNT_BUSY_3800
;HINT Restore
LD R7, BACKUP_R7_3800
ret
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB400
BACKUP_R7_3800 .BLKW #1

.orig x4000
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_4000
AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #1
AND R1, R1, #0

LDI R2, BUSYNESS_ADDR_NUM_FREE_MACHINES

COUNT_FREE_4000
	ADD R2, R2, #0
	BRzp LEFT_SHIFT_4000
	ADD R1, R1, #1
	LEFT_SHIFT_4000
		ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp COUNT_FREE_4000
;HINT Restore
LD R7, BACKUP_R7_4000
ret
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB400
BACKUP_R7_4000 .BLKW #1

.orig x4200
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_4200
ST R1, BACKUP_R1_4200
LDI R4, BUSYNESS_ADDR_MACHINE_STATUS
AND R3, R3, #0
ADD R3, R1, #-15
NOT R3, R3
ADD R3, R3, #1

FIND_STATUS_4200
	ADD R3, R3, #0
	BRz CHECK_4200
		ADD R4, R4, R4
	ADD R3, R3, #-1
	BRp FIND_STATUS_4200
	
CHECK_4200
	AND R2, R2, #0	
	ADD R4, R4, #0
	BRzp IS_BUSY_4200
	ADD R2, R2, #1
IS_BUSY_4200
;HINT Restore
LD R1, BACKUP_R1_4200
LD R7, BACKUP_R7_4200
ret
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS .Fill xB400
BACKUP_R7_4200 .BLKW #1
BACKUP_R1_4200 .BLKW #1

.orig x4400
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up 
ST R7, BACKUP_R7_4400
AND R1, R1, #0
AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #1
LDI R2, BUSYNESS_ADDR_FIRST_FREE

ADD R2, R2, #0
BRz END_4400
FIND_FIRST_FREE_4400
	ADD R2, R2, #0
	BRn IS_FREE_4400
	CONTINUE_4400
		ADD R2, R2, R2
		ADD R3, R3, #-1
		BRp FIND_FIRST_FREE_4400
	BR FINISHED_4400
	IS_FREE_4400
	ADD R1, R3, #-1
	BR CONTINUE_4400

END_4400
ADD R1, R1, #-1
FINISHED_4400
;HINT Restore
LD R7, BACKUP_R7_4400
ret
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB400
BACKUP_R7_4400 .BLKW #1
.orig x4600
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R7, BACKUP_R7_4600
START
; output intro prompt
LEA R0, prompt
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
BRz ERROR_MESSAGE
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
	LEA R0, Error_msg_2
	PUTS
	BR START
	
FLAG_NEGATIVE
	ADD R1, R1, #1 ;1 means neg, 0 is pos
	
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
TO_DIGITS
	GETC
	
	ADD R4, R0, #-10 ;checks for the newline
	BRz IS_POSITIVE	 ;remember to end with a newline!
	OUT
	
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
	BRp ERROR_MESSAGE
	ADD R5, R5, #-15
	BRp ERROR_MESSAGE
	AND R0, R0, #0
	ADD R0, R0, #10
	OUT
	ADD R5, R5, #15
	ADD R1, R5, #0

DONE
LD R7, BACKUP_R7_4600
ret
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
BACKUP_R7_4600 .BLKW #1
	
.orig x4800	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------


;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R7, BACKUP_R7_4800
ST R1, BACKUP_R1_4800
ADD R1, R1, #-10
BRzp IS10_4800
	ADD R1, R1, #10
	BR PRINT_4800
	IS10_4800
		AND R0, R0, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #13
		OUT
	PRINT_4800
		AND R0, R0, #0
		ADD R0, R1, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT

LD R1, BACKUP_R1_4800
LD R7, BACKUP_R7_4800
ret
;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R7_4800 .BLKW #1
BACKUP_R1_4800 .BLKW #1

.ORIG x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB400			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
