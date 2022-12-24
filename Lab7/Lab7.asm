; Y = ((X + 1) * 10 % 3 - 150)/ X
format PE console                                     ; Устанавливаем формат выходного файла, программа для консоли

entry Start                                           ; Точка входа

include 'win32a.inc'                                  ; Подключаем заголовочный файл

section '.data' data readable writable                ; Секция данных, к которым мы будем обращаться

        strX db 'Enter X: ', 0                        ; Строка для ввода X
        resStr db 'Y: %d', 0                          ; Строка с результатом
        resMinusStr db 'Y: -%d', 0                    ; Строка с результатом с минусом

        spaceStr db ' %d', 0                          ; Строка с пробелом
        emptyStr db '%d', 0                           ; Пустая строка

        error db 'Error: zero or not a number', 0     ; Вывод ошибки, когда ввели 0 или не число
        space db '', 0
        point db ',', 0                               ; Вывод запятой

        X dd ?                                        ; Считывание данных в метке X
        A dd ?                                        ; Считывание данных в метке A

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

                mov  eax, ecx                         ; Помещаем ecx --> eax
                mov  ecx, [X]                         ; Помещаем X --> ecx
                mov  edx, 0                           ; Помещаем 0 --> edx
                idiv ecx                              ; Деление
                neg  eax                              ; Делаем eax с другим знаком

                mov [A], edx                          ; Помещаем edx --> A

                cmp [X], 150                          ; Сравниваем X с 150
                jge m1                                ; Если X больше или равно 150
                jmp m2                                ; Иначе переходим на m2

        m1:
                push eax                              ; Помещаем в стек eax
                push resMinusStr                      ; Помещаем в стек результат
                call [printf]                         ; Вызываем функцию printf
                jmp p1

        m2:
                push eax                              ; Помещаем в стек eax
                push resStr                           ; Помещаем в стек результат
                call [printf]                         ; Вызываем функцию printf
                jmp p1

        p1:
                push point                            ; Помещаем в стек запятую
                call [printf]                         ; Вызываем функцию printf

                mov ebx, 0                            ; Обнуление счётчика
        lp:                                           ; Цикл для вывода дробной части

                mov  eax, [A]                         ; Помещаем edx --> A
                mov  ecx, [X]                         ; Помещаем ecx --> X
                imul eax, 10                          ; Умножаем eax на 10

                idiv ecx                              ; Деление
                mov  [A], edx                         ; Помещаем A --> edx

                cmp eax, 0                            ; Сравнение eax и 0
                jl  otr                               ; Переход, если eax < 0

                push eax                              ; Помещаем в стек результат дробной части
                push emptyStr                         ; Помещаем в стек пустую строку
                call [printf]                         ; Вызываем функцию printf
                jmp  cycle                            ; Переход на cycle

        otr:
                neg eax
                push eax                              ; Помещаем в стек результат дробной части
                push emptyStr                         ; Помещаем в стек пустую строку
                call [printf]                         ; Вызываем функцию printf

        cycle:
                add ebx, 1                            ; Увеличение счётчика на 1
                cmp ebx, 10                           ; 5 повторов
                jne lp                                ; Переход к циклу

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