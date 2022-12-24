; Y = ((X + 1) * 10 % 3 - 150)/ X
format PE console                                     ; Устанавливаем формат выходного файла, программа для консоли

entry Start                                           ; Точка входа

include 'win32a.inc'                                  ; Подключаем заголовочный файл

section '.data' data readable writable                ; Секция данных, к которым мы будем обращаться

        strX db 'Enter X: ', 0                        ; Строка для ввода X
        resStr db 'Y: %d', 0                          ; Строка с результатом

        spaceStr db ' %d', 0                          ; Строка с пробелом
        emptyStr db '%d', 0                           ; Пустая строка

        error db 'Error: zero or not a number', 0     ; Вывод ошибки, когда ввели 0 или не число
        space db '', 0
        point db ',', 0                               ; Вывод запятой

        X dd  0                                       ; Считывание данных в метке X
        A dd ?
        B dd ?

        NULL = 0            

section '.code' code readable executable              ; Секция кода

        Start:
                push strX                             ; Помещаем в стек strX
                call [printf]                         ; Вызываем функцию printf

                push X                                ; Помещаем в стек метку X
                push spaceStr                         ; Помещаем в стек пустую строку
                call [scanf]                          ; Вызываем функцию scanf

        Null:
                cmp  [X], 0                           ; Проверка на 0
                jne  notNull                          ; Если не 0, то переходим на notNull

                push error                            ; Помещаем в стек infinity
                call [printf]                         ; Вызываем функцию printf
                jmp  finish                           ; Переходим к завершению программы, если X = 0

        notNull:
                mov  eax, [X]                         ; Помещаем X --> eax
                add  eax, 1                           ; Добавляем к eax единицу

                mov  ecx, 10                          ; Помещаем 10 --> ecx
                imul ecx                              ; Умножение на ecx

                mov  ecx, 3                           ; Помещаем 3 --> ecx
                idiv ecx                              ; Деление

                mov  ecx, edx                         ; Помещаем edx --> ecx
                sub  ecx, 150                         ; Вычитание
                neg  ecx                              ; Делаем ecx положительным

                mov  [A], ecx                         ; Помещаем ecx --> A
                mov  eax, ecx                         ; Помещаем ecx --> eax
                mov  ecx, [X]                         ; Помещаем X --> ecx
                mov  edx, 0                           ; Помещаем 0 --> edx
                idiv ecx                              ; Деление
                neg  eax                              ; Делаем eax с другим знаком

                push eax                              ; Помещаем в стек eax
                push resStr                           ; Помещаем в стек результат
                call [printf]                         ; Вызываем функцию printf

        finish:
 
                call [getch]                          ; Вызываем функцию getch
                push NULL                             ; Добавляем в стек NULL
                call [ExitProcess]                    ; Вызываем функцию ExitProcess


section '.idata' import data readable                 ; Секция библиотек

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'