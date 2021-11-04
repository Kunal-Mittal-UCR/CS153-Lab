;=================================================
; Name: Kunal Mittal
; Email: kmitt006@ucr.edu
; 
; Lab: lab 2. ex 2
; Lab section: 24
; TA: Katsubh Singh
; 
;=================================================
.ORIG x3000
LDI R3, DEC_65_PTR
LDI R4, HEX_41_PTR

ADD R3, R3, #1
ADD R4, R4, #1

STI R3, DEC_65_PTR
STI R4, HEX_41_PTR
HALT

;LOCAL DATA
DEC_65_PTR .FILL x4000
HEX_41_PTR .FILL x4001

;REMOTE DATA
.ORIG x4000
.FILL #65
.FILL x41

.END
