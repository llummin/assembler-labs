TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

RENAME:                                ; Переименование файла    
     MOV AH, 56H                       ; Пересылка в AH функции 56H переименования файла
     LEA DX, OLDNAME                   ; Загружаем в DX адрес со старым именем файла
     LEA DI, NEWNAME                   ; Загружаем в DI адрес с новым именем файла
     INT 21h                           ; Функция прерывания

DEL:                                   ; Удаление файла
     MOV AH, 41H                       ; Пересылка в AH функции 41H удаления файла
     LEA DX, DELNAME                   ; Загружаем в DX адрес с именем удаляемого файла                   
     INT 21h                           ; Функция прерывания

EXIT:                                  ; Закрытие файла
     MOV AX, 4C00h                     ; Пересылка в AX функции 4C00h закрытия программы         
     INT 21h                           ; Функция прерывания

MAIN ENDP
     OLDNAME DB	'file1.txt',0      ; Старое имя файла	
     NEWNAME DB	'file2.txt',0      ; Новое имя файла	
     DELNAME DB	'file3.txt',0      ; Имя удаляемого файла	
     TEXT ENDS
END  MAIN
