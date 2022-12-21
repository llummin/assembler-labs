TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC
    
WINDOW:
     MOV AH, 06h
     MOV AL, 0           
     MOV BH, 2Eh         
     MOV CH, 0           
     MOV CL, 0           
     MOV DH, 26          
     MOV DL, 88          
     INT 10h

WINDOW2:
     MOV AH, 06h
     MOV AL, 0           
     MOV BH, 0Eh         
     MOV CH, 8           
     MOV CL, 26          
     MOV DH, 20          
     MOV DL, 54          
     INT 10h

MESSAGE:
     MOV AH, 13h 
     MOV AL, 1       	  
     MOV BL, 70h     	  
     MOV BH, 0       	  
	 MOV CX, 13     		
     MOV DH, 14          
     MOV DL, 34          
     MOV BP, OFFSET MSG  
     INT 10h
		
EXIT:
     MOV AH, 06h
     MOV BH, 07h 
     MOV CH, 0
     MOV CL, 0
     MOV DH, 46
     MOV DL, 88
     INT 10h

     MOV AH, 02h
     MOV BH, 0
	 MOV DX, 0
     INT 10h

     MOV AX, 4C00h
     INT 21h 

MAIN ENDP
     MSG  DB 'Hello, World!','$'
     TEXT ENDS
END MAIN