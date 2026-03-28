# PIC (Programmable Interrupt Controller)

## Purpose

Manages hardware interrupts (IRQs) from devices like the keyboard and timer. Two PICs are chained together (master + slave) giving 16 IRQ lines.

## The Problem: IRQ/Exception Collision

By default the BIOS maps IRQs 0-7 to interrupts 0-7, which collide with CPU exceptions. Remapping moves them out of the way.

## Remapped Layout

| IRQ | Interrupt # | Device         |
|-----|-------------|----------------|
| 0   | 32          | PIT timer      |
| 1   | 33          | Keyboard       |
| 2   | 34          | Cascade (slave)|
| 3   | 35          | COM2 serial    |
| 4   | 36          | COM1 serial    |
| 5   | 37          | LPT2           |
| 6   | 38          | Floppy disk    |
| 7   | 39          | LPT1/spurious  |
| 8   | 40          | RTC            |
| 12  | 44          | PS/2 mouse     |
| 14  | 46          | Primary ATA    |
| 15  | 47          | Secondary ATA  |

## Remapping Sequence

4 initialization command words (ICW1-ICW4) sent to each PIC via I/O ports:

```
Master: CMD=0x20, DATA=0x21
Slave:  CMD=0xA0, DATA=0xA1

ICW1 (0x11): Start initialization, expect ICW4
ICW2: Offset (0x20 for master, 0x28 for slave)
ICW3: Cascade wiring (master: 0x04, slave: 0x02)
ICW4 (0x01): 8086 mode
```

An `io_wait()` (write to port 0x80) is needed between each command.

## EOI (End of Interrupt)

After handling a hardware IRQ, send `0x20` to the PIC command port to acknowledge it. Without EOI, the PIC won't deliver the next interrupt.

- IRQ 0-7: send EOI to master only
- IRQ 8-15: send EOI to both slave and master

## I/O Port Access

x86 uses port-mapped I/O for legacy devices. Inline assembly helpers (`outb`/`inb`) in `kernel/include/kernel/io.h`.

## Files

- `kernel/arch/i386/pic.c` — remap + EOI functions
- `kernel/include/kernel/pic.h` — declarations
- `kernel/include/kernel/io.h` — outb, inb, io_wait helpers
