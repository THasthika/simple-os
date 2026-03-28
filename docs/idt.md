# IDT (Interrupt Descriptor Table)

## Purpose

Tells the CPU where to jump when an interrupt fires. Without it, any exception (division by zero, invalid opcode) causes a triple fault and reboot.

## Interrupt Types

| Type               | Source           | Examples                               |
|--------------------|------------------|----------------------------------------|
| Exceptions         | CPU              | Division by zero, page fault           |
| Hardware IRQs      | External devices | Keyboard, timer, disk                  |
| Software interrupts| Code (`int N`)   | Syscalls                               |

## Entry Layout (8 bytes)

```
offset_low  [0:15]  — lower 16 bits of handler address
selector    [16:31] — code segment selector (0x08 = kernel code from GDT)
zero        [32:39] — always 0
type_attr   [40:47] — gate type + privilege + present
offset_high [48:63] — upper 16 bits of handler address
```

`type_attr = 0x8E` = present, ring 0, 32-bit interrupt gate.

## CPU Exceptions (0-31)

| #  | Name                    | Error Code |
|----|-------------------------|------------|
| 0  | Division by zero        | No         |
| 6  | Invalid opcode          | No         |
| 8  | Double fault            | Yes (0)    |
| 10 | Invalid TSS             | Yes        |
| 11 | Segment not present     | Yes        |
| 12 | Stack-segment fault     | Yes        |
| 13 | General protection fault| Yes        |
| 14 | Page fault              | Yes        |
| 17 | Alignment check         | Yes        |

## ISR Flow

1. CPU pushes `ss`, `esp`, `eflags`, `cs`, `eip` (and error code if applicable)
2. Our ISR stub pushes dummy error code (if needed) + interrupt number
3. `isr_common` saves all registers (`pusha` + segment registers)
4. Calls `isr_handler(frame)` in C
5. Restores registers, cleans up stack, `iret`

## Files

- `kernel/arch/i386/idt.c` — table setup, registers all 32 exception handlers
- `kernel/arch/i386/idt_flush.S` — `lidt` call
- `kernel/arch/i386/isr.S` — assembly stubs (macros for error/no-error code)
- `kernel/arch/i386/isr_handler.c` — C handler
- `kernel/include/kernel/idt.h` — structs and declarations
