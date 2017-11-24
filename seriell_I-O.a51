;
$DATE (10.11.2017)
$TITLE (seriell_I-O)
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;



lcall initialisierung
mov r0,#00h
main:

empf:
jnb RI,empf

lcall empfangen

 

jmp main


;;;;;;;;;;;;;;;;;;;;Initialisierung;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;SCON register zur bedinung der seriellen schnittstelle
;;;TMOD register zur bedinung des Timers

initialisierung:
                mov tmod,#20h     ; 8-bit auto reload Timer 
                                  ; bit5 = M1 bit6 = M0 --> Tabelle im skript m1,m0 vertauscht
                                  ; 0001 0000 => 10h --> M0: 1
                                  ; 0010 0000 => 20h --> M1: 1
                                  
                mov scon,#50h     ; b6 und b7 = mode = 1 = asynchron 8 bit  -> SM0: 0 SM1: 1 --> 8-Bit-UART ( Baud rate: variable  man brauch timer )
                                  ; 0101 0000 => 50h b8 => Enable
                orl pcon,#80h
                                  ;1000 0000 b => 80h
                
                mov th1, #-12     ; baudrate = 4800, clk = 11.0592*10^6 Hz 
                                  ; th1 = (256 - clk) / (12(eine periode der clk enspricht 12 maschinencyklen)*16(konstante)*Baudrate)
                                  ; th1 = -12
                                  ; -12d --> 1111 0100b --> f8
                
                
                
                mov tl1, #-12     ;timer inkrementiert wert in tl1 bis overflow dann wert aus th1 in tl1              

                setb tr1
RET
;;;;;;;;;;;;;;;;;;Empfangen;;;;;;;;;;;;;;;;;;;;;;;;;;;                                  
empfangen:
                          
                                    
          ;;Jnb RI,empfangen        ;JNB springt wenn bit 0
          
          clr RI                   ;RI muss gelöscht werden um wieder empfangen zu können 
          
          mov r0, SBUF             ;Empfangener vwert wird in sbuf zwichengespeichert und in register r0 verschoben
          lcall senden             
RET
;;;;;;;;;;;;;;;;;Senden;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
senden:
                                                     
         
         mov SBUF, r0              ;im register befindlicher wert wird gesendet 

         loop:Jnb TI,loop          ;JNB springt wenn bit 0
         
         clr TI                   ;TI muss gelöscht werden um wieder empfangen zu können



RET

END