TEXT SEGMENT 'CODE'
     ASSUME CS:text,SS:text,DS:text,ES:text
     ORG 100h
MAIN PROC

OPENFILE:                           ; Открытие файла
     MOV AH, 3Dh                    ; Пересылка в AH функции 3Dh открытия файла
     MOV AL, 2                      ; Пересылка в AL режима доступа (2 - запись и чтение) 
     LEA DX, FILENAME               ; Загружаем в dx адрес с именем файла
     INT 21h                        ; Функция прерывания
     MOV HANDLE, AX                 ; Handle - переменная для записи номера файла 	

READFILE:                           ; Чтение файла
     MOV AH, 3Fh                    ; Пересылка в AH функции 3Fh чтения файла
     MOV BX, HANDLE                 ; Установливаем дескриптор
     MOV CX, 80                     ; Прочитать 80 байт	
     LEA DX, BUFIN                  ; В область ввода	 
     INT 21h                        ; Функция прерывания
     MOV CX, AX                     ; Столько прочитали	

WRITELINE:                          ; Вывод прочитанного на экран
     MOV AH, 40h                    ; Функция вывода
     MOV BX, 1	                     ; Дескриптор экрана
     LEA DX, BUFIN                  ; Отсюда выводим CX байт	
     INT 21h                        ; Функция прерывания

EXIT:                               ; Закрытие файла
     MOV AH, 3Eh                    ; Пересылка в AH функции 3Eh закрытия файла     
     MOV BX, HANDLE                 ; Установливаем дескриптор
     INT 21h                        ; Функция прерывания
     MOV AX, 4C00h                  ; Пересылка в AX функции 4C00h закрытия программы
     INT 21h                        ; Функция прерывания 

MAIN ENDP
     FILENAME DB 'file1.txt', 0     ; Имя файла
     HANDLE DW ?                    ; Ячейка для дескриптора
     BUFIN DB 80 DUP(' ')           ; Область ввода
     TEXT ENDS
END  MAIN
