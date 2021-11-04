;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 3. ex 4
; Lab section: 24
; TA: Katsubh Singh
; 
;=================================================
.ORIG x3000

LD R2, ARRAY_1_POINTER

DO_WHILE_LOOP
	GETC
	OUT 
	STR R0, R2, #0
	ADD R2, R2, #1
	ADD R0, R0, #-10
	BRp DO_WHILE_LOOP
END_DO_WHILE
ADD R0, R0, #10
OUT
;OUPUT

LD R2, ARRAY_1_POINTER

DO_WHILE_LOOP_NEW
	LDR R0, R2, #0
	OUT
	ADD R2, R2, #1
	ADD R0, R0, #-10 
	BRp DO_WHILE_LOOP_NEW
END_DO_WHILE_NEW
ADD R0, R0, #10
OUT

HALT

;LOCAL DATA
ARRAY_1_POINTER .FILL x4000
NEWLINE .FILL x0A


.END
