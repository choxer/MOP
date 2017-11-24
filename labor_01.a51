;
$DATE (13.10.2017)
$TITLE ( )
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;

;MOV P0,#0FEH ;Datenwort auf Port0(LED) -> unmittelbare "Addressierung"(#)
;MOV P0,#0AAH     
;MOV P0,#000H        
;MOV P0, #0FFH

;setb p3.2
;test:
;mov a, p3.2
;MOV P0,A  
;sjmp  test

main:

call lampeAus

call delay

call lampeAn

call delay

jmp main


lampeAn:

  mov p0,#00h

ret

lampeAus:
  
  mov p0,#0ffh

ret

delay:
  
  ;;standard->       mov r0, #000H
  ;;                 mov r1, #000H
  
  
  
  loop:
  DJNZ r0, loop
  
  DJNZ r1, loop

ret

END