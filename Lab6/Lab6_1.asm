TEXT SEGMENT 'CODE'                           
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

CREATEFILE:                                     ; Метка создания файла
     MOV AH, 3Ch                                ; Пересылка в AH функции 3Ch создания файла
     MOV CX, 0                                  ; Файл без атрибутов   
     LEA DX, FILENAME                           ; Загружаем в dx адрес с именем файла
     INT 21h                                    ; Функция прерывания                                                 
     MOV HANDLE, AX                             ; Handle - переменная для записи номера файла 

WRITELINE:                                      ; Метка для записи строки
     MOV AH, 40h                                ; Функция вывода строки
     MOV BX, HANDLE                             ; Установливаем дескриптор   
     MOV CX, STRING_LEN                         ; Число пересылаемых байт            
     LEA DX, STRING                             ; Адрес буфера        
     INT 21h                                    ; Функция прерывания        

EXIT:                                           ; Метка закрытия файла
     MOV AH, 3Eh                                ; Пересылка в AH функции 3Eh закрытия файла     
     MOV BX, HANDLE                             ; Установливаем дескриптор 
     INT 21h                                    ; Функция прерывания
     MOV AX, 4C00h                              ; Пересылка в AX функции 4C00h закрытия программы                                       
     INT 21h                                    ; Функция прерывания 

MAIN ENDP
     FILENAME DB 'file1.txt', 0                 ; Имя файла
     HANDLE DW ?                                ; Ячейка для дескриптора 
     STRING DB 'Hello, world!', 0Dh, 0Ah        ; Строка для записи в файл
     STRING_LEN EQU $-STRING                    ; Длина строки
     TEXT ENDS
END MAIN
