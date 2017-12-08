;
$DATE (08.12.2017)
$TITLE ( 7Segment)
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;


org 0000h
jmp main

org 000bh
jmp Segment

main: 
call initialisierung

haupt:
  
  

jmp  haupt

;;;;;;;;;;;;;;;;;;;;Initialisierung;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;SCON register zur bedinung der seriellen schnittstelle
;;;TMOD register zur bedinung des Timers
;;pcon mode auf 1

initialisierung:
                
                
                
                ;;timer0
                mov  r0 , #0Fh           ;;links
                mov  r1 , #0Fh          ;; rechts
                setb ea               ;interrupt generell erlaubt
                setb et0              ;interrupt für timer 0 erlaubt 
                mov  dptr , #Tabelle
                
                mov th0, #0FEh        
                mov tl0, #0FEh
               
                clr F0
                setb tr0 
                
                
RET
;;;;;;;;;;;;;;;;;;;;look-up Tabelle;;;;;;;;;;;;;;;;;;;;;;;;;;;
               ;; FGORMAT: dp g f e d c b a 
Tabelle:  
         DB 00111111b  ;; 0
         DB 00000110b  ;; 1
         DB 01011011b  ;; 2
         DB 01001111b  ;; 3
         DB 01100110b  ;; 4
         DB 01101101b  ;; 5
         DB 01111101b  ;; 6  
         DB 00000111b  ;; 7,8,9,a,b,c,d
         DB 01111111b
         DB 01110111b 
         DB 01110111b 
         DB 01111100b
         DB 00111001b
         DB 01011110b  
         DB 01111001b
         DB 01110001b ;; e,f 

;;;;;;;;;;;;;;;;;;;;7Segment;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Segment:
         
        cpl  p2.0
        cpl  F0
        
        jnb F0 , marke              ;; wenn F0 nicht gesetzt -> springe marke
        mov  a , R0                 ;; inhalt R0 -> Akku 
        movc a , @a + dptr
        mov p0 , a 
reti       
        marke:
        mov  a , R1
        movc a , @a + dptr
        mov p0 , a 

reti
END
