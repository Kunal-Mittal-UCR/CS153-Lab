;=================================================
; Name: Kunal Mittal 
; Email: kmitt006@ucrl.edu
; 
; Lab: lab 4, ex 1
; Lab section: 24
; TA: Katsubh Singh
; 
;=================================================
.orig x3000

AND R1, R1, #0
ADD R1, R1, #10
LD R3, ARRAY_POINTER
AND R4, R4, #0

WHILE_LOOP
	STR R4, R3, #0
	ADD R3, R3, #1
	ADD R4, R4, #1
	ADD R1, R1, #-1
	BRp WHILE_LOOP
END_OF_WHILE_LOOP

LD R3, ARRAY_POINTER
ADD R3, R3, #6
LDR R2, R3, #0

HALT

;Data
ARRAY_POINTER .FILL x4000

;Remote Data
.orig x4000
ARRAY_1 .BLKW #10
