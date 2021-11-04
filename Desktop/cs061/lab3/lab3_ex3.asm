;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 3. ex 3
; Lab section: 24
; TA: Katsubh Singh
; 
;=================================================
.ORIG x3000
LD R1, COUNTER
LEA R2, ARRAY_1


DO_WHILE_LOOP
	GETC
	OUT 
	STR R0, R2, #0
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp DO_WHILE_LOOP
END_DO_WHILE

LD R1, COUNTER
LEA R2, ARRAY_1

DO_WHILE_LOOP_NEW
	LD R0, NEWLINE
	OUT 
	LDR R0, R2, #0
	OUT
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp DO_WHILE_LOOP_NEW
END_DO_WHILE_NEW

HALT

;LOCAL DATA
ARRAY_1 .BLKW #10
COUNTER .FILL #10
NEWLINE .FILL x0A


.END
