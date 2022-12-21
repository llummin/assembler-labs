TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

RENAME:    
     MOV AH,56H
     LEA DX,OLDNAME
     LEA DI,NEWNAME
     INT 21h

DEL:
     MOV AH,41H
     LEA DX,DELNAME
     INT 21h

EXIT:
     MOV AX, 4C00h         
     INT 21h

MAIN ENDP
     OLDNAME DB	'file1.txt',0	
     NEWNAME DB	'file2.txt',0	
     DELNAME DB	'file3.txt',0	
     TEXT ENDS
END  MAIN
