;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 3. ex 2
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
HALT

;LOCAL DATA
ARRAY_1 .BLKW #10
COUNTER .FILL #10


.END
