BITS 64
section     .text
global      _start 

print_lf:
    mov    rsi,lf   ; line feed 
    mov    rax,1    ; write syscall
    mov    rdi,1    ; stdout
    mov    rdx,1    ; string length
    syscall
    ret

print_str:
    mov    rax,1    ; write syscall
    mov    rdi,1    ; stdout
    mov    rdx,4    ; string length
    syscall
    ret

print_int:
    mov    r9, 2
    mov    rax,rsi
digits_loop:
    xor    rdx,rdx
    mov    rcx,10   ; divide by 10
    div    rcx      ; result in rax, modulus in rdx
    
    add    rdx,0x30 ; convert to char
    mov    [buf+r9], dl ; store low byte in buffer, left to right
    dec    r9       ; decrement offset
    
    cmp    rax, 0   ; last digit check
    jnz    digits_loop

    mov    rax,1    ; write syscall
    mov    rdi,1    ; stdout
    mov    rsi,buf 
    mov    rdx,3    ; string length
    syscall
    
    call print_lf
    ret 

print_fizz:
    mov    rsi, f
    call   print_str
    call   print_lf
    ret

print_buzz:
    mov    rsi,b
    call   print_str
    call   print_lf
    ret

print_fizzbuzz:
    mov    rsi,f
    call   print_str
    mov    rsi,b
    call   print_str
    call   print_lf
    ret

_start: 
    xor    r8,r8    ; zero r8, as counter
main_loop:
    inc    r8
    xor    r9,r9    ; testing variable register
    xor    rdx,rdx  ; set rdx to 0

    mov    rax,r8   
    mov    rcx,3    ; divide by 3
    div    rcx
    cmp    rdx,0    ; check modulus
    jnz    not_div_3
    or     r9,1     ; r9 + 1 if divisible by 3
not_div_3:
    xor    rdx,rdx
    mov    rax,r8
    mov    rcx,5    ; divide by 5
    div    rcx
    cmp    rdx,0    ; check modulus
    jnz not_div_5
    or     r9,2     ; r9 + 2 if divisible by 5
not_div_5:
    ; r9 == 1: fizz, r9 == 2: buzz, r9 == 3: fizzbuzz, r9 == 0: number
    cmp    r9,0
    je     number
    cmp    r9,1
    je     fizz
    cmp    r9,2
    je     buzz
    cmp    r9,3
    je     fizzbuzz
number:
    mov    rsi,r8
    call   print_int
    jmp    next
fizz:
    call   print_fizz
    jmp    next
buzz:
    call   print_buzz
    jmp    next
fizzbuzz:
    call   print_fizzbuzz
    jmp    next
next:
    cmp    r8,total
    je     exit
    jmp    main_loop
exit:
    mov    rax,60
    mov    rdi,0
    syscall

section    .data
f     db     'Fizz'
b     db     'Buzz'
lf    db     10
total equ     100
section    .bss
buf   resb   3
