format PE console                                  ; Устанавливаем формат выходного файла, программа для консоли

entry Start                                        ; Точка входа

include 'win32a.inc'                               ; Подключаем заголовочный файл

section '.data' data readable writable             ; Секция данных, к которым мы будем обращаться

        strX db 'Enter X: ', 0                     ; Строка для ввода X
        resStr db 'Result: %d', 0                  ; Строка с результатом

        spaceStr db ' %d', 0                       ; Строка с пробелом
        emptyStr db '%d', 0                        ; Пустая строка

        infinity db 'infinity', 0                  ; Вывод infinity
        point db ',', 0                            ; Вывод запятой

        X dd ?                                     ; Считывание данных в метке
        
        NULL = 0            

section '.code' code readable executable

	finish:

		call [getch]
		push NULL
		call [ExitProcess]

section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'