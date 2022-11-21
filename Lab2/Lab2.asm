TITLE   LAB2_VAR1_ELUSHEV_4317
STACKSG SEGMENT PARA STACK
  DB 64 DUP(?) 
STACKSG ENDS 
DATASG  SEGMENT PARA 'DATA'   
   MSG  DB         "String: $"
  MSG1  DB 10, 13, "Binary code: $"  
   BUF  DB 10     ; 10 символов для ввода
   LEN  DB ?
   MES  DB 10 DUP ('$')  
DATASG  ENDS 
CODESG  SEGMENT PARA 'CODE'
ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG 
ENTRY   PROC FAR 
        PUSH  DS 
        XOR   AX,AX  
        PUSH  AX 
        MOV   AX, DATASG 
        MOV   DS, AX

        MOV   AH, 09H
        MOV   DX, offset MSG
        INT   21H
 
        MOV   AH, 0Ah
        MOV   DX, offset BUF
        INT   21H
 
        MOV   AH, 09H
        MOV   DX, offset MSG1
        INT   21h
 
        MOV   SI, offset MES
        MOV   AH, 02H
        XOR   CX, CX
        MOV   CL, [LEN]

READ:
        PUSH  CX
        MOV   BL, [SI]
        MOV   CL, 08H

WRITE:
        MOV   DL, '0'
        SHL   BL, 1
        JNC   NEXT
        INC   DL

NEXT:
        INT   21H
        LOOP  WRITE
        MOV   DL, ' '
        INT   21H
        INC   SI
        POP   CX
        LOOP  READ  
 
        MOV   AH, 4Ch
        INT   21h   
        RET
ENTRY   ENDP
CODESG  ENDS
        END ENTRY


