;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 24
; TA: Kaustubh Singh
; 
;=================================================

.ORIG x3000
	
	LD R1, DEC_0
	LD R2, DEC_6
	LD R3, DEC_12
	
	DO_WHILE_LOOP
		add R1, R1, R3
		add R2, R2, #-1
		BRp DO_WHILE_LOOP
	DONE_DO_WHILE_LOOP
	
	HALT

;LOCAL DATA:
	DEC_0 .FILL #0
	DEC_6 .FILL #6
	DEC_12 .FILL #12
