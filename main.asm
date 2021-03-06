;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Assembly language file for Lab 1 (Embedded Systems)
; Spring 2018, The University of Iowa.
;
; LEDs are connected via a 470 Ohm resistor from PB1, PB2 to Vcc
;
; Jessica Brown, Skylar Chatman
; Group #ECET005
;
.include "tn45def.inc"
.cseg
.org 0

; Configure PB1 and PB2 as output pins.
      sbi   DDRB,1      ; PB1 is now output
      sbi   DDRB,2      ; PB2 is now output

; Main loop follows.  Toggle PB1 and PB2 out of phase.
; Assuming there are LEDs and current-limiting resistors
; on these pins, they will blink out of phase.
   loop:
      sbi   PORTB,1     ; LED at PB1 off
      cbi   PORTB,2     ; LED at PB2 on 
      rcall delay_long  ; Wait
      cbi   PORTB,1     ; LED at PB1 on
      sbi   PORTB,2     ; LED at PB2 off  
      rcall delay_long  ; Wait
      rjmp   loop		; Start over

; Generate a delay using three nested loops that does nothing. 
; With a 10 MHz clock, the values below produce ~261 ms delay.
   delay_long:
      ldi   r23,10      ; r23 <-- Counter for outer loop
  d1: ldi   r24,250     ; r24 <-- Counter for level 2 loop 
  d2: ldi   r25,252     ; r25 <-- Counter for inner loop
  d3: dec   r25			; r25 <-- r25 � 1
	  nop				; no operation 
      brne  d3			; branch to d3 if not 0 (1/2 cycles)
      dec   r24			; r24 <-- r24 � 1 
      brne  d2			; branch to d2 if not 0 (1/2 cycles)
      dec   r23			; r23 <-- r23 - 1
      brne  d1			; branch to d1 if not 0 (1/2 cycles)
      ret				; return 
.exit
