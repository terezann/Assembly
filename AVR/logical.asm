    .include "m328PBdef.inc"
    
reset:
    LDI r24, low(RAMEND)
    OUT SPL, r24
    LDI R24, high(RAMEND)
    OUT SPH, r24
    
    ;----------------

    
start:
    
    in r25, low(pinb)
    ori r25, 0xf0
    
    
    mov r26, r25
    ori r26, 0x0E
    mov r1, r26		;first lsb A (pb0)

    mov r26, r25
    ORI r26,0x0D
    ror r26		
    mov r2, r26		;second lsb B (pb1)
    
    mov r26, r25
    ori r26, 0x0B
    ror r26
    ror r26
    mov r3, r26		;third lsb  C (pb2)
    
    mov r26, r25
    ori r26, 0x07
    ror r26
    ror r26
    ror r26
    mov r4, r26		;forth lsb D (pb3)
    
    OR r1,r2
    COM r2
    OR r2, r4
    AND r1, r2
    MOV r16, r1
    
    
    ;Second Ask
    CLR R1
    CLR R2
    CLR R3
    CLR R4
    
    mov r26, r25
    ori r26, 0x0E
    mov r1, r26		;first lsb A (pb0)

    mov r26, r25
    ORI r26,0x0D
    ror r26		
    mov r2, r26		;second lsb B (pb1)
    
    mov r26, r25
    ori r26, 0x0B
    ror r26
    ror r26
    mov r3, r26		;third lsb  C (pb2)
    
    mov r26, r25
    ori r26, 0x07
    ror r26
    ror r26
    ror r26
    mov r4, r26		;forth lsb D (pb3)
    
    com r1 
    com r3
    AND r1, r3

    com r4
    AND r4, r2

    OR r1,R4
    mov r26, r1
    rol r26
    ori r26, 0xfd
    and r26, r16
    
    out ddrc, R26
   
    rjmp start
