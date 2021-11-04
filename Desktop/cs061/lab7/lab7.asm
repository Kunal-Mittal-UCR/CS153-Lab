;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 7, ex 1 & 2
; Lab section: 024
; TA: Katsubh Singh
; 
;=================================================

; test harness
					.orig x3000
					LD R6, subroutine_3200
					jsrr R6
					
					LD R6, subroutine_3600
					jsrr R6
				 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
subroutine_3200 .FILL x3200
subroutine_3600 .FILL x3600


;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
					ST R7, BACKUP_R7_3200
					AND R1, R1, #0
					ADD R1, R1, #15
					LD R3, opcodes_po_ptr
					LD R4, instructions_po_ptr
					
					OUTPUT_TABLE_LOOP
						LDR R0, R4, #0
						ADD R0, R0, #0 
						BRn DONE_3200 ;If its neg we printed everything out
						;now it checks for 0
						Brz IS_ZERO_3200
						;now it outputs the letter
						OUT
						ADD R4, R4, #1
						BR OUTPUT_TABLE_LOOP
					
					
					IS_ZERO_3200	
						ADD R4, R4, #1 ;We want to output the thing after the null character
						LEA R0, EQUAL_SIGN
						PUTS
						LDR R2, R3, #0
						LD R6, subroutine_3400
						jsrr R6
						ADD R3, R3, #1
						AND R0, R0, #0
						ADD R0, R0, #10
						OUT
						BR OUTPUT_TABLE_LOOP ;always branch bc we have a case which skips this loop
						
					DONE_3200
					LD R7, BACKUP_R7_3200 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
EQUAL_SIGN .STRINGZ " = "
subroutine_3400 .fill x3400 
BACKUP_R7_3200 .BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
					ST R7, BACKUP_R7_3400
					ST R4, BACKUP_R4_3400
					AND R5, R5, #0
					ADD R5, R5, #12
					
					LEFT_SHIFT_LOOP
						ADD R2, R2, R2
						ADD R5, R5, #-1
						BRp LEFT_SHIFT_LOOP
						
					ADD R5, R5, #4
					PRINT_LAST_FOUR
						AND R0, R0, #0
						ADD R0, R0, #12
						ADD R0, R0, #12
						ADD R0, R0, #12
						ADD R0, R0, #12
						ADD R2, R2, #0
						BRzp IS_POS
						ADD R0, R0, #1
						IS_POS ;skips the add 1 bc the 1 determines if its negative
						
						OUT
						ADD R2, R2, R2
						ADD R5, R5, #-1
						BRp PRINT_LAST_FOUR
					
					LD R4, BACKUP_R4_3400
					LD R7, BACKUP_R7_3400 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
BACKUP_R7_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
					ST R7, BACKUP_R7_3600
					START_3600
					LD R2, stored_string
					LD R6, subroutine_3800
					jsrr R6
					
					LD R1, stored_string
					LD R2, instructions_fo_ptr
					LD R3, opcodes_fo_ptr
					
					CHECK_FOR_CHAR	;checks to see what is the inputted char letter by letter in string
						LDR R4, R1, #0
						LDR R5, R2, #0
						LD R6, check_q
						ADD R6, R6, R4
						BRnp NOT_Q
						
						ADD R1, R1, #1
						LDR R6, R1, #0
						ADD R1, R1, #-1
						ADD R6, R6, #0
						BRnp NOT_Q
						
						LEA R0, exit_program
						PUTS
						BR END
						
					NOT_Q
						ADD R5, R5, #0	;End of the 15 words(which ended with -1)
						BRn FOUND_SENTINEL
						
					ADD R4, R4, #0
					BRz IS_ZERO
					
					ADD R5, R5, #0	;Means the word checked doesn't match with user input so it resets everything and moves on
					BRz MISMATCHED
					
					NOT R5, R5
					ADD R5, R5, #1
					
					ADD R6, R5, R4	;checks to see for same letter
					BRnp PREP_NEXT_WORD
					
					ADD R1, R1, #1
					ADD R2, R2, #1
					BR CHECK_FOR_CHAR
					
					IS_ZERO
						ADD R5, R5, #0
						BRz SAME
				
					PREP_NEXT_WORD
						ADD R2, R2, #1
						LDR R5, R2, #0
						ADD R5, R5, #0
						BRp PREP_NEXT_WORD
						
						MISMATCHED
							ADD R2, R2, #1
							ADD R3, R3, #1
							LD R1, stored_string
						BR CHECK_FOR_CHAR
							
					FOUND_SENTINEL	;found -1
						lea R0, bad_input
						PUTS
						AND R0, R0, #0
						ADD R0, R0, #10
						OUT 
						BR START_3600
					
					SAME	;calls the output subroutine and matches the word with number
						LD R0, stored_string
						PUTS
						LEA R0, EQUAL_SIGN_3600
						PUTS
						LDR R2, R3, #0
						LD R6, opcode_3400
						JSRR R6
						AND R0, R0, #0
						ADD R0, R0, #10
						OUT
						BR START_3600
					
					END
						AND R0, R0, #0
						ADD R0, R0, #10
						OUT
						
					LD R7, BACKUP_R7_3600
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
opcode_3400	.fill x3400
subroutine_3800	.fill x3800
BACKUP_R7_3600	.BLKW #1
stored_string .fill x4400
check_q .FILL #-113
exit_program .STRINGZ "Exited Program"
bad_input .STRINGZ "Wrong instruction"
EQUAL_SIGN_3600 .STRINGZ " = "
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
					ST R7, BACKUP_R7_3800
					LEA R0, prompt
					PUTS
					TAKING_INPUT
						GETC
						OUT
						ADD R0, R0, #-10
						BRz DONE_3800
						ADD R0, R0, #10
						STR R0, R2, #0
						ADD R2, R2, #1
						BR TAKING_INPUT
							
				 
					DONE_3800
					AND R0, R0, #0
					STR R0, R2, #0
					LD R7, BACKUP_R7_3800
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
BACKUP_R7_3800	.BLKW #1
prompt .STRINGZ "Enter a string followed by enter\n"


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
					OP_CODE_0    .FILL #0
					OP_CODE_1    .FILL #1
					OP_CODE_2    .FILL #2
					OP_CODE_3    .FILL #3
					OP_CODE_4    .FILL #4
					OP_CODE_4ver2    .FILL #4
					OP_CODE_5    .FILL #5
					OP_CODE_6    .FILL #6
					OP_CODE_7    .FILL #7
					OP_CODE_8    .FILL #8
					OP_CODE_9    .FILL #9
					OP_CODE_10    .FILL #10
					OP_CODE_11    .FILL #11
					OP_CODE_12    .FILL #12
					OP_CODE_12v2    .FILL #12
					OP_CODE_13    .FILL #13
					OP_CODE_14    .FILL #14
					OP_CODE_15    .FILL #15
; opcodes


					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
					OP_BR    .stringz "BR"
					OP_ADD    .stringz "ADD"
					OP_LD    .stringz "LD"
					OP_ST    .stringz "ST"
					OP_JSR    .stringz "JSR"
					OP_JSRR    .stringz "JSRR"
					OP_AND    .stringz "AND"
					OP_LDR    .stringz "LDR"
					OP_STR    .stringz "STR"
					OP_RTI    .stringz "RTI"
					OP_NOT    .stringz "NOT"
					OP_LDI    .stringz "LDI"
					OP_STI    .stringz "STI"
					OP_JMP    .stringz "JMP"
					OP_RET    .stringz "RET"
					OP_reserved    .stringz "RESERVED"
					OP_LEA    .stringz "LEA"
					OP_TRAP    .stringz "TRAP"
					SENTINEL .FILL #-1
; instructions	

;===============================================================================================
