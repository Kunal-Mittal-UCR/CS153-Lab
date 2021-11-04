;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 024
; TA: Katsubh Singh
; 
;=================================================

; test harness
					.orig x3000
					LD R4, base_val ;initialize stack
					LD R5, max_val
					LD R6, base_val
					
					LD R1, subtract_num
					
					LEA R0, prompt
					PUTS
					GETC
					OUT 
					ADD R0, R0, R1
					LD R3, subroutine_push
					jsrr R3
					
					LD R0, newline
					OUT
					
					LEA R0, prompt
					PUTS
					GETC
					OUT
					ADD R0, R0, R1
					LD R3, subroutine_push
					jsrr R3
					
					LD R0, newline
					OUT
					
					LEA R0, prompt2
					PUTS
					GETC
					OUT
					LD R3, subroutine_mult
					jsrr R3
					
					LD R0, newline
					OUT
					
					LD R3, subroutine_pop
					jsrr R3
					
					ADD R2, R0, #0
					LD R3, subroutine_print
					jsrr R3
					
					LD R0, newline	
					OUT
					
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

subroutine_push .FILL x3200
subroutine_pop .FILL x3400
subroutine_mult .FILL x3600
subroutine_print .FILL x3800
base_val .FILL xA000
max_val .FILL xA005
DEC_1 .FILL #1
DEC_2 .FILL #2
DEC_3 .FILL #3
DEC_4 .FILL #4
DEC_5 .FILL #5
DEC_6 .FILL #6
prompt .STRINGZ "Please enter a num\n"
prompt2 .STRINGZ "Enter a multiplication sign\n"
newline .FILL #10
subtract_num .FILL #-48
add_num .FILL #48
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
					ST R1, BACKUP_R1_3200
					ST R2, BACKUP_R2_3200
					
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
					LD R1, BACKUP_R1_3200
					LD R2, BACKUP_R2_3200
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R7_3200 .BLKW #1
BACKUP_R0_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
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
					ST R1, BACKUP_R1_3400
					ST R2, BACKUP_R2_3400
					
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
					LD R1, BACKUP_R1_3400
					LD R2, BACKUP_R2_3400
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BACKUP_R7_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
underflow_error .STRINGZ "Underflow sadge\n"

;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
					ST R7, BACKUP_R7_3600
					ST R0, BACKUP_R0_3600
					ST R4, BACKUP_R4_3600
					ST R5, BACKUP_R5_3600
				
					LD R3, subroutine_pop_3600
					jsrr R3
					ADD R1, R0, #0 ;num1
					LD R3, subroutine_pop_3600
					jsrr R3
					ADD R2, R0, #0 ;num2
					BRz CHECK_ZERO_3600
					
					AND R0, R0, #0
					MULT_3600 
						ADD R0, R0, R1
						ADD R2, R2, #-1
						BRp MULT_3600
					
					CHECK_ZERO_3600	
						
						
					LD R3, subroutine_push_3600
					jsrr R3
						
					LD R7, BACKUP_R7_3600
					LD R0, BACKUP_R0_3600
					LD R4, BACKUP_R4_3600
					LD R5, BACKUP_R5_3600
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R7_3600 .BLKW #1
BACKUP_R0_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
subroutine_push_3600 .FILL x3200
subroutine_pop_3600 .FILL x3400

;===============================================================================================


; SUB_PRINT_DECIMAL        Only needs to be able to print 1 or 2 digit numbers. 

.orig x3800

ST R0, BACKUP_R0_3800
ST R1, BACKUP_R1_3800
ST R2, BACKUP_R2_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800

LD R4, NUM_TO_CHAR    ;R4 <- #48

TEN_CALC
    
    AND R5, R5, #0        ;R5: COUNT OF 10'S
    
    TEN_LOOP
        ADD R2, R2, #-10
        BRn END_10_LOOP
        ADD R5, R5, #1
        BR TEN_LOOP    
    END_10_LOOP

    ADD R2, R2, #10        ;R2 <- R2 - R5*10 (COUNT*10)
    

    ADD R5, R5, #0
    BRp PRINT_10        ;IS POS == NOT LEAD 0 -> PRINT

    ADD R5, R5, #0        
    BRz ONE_CALC        ;IF COUNT_10K == 0 AND IS LEAD 0, NEXT DIG CALC
    
    PRINT_10
        ADD R0, R5, R4        ;R0 <- COUNT + ASCII CONVERT
        OUT
END_TEN_CALC

ONE_CALC

    ADD R0, R2, R4
    OUT
END_ONE_CALC


LD R0, BACKUP_R0_3800
LD R1, BACKUP_R1_3800
LD R2, BACKUP_R2_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800
ret
NUM_TO_CHAR .FILL x30

BACKUP_R0_3800 .BLKW #1
BACKUP_R1_3800 .BLKW #1
BACKUP_R2_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R4_3800 .BLKW #1
BACKUP_R5_3800 .BLKW #1
BACKUP_R6_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1
