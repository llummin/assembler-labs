TEXT SEGMENT 'CODE'
	 ASSUME CS:TEXT, SS:TEXT, DS:TEXT, ES:TEXT
	 ORG  100h
MAIN PROC

	 MOV  DX,  40h                      
	 MOV  ES,  DX             
	 SUB  CX,  CX             
			
	 MOV  AH,  09h           
	 LEA  DX,  HINT           
	 INT  21H                 

START:                   
		
	 MOV  DL, 0FFh       
	 MOV  AH, 06         
	 INT  21H            
	 JZ   EMPTYINPUT     
	 
	 CMP  AL, 68         
	 JE   EXIT           
	 
EXIT:
	 RET                 
	 
EMPTYINPUT:
	 MOV  CX, 100        
	 
CYCLE1:	 
	 PUSH CX		  	 
	 MOV  CX, 65535      
	 
CYCLE2:
	 LOOP CYCLE2         
	 POP  CX             
	 LOOP CYCLE1	     
	 
	 MOV  AH, 02          
	 INT  16H	         

CHEKCAPS: 
	 TEST AL,64          
	 JNE  PRINTCAPS	     
	 MOV  STR2+11, 30h   
	 	 
CHEKNUM:	
	 TEST AL,32           
	 JNE  PRINTNUM        
	 MOV  STR2+22, 30h    
	 
CHEKALT:
	 TEST AL,8          
	 JNE  PRINTALT        
	 MOV  STR2+30, 30h    
	 JMP  INIT            
	 
PRINTCAPS:
	 MOV  STR2+11, 31h    
	 JMP  CHEKNUM         
	 
PRINTNUM:
	 MOV  STR2+22, 31h    
	 JMP  CHEKALT         
	 
PRINTALT:
	 MOV  STR2+30, 31h	 
	 	 
INIT:                    	
	 MOV  AH,09h          
	 LEA  DX, STR2       
	 INT  21H	         
	 JMP  START           
	 
CAPS:                  
	 MOV  AL, ES:[17h]    
	 TEST AL, 64          
	 JE   ADD1             
	 AND  AL, 191          
	 MOV  ES:[17h], AL    
	 MOV  STR2+11, 30h                        
	 JMP  START           
		
ADD1:
	 OR   AL, 64	         
	 MOV  ES:[17h], AL    
	 MOV  STR2+11, 31h    
	 JMP  START           
		
NUM:
	 MOV  AL, ES:[17h]    
	 TEST AL,32           
	 JE   ADD2             
	 AND  AL,223          
	 MOV  ES:[17h], AL 
	 MOV  STR2+22, 30h
	 JMP  START

ADD2:
	 OR   AL, 32
	 MOV  ES:[17h], AL 
	 MOV  STR2+22, 31h
	 JMP  START
		
ALT:
	 MOV  AL, ES:[17h] 
	 TEST AL,8
	 JE   ADD3
	 AND  AL,247
	 MOV  STR2+30, 30h
	 MOV  ES:[17h], AL 
	 JMP  START

ADD3:	
	 OR   AL, 8            
	 MOV  ES:[17h], AL 
	 MOV  STR2+30, 31h
	 JMP  START
	 
MAIN ENDP
	 STR2 DB 0dh,0ah,'Caps Lk: 0',0dh,0ah
	 STR3 DB 'Num Lk: 0',0dh,0ah
	 STR4 DB 'ALT: 0',0dh,0ah,'$' 
	 HINT DB 'Press f10 to stop',0dh,0ah,'$'
TEXT ENDS
END MAIN