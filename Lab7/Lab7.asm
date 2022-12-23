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

        X dd ?                                     ; Считывание данных в метке X

        
        NULL = 0            

section '.code' code readable executable           ; Секция кода

        Start:
                push strX                          ; Помещаем в стек strX
                call [printf]                      ; Вызываем функцию printf 

                push X                             ; Помещаем в стек метку X
                push spaceStr                      ; Помещаем в стек пустую строку
                call [scanf]                       ; Вызываем функцию scanf

                mov   eax, [X]                     ; Помещаем X --> eax
                add   eax, 1                       ; Добавляем к eax единицу

                mov   ecx,10                       ; Помещаем 10 --> ecx
                imul  ecx                          ; Умножение на ecx

                mov   ecx, 3                       ; Помещаем 3 --> ecx
                idiv  ecx                          ; Деление

                mov ecx, edx                       ; Помещаем edx --> ecx
                sub ecx, 150                       ; Вычитание

                push  ecx                          ; Занесем в стек значение, которое хранится в edx
                push  resStr                       ; Занесем в стек строку, которая содержит resStr
                call  [printf]                     ; Вызываем функцию printf по ее адресу

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