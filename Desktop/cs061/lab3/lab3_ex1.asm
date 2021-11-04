;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 3. ex 1
; Lab section: 24
; TA: Katsubh Singh
; 
;=================================================
.ORIG x3000
LD R5, DATA_PTR

LDR R3, R5, #0
LDR R4, R5, #1

ADD R3, R3, #1
ADD R4, R4, #1

STR R3, R5, #0
STR R4, R5, #1

HALT

;LOCAL DATA
DATA_PTR .FILL x4000


;REMOTE DATA
.ORIG x4000
.FILL #65
.FILL x41

.END
