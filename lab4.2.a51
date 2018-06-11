CLR 	P1.7 		; Buzzer aus
MOV 	P3, #0FFh 	; konfiguriere Port 3 als Eingang
MOV 	dptr,#50h
mov 	R1, #00h

;Timer
mov 	tmod,#02h	;timer 8-bit auto reload
setb 	ea         	;interrupt generell erlaubt
setb 	et0        	;interrupt für timer 0 erlaubt

mov 	th0,#00h	;frequenz ton

;isr
org 000bh
jmp isr

;look up
org 50h
DB 0D8h, 49h, 87h

loop:

mov 	R0, #00h
MOV 	A, P3 		; kopiere Tasterstatus in Akku
ANL 	A, #1Ch

CJNE 	A,#4h,sprung1
clr p2.0
mov 	A,R0
movc 	A, @A+dptr
mov		R1,A
acall buzzer

sprung1:
cjne 	A,08h,sprung2
clr p2.1
inc 	R0
mov 	A,R0
movc 	A, @A+dptr
mov		R1,A
acall buzzer

sprung2:
cjne 	A,10h,loop
clr p2.2
inc 	R0
inc 	R0
mov 	A,R0
movc	A, @A+dptr
mov		R1,A
acall buzzer

;;;;;;;;;;;;;;;;;;;;;;;;;
buzzer:
mov 	th0,r1
setb	tr0
taster:
MOV 	A, P3 		; kopiere Tasterstatus in Akku
ANL 	A, #1Ch
jnz 	taster
clr 	tr0
ret

;;;;;;;;;;;;;;;;;;;;;;;;;
isr:
cpl p1.7
reti


end