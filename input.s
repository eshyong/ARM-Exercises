.data

.balign 4
message1: .asciz "Hey, type a number: "

.balign 4
message2: .asciz "%d multiplied by five is: %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_read: .word 0

.balign 4
return: .word 0

.balign 4
return2: .word 0

.text

/* mult_by_5 function */
mult_by_5:
    ldr r1, addr_of_return2 /* r1 <- &addr_of_return2 */
    str lr, [r1] /* *r1 <- lr */

    add r0, r0, r0, LSL #2 /* r0 <- r0 + (r0 * 4) */
    
    ldr lr, addr_of_return2 /* lr <- &addr_of_return2 */
    ldr lr, [lr] /* lr <- &addr_of_return */
    bx lr /* Return from main using lr */
addr_of_return2: .word return2

.global main
main:
    ldr r1, addr_of_return /* r1 <- &addr_of_return */
    str lr, [r1] /* *r1 <- lr */

    ldr r0, addr_of_message1 /* r0 <- &addr_of_message1 */
    bl printf /* Call to printf(const char *format, args) */

    ldr r0, addr_of_scan_pattern /* r0 <- &addr_of_scan_pattern */
    ldr r1, addr_of_number_read /* r1 <- &addr_of_number_read */
    bl scanf /* Call to scanf(const char *format, args) */

    ldr r0, addr_of_number_read /* r0 <- &addr_of_number_read */
    ldr r0, [r0] /* r0 <- *r0 */
    bl mult_by_5

    mov r2, r0 /* r2 <- r0 (return value of mult_by_5) */
    ldr r0, addr_of_message2 /* r0 <- &addr_of_message2 */
    ldr r1, addr_of_number_read /* r1 <- &addr_of_number_read */
    ldr r1, [r1] /* r1 <- *r1 */
    bl printf

    ldr r0, addr_of_number_read /* r0 <- &addr_of_number_read */
    ldr r0, [r0] /* r0 <- *r0 */

    ldr lr, addr_of_return /* lr <- &addr_of_return */
    ldr lr, [lr] /* lr <- *lr */
    bx lr
addr_of_message1: .word message1
addr_of_message2: .word message2
addr_of_scan_pattern: .word scan_pattern
addr_of_number_read: .word number_read
addr_of_return: .word return

/* Extern */
.global scanf
.global printf
