TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

OPENFILE:
     MOV AH, 3Dh
     MOV AL, 2
     LEA DX, FILENAME
     INT 21h
     MOV HANDLE,AX	

READFILE:
     MOV AH, 3Fh
     MOV BX, HANDLE
     MOV CX, 80	
     LEA DX, BUFIN	
     INT 21h
     MOV CX, AX	

WRITELINE:
     MOV AH, 40h
     MOV BX, 1	
     LEA DX, BUFIN	
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
     BUFIN DB 80 DUP(' ')
     TEXT ENDS
END  MAIN