;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 024
; TA: Katsub Singh
; 
;=================================================

; test harness
					.orig x3000
					LD R4, base_val
					LD R5, max_val
					LD R6, base_val ;tos starts at base then increments or decrements depending on which subroutine
					LD R0, DEC_1
					LD R3, subroutine_push
					jsrr R3
					LD R0, DEC_2
					LD R3, subroutine_push
					jsrr R3
					LD R0, DEC_3
					LD R3, subroutine_push
					jsrr R3
					LD R0, DEC_4
					LD R3, subroutine_push
					jsrr R3
					LD R0, DEC_5
					LD R3, subroutine_push
					jsrr R3
					LD R0, DEC_6
					LD R3, subroutine_push
					jsrr R3
					LD R3, subroutine_push
					jsrr R3
					LD R3, subroutine_push
					jsrr R3
					LD R3, subroutine_push
					jsrr R3
					
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					LD R3, subroutine_pop
					jsrr R3
					
					
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
subroutine_push .FILL x3200
subroutine_pop .FILL x3400
base_val .FILL xA000
max_val .FILL xA005
DEC_1 .FILL #1
DEC_2 .FILL #2
DEC_3 .FILL #3
DEC_4 .FILL #4
DEC_5 .FILL #5
DEC_6 .FILL #6


;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
					ST R7, BACKUP_R7_3200
					ST R0, BACKUP_R0_3200
					ST R4, BACKUP_R4_3200
					ST R5, BACKUP_R5_3200
					
					NOT R1, R6
					ADD R1, R1, #1 ;2s complement of tos to check for overflow
					ADD R2, R1, R5
					BRp STACK_NOT_FULL_3200
					
				 
					OVERFLOW_3200
						LEA R0, overflow_error
						PUTS
						BR END_OF_STACK_3200
					
					STACK_NOT_FULL_3200
						ADD R6, R6, #1 ;gotta increment by 1 bc the base is a dummy node kinda
						STR R0, R6, #0
					
					END_OF_STACK_3200
					
					
					LD R7, BACKUP_R7_3200
					LD R0, BACKUP_R0_3200
					LD R4, BACKUP_R4_3200
					LD R5, BACKUP_R5_3200
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R7_3200 .BLKW #1
BACKUP_R0_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
overflow_error .STRINGZ "Overflow sadge\n"

;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
					ST R7, BACKUP_R7_3400
					ST R4, BACKUP_R4_3400
					ST R5, BACKUP_R5_3400
					
					NOT R1, R6
					ADD R1, R1, #1 ;2s complement of tos to check for underflow				 
					ADD R2, R1, R4
					BRn STACK_NOT_EMPTY_3400
					
					UNDERFLOW_ERROR_3400
						LEA R0, underflow_error
						PUTS
						BR END_OF_STACK_3400
						
					STACK_NOT_EMPTY_3400
						LDR R0, R6, #0
						ADD R6, R6, #-1
						
					END_OF_STACK_3400
					
					LD R7, BACKUP_R7_3400
					LD R4, BACKUP_R4_3400
					LD R5, BACKUP_R5_3400
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BACKUP_R7_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
underflow_error .STRINGZ "Underflow sadge\n"

;===============================================================================================

