TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

OPENFILE:
     MOV AH, 3Dh         
     MOV AL, 2           
     LEA DX, FILENAME    
     INT 21h             
     MOV HANDLE, AX      

ENDFILE:
     MOV AH, 42h
     MOV AL, 02          
     MOV BX, HANDLE  
     MOV CX, 0           
     MOV DX, 0           
     INT 21h

WRITESTR:
     MOV AH, 40h
     MOV BX, HANDLE      
     MOV CX, STRING_LEN  
     LEA DX, STRING      
     INT 21h

EXIT:
     MOV AH, 3Eh     
     MOV BX, HANDLE
     INT 21h
     MOV AX, 4C00h         
     INT 21h 

MAIN ENDP
     FILENAME DB 'file1.txt', 0
     HANDLE DW ?
     STRING DB 'Bye, world!', 0Dh, 0Ah
     STRING_LEN EQU $-STRING
     TEXT ENDS
END  MAIN