BITS 64
section     .text
global      _start 

print_lf:
    mov    rsi,lf ; LF
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
    mov    rdx,0
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

print_fizzbuzz
    mov    rsi,f
    call   print_str
    mov    rsi,b
    call   print_str
    call   print_lf
    ret

_start: 
    call print_fizzbuzz

    mov    rax,60
    mov    rdi,0
    syscall

section    .data
f     db     'Fizz'
b     db     'Buzz'
lf    db     10
section    .bss
buf   resb   3
