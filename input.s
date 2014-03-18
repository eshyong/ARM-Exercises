.data

.balign 4
message1: .asciz "Hey, type a number: "

.balign 4
message2: .asciz "factorial of %d is: %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_read: .word 0

.balign 4
return: .word 0

.balign 4
return2: .word 0

.balign
return3: .word 0

.text

/* mult_by_5 function */
mult_by_5:
    /* Store lr into return2 variable */
    ldr r1, addr_of_return2
    str lr, [r1]

    add r0, r0, r0, LSL #2
    
    /* Load return2 into link register */
    ldr lr, addr_of_return2
    ldr lr, [lr]
    bx lr
addr_of_return2: .word return2

/* Input: int n
 * Returns: n!
 */
factorial:
    /* Store lr into return2 variable */
    ldr r1, addr_of_return3
    str lr, [r1]
    sub r1, r0, #1 /* Index = n - 1 */
    b cond
loop:
    mul r0, r1, r0 /* r0 = r1 * r0 */
    sub r1, r1, #1 /* r1 = r1 - 1 */
cond:
    cmp r1, #0 /* Check if index = r0 */
    bgt loop /* Loop */
end:
    ldr lr, addr_of_return3
    ldr lr, [lr]
    bx lr
addr_of_return3: .word return3

.global main
main:
    /* Store return value of main function into return variable */
    ldr r1, addr_of_return
    str lr, [r1]

    /* Call printf(&message1) */
    ldr r0, addr_of_message1
    bl printf

    /* Call scanf(&scan_pattern, &number_read) */
    ldr r0, addr_of_scan_pattern
    ldr r1, addr_of_number_read
    bl scanf

    /* Call factorial(number_read) */
    ldr r0, addr_of_number_read
    ldr r0, [r0]
    bl factorial
    
    /* Get return value of mult_by_5, then call printf(&message2, &number_read, &r0) */
    mov r2, r0
    ldr r0, addr_of_message2
    ldr r1, addr_of_number_read
    ldr r1, [r1]
    bl printf

    /* Load number_read into r0 */
    ldr r0, addr_of_number_read
    ldr r0, [r0]

    /* Load return into lr, then return */
    ldr lr, addr_of_return
    ldr lr, [lr]
    bx lr
addr_of_message1: .word message1
addr_of_message2: .word message2
addr_of_scan_pattern: .word scan_pattern
addr_of_number_read: .word number_read
addr_of_return: .word return

/* Extern */
.global scanf
.global printf
