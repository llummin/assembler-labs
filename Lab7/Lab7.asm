; Y = ((X + 1) * 10 % 3 - 150)/ X
format PE console                                  ; Устанавливаем формат выходного файла, программа для консоли

entry Start                                        ; Точка входа

include 'win32a.inc'                               ; Подключаем заголовочный файл

section '.data' data readable writable             ; Секция данных, к которым мы будем обращаться

        strX db 'Enter X: ', 0                     ; Строка для ввода X
        resStr db 'Y: %d', 0                       ; Строка с результатом

        spaceStr db ' %d', 0                       ; Строка с пробелом
        emptyStr db '%d', 0                        ; Пустая строка

        infinity db 'infinity', 0                  ; Вывод infinity
        point db ',', 0                            ; Вывод запятой

        X dd ?                                     ; Считывание данных в метке
        
        NULL = 0            

section '.code' code readable executable           ; Секция кода

        Start:
                push strX                          ; Помещаем в стек strX
                call [printf]                      ; Вызываем функцию printf 

                push X                             ; Помещаем в стек метку X
                push spaceStr                      ; Помещаем в стек пустую строку
                call [scanf]                       ; Вызываем функцию scanf
                jmp  M1                            ; Переход к метке M1

        M1:                                        ; Операция сложения на единицу
                mov  eax, [X]                      ; Помещаем в eax X
                add  eax, 1                        ; Добавляем к eax единицу
                jmp  M2                            ; Переход к произведению

        M2:
                imul eax, 10                       ; Умножение eax на 10

        result:
                push eax                           ; Занесем в стек значение, которое хранится в eax
                push resStr                        ; Занесем в стек строку, которая содержит resStr
                call [printf]                      ; Вызываем функцию printf по ее адресу  
                jmp  finish                        ; Переходим к метке выхода из программы
        finish:
                call [getch]                       ; Вызываем функцию getch
                push NULL                          ; Добавляем в стек NULL
                call [ExitProcess]                 ; Вызываем функцию ExitProcess

section '.idata' import data readable              ; Секция библиотек

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'