TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

OPENFILE:                                   ; Открытие файла      
     MOV AH, 3Dh                            ; Пересылка в AH функции 3Dh открытия файла         
     MOV AL, 2                              ; Пересылка в AL режима доступа (2 - запись и чтение)           
     LEA DX, FILENAME                       ; Загружаем в dx адрес с именем файла    
     INT 21h                                ; Функция прерывания             
     MOV HANDLE, AX                         ; Handle - переменная для записи номера файла      

ENDFILE:                                    ; Установка указателя на конец файла
     MOV AH, 42h                            ; Функция для установки указателя
     MOV AL, 02                             ; Режим установки указателя - знаковое смещение от конца файла          
     MOV BX, HANDLE                         ; Установливаем дескриптор   
     MOV CX, 0                              ; Старшая часть смещения           
     MOV DX, 0                              ; Младшая часть смещения           
     INT 21h                                ; Функция прерывания

WRITESTR:                                   ; Запись строки
     MOV AH, 40h                            ; Функция вывода строки
     MOV BX, HANDLE                         ; Установливаем дескриптор      
     MOV CX, STRING_LEN                     ; Число пересылаемых байт  
     LEA DX, STRING                         ; Адрес буфера      
     INT 21h                                ; Функция прерывания

EXIT:                                       ; Закрытие файла
     MOV AH, 3Eh                            ; Пересылка в AH функции 3Eh закрытия файла     
     MOV BX, HANDLE                         ; Установливаем дескриптор
     INT 21h                                ; Функция прерывания
     MOV AX, 4C00h                          ; Пересылка в AX функции 4C00h закрытия программы         
     INT 21h                                ; Функция прерывания 

MAIN ENDP
     FILENAME DB 'file1.txt', 0             ; Имя файла
     HANDLE DW ?                            ; Ячейка для дескриптора
     STRING DB 'Bye, world!', 0Dh, 0Ah      ; Строка для записи в файл
     STRING_LEN EQU $-STRING                ; Длина строки
     TEXT ENDS
END  MAIN
