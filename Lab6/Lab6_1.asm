TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

CREATEFILE:
     MOV AH, 3Ch
     MOV CX, 0
     LEA DX, FILENAME
     INT 21h
     MOV HANDLE, AX

WRITELINE:
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
     STRING DB 'Hello, world!', 0Dh, 0Ah
     STRING_LEN EQU $-STRING
     TEXT ENDS
END MAIN