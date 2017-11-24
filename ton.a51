;
$DATE (24.11.2017)
$TITLE (ton)
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
jmp isr

;mov r0,#0fh


main: 
call initialisierung

haupt:

empf:
jnb RI,empf
call empfangen

;djnz r0,main
jmp  haupt




 ;;;;;;;;;;;;;;;;;;;;Initialisierung;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;SCON register zur bedinung der seriellen schnittstelle
;;;TMOD register zur bedinung des Timers
;;pcon mode auf 1

initialisierung:
                
                
                mov tmod,#22h     ; 8-bit auto reload Timer 
                                  ; bit5 = M1 bit6 = M0 --> Tabelle im skript m1,m0 vertauscht
                                  ; 0001 0000 => 10h --> M0: 1
                                  ; 0010 0000 => 20h --> M1: 1
                ;uart ;timer1                 
                mov scon,#50h     ; b6 und b7 = mode = 1 = asynchron 8 bit  -> SM0: 0 SM1: 1 --> 8-Bit-UART ( Baud rate: variable  man brauch timer )
                                  ; 0101 0000 => 50h b8 => Enable
                
                orl pcon,#80h      ;1000 0000 b => 80h
                                 
                
                mov th1, #-12     ; baudrate = 4800, clk = 11.0592*10^6 Hz 
                                  ; th1 = (256 - clk) / (12(eine periode der clk enspricht 12 maschinencyklen)*16(konstante)*Baudrate)
                                  ; th1 = -12
                                  ; -12d --> 1111 0100b --> f8
                
                mov tl1, #-12     ;timer inkrementiert wert in tl1 bis overflow dann wert aus th1 in tl1              

                setb tr1

               ;beeper   timer0
                
                
                setb ea               ;interrupt generell erlaubt
                setb et0              ;interrupt für timer 0 erlaubt
                
                 
                
                mov th0, #00h     ;frequenz für ton auf mittelwert
                mov tl0, #00h
                
                setb tr0 
                
                
RET

;;;;;;;;;;;;;;;;;;Empfangen;;;;;;;;;;;;;;;;;;;;;;;;;;;                                  

empfangen:
 
 clr RI
 mov th0 , sbuf                                                                                                  
                                    
                       
RET

;;;;;;;;;;;;;;;;;;isr;;;;;;;;;;;;;;;;;;;;;;;;;;; 
isr:
cpl p3.6
reti



END
