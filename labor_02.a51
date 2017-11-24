;
$DATE (27.10.2017)
$TITLE ( )
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;pls finish!!!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SETB P3.2
setb p3.3
setb p3.4


mov r1, #0ffh       ; register1 mit 1en füllen -> Verzög.
mov r3, #0ffh 
mov r2, #000H       ; 0en in register2 -> LED AN

main:

eingabe:            ;

mov a,p3
orl a,#0e3h

jnz eingabe    ;-> springt wenn akku nicht leer ist 


;eingabe:            jb p3.2,eingabe      ; springt wenn BIT = HIGH 

;; WARTEN: taster einpendelt
lCALL delay

;; taster eingepenbdelt ?

eingabehoch:            

mov a,p3
anl a,#1ch

jz eingabehoch     ; springt wenn BIT = LOW  

lCALL delay



mov p0, r2          ; reg2 auf Port0 

mov a,r2            ; reg2 in Akku 
cpl a               ; Akku komplementieren (invert.)
mov r2,a            ; Akku in reg2 ( invertiertes reg2)

jmp main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
delay:
verzogerung:
            verzogerung2:
            nop
            djnz r3,verzogerung2

nop
djnz r1,verzogerung


mov r1, #0ffh            ; register1 mit 1en füllen -> Verzög.
mov r3, #0ffh 
RET



END