TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC
 
     XOR  CH, CH       
     MOV  CL, DS:[80h] 
     MOV  BX, CX      
     JCXZ SIGNAL     
     DEC  CX          
     MOV  SI, 82h      
     LEA  DI, STRIN    
     CLD             
     REP  MOVSB       

     LEA  DI, STRIN
     MOV  CX, BX

FINDSYMB:
     MOV  AL, [DI]     
     CMP  AL, 20h
	 JNE  PRINT     
     INC  DI          
     LOOP FINDSYMB
		   
PRINT:
	 MOV  AH, 09h
	 LEA  DX, STRIN
	 INT  21h
     JMP  EXIT
 
SIGNAL:
     CLI                 
     IN   AL, 61h           
     MOV  CX, 2000         

BEGIN:  
     PUSH CX             
     OR   AL, 00000010b     
     OUT  61h, AL          
     MOV  CX, 1000         

M1: 
     LOOP M1 
     AND  AL,  11111101b    
     OUT  61h, AL          
     MOV  CX,1000         

M2:  
     LOOP M2 
     POP  CX              
     LOOP BEGIN          
     STI                 
	  
EXIT:
     MOV AX, 4C00H
     INT 21H

MAIN ENDP
	 STRIN  DB 256 DUP(' ')
	 STROUT DB 256 DUP(' '),'$'
TEXT ENDS
     END MAIN