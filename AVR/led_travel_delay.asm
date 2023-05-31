.include "m328PBdef.inc"
.equ FOSC_MHZ= 16
.equ DEL_mS = 1
.equ F1=FOSC_MHZ*DEL_mS
    
reset:
    
    LDI r24, low(RAMEND)
    OUT SPL, r24
    LDI r24, high(RAMEND)
    OUT SPH, r24
    LDI r24, 0xfe
    ;com r24
    out ddrd, r24
    LDI r23, 0x07
    LDI r20, 0xfe
    
right_to_left:
    LDI r26, low(F1)
    LDI r25, high(F1)
    LSL r24
    ROL r20
    OR r24, r20
    
    out ddrd, r24
    RCALL delay_outer
    DEC r23 
    CPI r23, 0
    BRNE right_to_left
    OUT DDRD, r24
    RCALL delay_outer
    RCALL delay_outer
    RJMP left_to_right

left_to_right:
    LDI r26, low(F1)
    LDI r25, high(F1)

    LSR r24
    ROR r20
    OR r24, r20
    OUT DDRD, r24
    RCALL delay_outer
    INC r23
    CPI r23, 7
    BRNE left_to_right
    OUT DDRD, r24
    RCALL delay_outer
    RCALL delay_outer
    RJMP right_to_left

;wait_msec:
;    PUSH r26
;    PUSH r25
;    LDI r26, low(998)
;    LDI r25, high(998)
;    RCALL wait_usec
;    POP r25
;    POP r26
;    SBIW r26, 1
;    BRNE wait_msec
;    RET
;
;wait_usec:
;    SBIW r26, 1
;    NOP
;    NOP
;    NOP
;    BRNE wait_usec
;    RET
    
delay_inner:
    ldi r23, 247
loop3:
    dec r23
    nop
    brne loop3
    nop
    ret

    
delay_outer:
    push r26
    push r25
loop4:
    rcall delay_inner
    sbiw r26, 1
    brne loop4
    pop r26
    pop r25
    




