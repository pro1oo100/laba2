section .data
    msg_err db "Введите коректное количество чисел, числа должны быть положительные",10
    len_err equ $-msg_err          
    msg_yes db "Yes "
    len_yes equ $-msg_yes          
    msg_no  db "No "
    len_no  equ $-msg_no           
    msg_dash db "- "
    len_dash equ $-msg_dash
    ; символ перевода строки
    newline db 10

section .bss
    ; буфер для ввода всех данных
    input_buffer resb 4096
section .text
    global _start                  ; точка входа

_start:
    mov rax, 0                     ; системный вызов sys_read
    mov rdi, 0                     ; дескриптор stdin
    mov rsi, input_buffer          ; адрес буфера для приёма данных
    mov rdx, 4096                  ; максимальное количество байт
    syscall                        ; вызвать ядро

    cmp rax, 0                     ; если прочитано 0 байт
    jle error                      ; то ошибка

    mov r15, rax                   ; r15 = реальная длина ввода

    xor r14, r14                   ; r14 = текущая позиция в буфере
    call skip_spaces               ; перейти к первому непробельному символу
    call read_number               ; прочитать число 
    cmp rbx, 1                     ; если была ошибка чтения
    je error                       ; то перейти к ошибке
    mov r12, rax                   ; r12 = amount
    cmp r12, 0                     ; если amount < 0
    jl error                       ; то ошибка должно быть >=0
    xor r13, r13                   ; r13 = счётчик обработанных чисел

.loop:
    cmp r13, r12                   ; если обработано все numbers
    je .newline                    ; то перейти к выводу перевода строки

    call skip_spaces               ; пропустить пробелы перед числом
    call read_number               ; прочитать очередное число
    cmp rbx, 1                     ; если ошибка чтения
    je error                       ; то ошибка
    cmp rax, 0                     ; если число <= 0
    jle error                      ; то ошибка 
    cmp rax, 100                   ; если число < 100
    jl .dash                       ; то вывести "- "
    cmp rax, 999                   ; если число > 999
    jg .dash                       ; то вывести "- "
    mov rcx, rax                   ; сохранить исходное число в rcx
    mov rdx, 0                     ; обнулить старшую часть для деления
    mov rbx, 100                   ; делитель = 100
    div rbx                        ; rax = число / 100, rdx = число % 100
    mov r8, rax                    ; r8 = сотни
    mov rax, rcx                   ; восстановить исходное число
    mov rdx, 0                     ; обнулить для деления
    mov rbx, 10                    ; делитель = 10
    div rbx                        ; rax = число / 10, rdx = число % 10
    cmp r8, rdx                    ; сравнить сотни и единицы
    jne .no                        ; если не равны -> не палиндром
.yes:
    mov rsi, msg_yes               ; адрес строки "Yes "
    mov rdx, len_yes               ; её длина
    call print                     ; вывести
    inc r13                        ; увеличить счётчик
    jmp .loop                      ; на следующую итерацию
.no:
    mov rsi, msg_no                ; адрес строки "No "
    mov rdx, len_no                ; её длина
    call print
    inc r13
    jmp .loop
.dash:
    mov rsi, msg_dash              ; адрес строки "- "
    mov rdx, len_dash              ; её длина
    call print
    inc r13
    jmp .loop
.newline:
    mov rsi, newline               ; адрес символа перевода строки
    mov rdx, 1                     ; длина 1 байт
    call print                     ; вывести
    jmp exit                       ; завершить программу

error:
    mov rsi, msg_err               ; адрес сообщения об ошибке
    mov rdx, len_err               ; его длина
    call print                     ; вывести

exit:
    mov rax, 60                    ; системный вызов sys_exit
    xor rdi, rdi                   ; код возврата 0
    syscall                        ; завершить процесс
skip_spaces:
    cmp r14, r15                   ; если текущая позиция достигла конца буфера
    jge .end                       ; то выйти (ничего не делаем)
    mov al, [input_buffer + r14]   ; загрузить байт из буфера
    cmp al, ' '                    ; пробел?
    je .skip                       ; да – пропустить
    cmp al, 9                      ; табуляция?
    je .skip
    cmp al, 10                     ; перевод строки?
    je .skip
    cmp al, 13                     ; возврат каретки?
    je .skip
    ret                            ; непробельный символ – выход
.skip:
    inc r14                        ; перейти к следующему символу
    jmp skip_spaces                ; повторить проверку
.end:
    ret
read_number:
    xor r8, r8                     ; r8 = 0 
    cmp r14, r15                   ; если позиция за концом буфера
    jge .err                       ; ошибка
    mov al, [input_buffer + r14]   ; взять символ
    cmp al, '0'                    ; если меньше '0'
    jb .err                        ; то не цифра – ошибка
    cmp al, '9'                    ; если больше '9'
    ja .err                        ; то не цифра – ошибка
    sub al, '0'                    ; преобразовать ASCII в число
    movzx r8, al                   ; поместить в младший байт r8
    inc r14                        ; перейти к следующему символу
.next_digit:
    cmp r14, r15                   ; если конец буфера
    jge .done                      ; то число закончилось
    mov al, [input_buffer + r14]   ; следующий символ
    cmp al, '0'                    ; если не цифра
    jb .done                       ; то число закончилось
    cmp al, '9'
    ja .done

    sub al, '0'                    ; цифра -> число
    movzx r9, al                   ; сохранить в r9
    imul r8, 10                    ; текущее число умножить на 10
    add r8, r9                     ; прибавить новую цифру
    inc r14                        ; продвинуться дальше
    jmp .next_digit                ; повторить
.done:
    mov rax, r8                    ; результат в rax
    xor rbx, rbx                   ; rbx = 0 (успех)
    ret
.err:
    mov rbx, 1                     ; rbx = 1 (ошибка)
    ret
print:
    mov rax, 1                     ; sys_write (1)
    mov rdi, 1                     ; stdout (1)
    syscall                        ; вызов ядра
    ret
