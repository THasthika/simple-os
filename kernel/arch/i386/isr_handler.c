#include <stdint.h>
#include <stdio.h>
#include <kernel/tty.h>
#include <kernel/io.h>
#include <kernel/pic.h>

struct isr_frame {
    uint32_t gs, fs, es, ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;  // pusha
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags, useresp, ss;              // pushed by CPU
} __attribute__((packed));

void isr_handler(struct isr_frame *frame) {
    // // printf("Exception: %d\n", frame->int_no);
    // printf("Exception: ");
    // // temp: print as single digit/char until printf supports %d
    // terminal_writestring("Exception triggered\n");

    if (frame->int_no >= 32 && frame->int_no <= 47) {
        if (frame->int_no == 33) {
            uint8_t scancode = inb(0x60);
            printf("Key: %d\n", scancode);
        }
        pic_send_eoi(frame->int_no - 32);
    } else {
        printf("Exception: %d\n", frame->int_no);
        // TODO: print exception number when printf supports %d
    }

}