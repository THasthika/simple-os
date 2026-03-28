#include <kernel/pmm.h>
#include <kernel/multiboot.h>
#include <string.h>

#define MAX_FRAMES 32768    // 128MB worth of frames (enough for now)

static uint32_t bitmap[MAX_FRAMES / 32];
static uint32_t total_frames;

static void bitmap_set(uint32_t frame) {
    bitmap[frame / 32] |= (1 << (frame % 32));
}

static void bitmap_clear(uint32_t frame) {
    bitmap[frame / 32] &= ~(1 << (frame % 32));
}

static int bitmap_test(uint32_t frame) {
    return bitmap[frame / 32] & (1 << (frame % 32));
}

// defined in linker script
extern uint32_t _kernel_end;

void pmm_init(uint32_t mboot_addr) {
    struct multiboot_info *mboot = (struct multiboot_info *)mboot_addr;

    // mark all frames as used
    memset(bitmap, 0xFF, sizeof(bitmap));

    // walk the memory map, free usable regions
    uint32_t mmap_end = mboot->mmap_addr + mboot->mmap_length;
    uint32_t entry_addr = mboot->mmap_addr;

    while (entry_addr < mmap_end) {
        struct multiboot_mmap_entry *entry =
            (struct multiboot_mmap_entry *)entry_addr;

        if (entry->type == 1) {  // usable
            uint32_t base = entry->addr_low;
            uint32_t length = entry->len_low;
            uint32_t frame_start = base / FRAME_SIZE;
            uint32_t frame_end = (base + length) / FRAME_SIZE;

            if (frame_end > MAX_FRAMES)
                frame_end = MAX_FRAMES;

            for (uint32_t i = frame_start; i < frame_end; i++)
                bitmap_clear(i);

            if (frame_end > total_frames)
                total_frames = frame_end;
        }

        entry_addr += entry->size + 4;
    }

    // re-mark kernel frames as used (0 to kernel_end)
    uint32_t kernel_end = (uint32_t)&_kernel_end;
    uint32_t kernel_frames = (kernel_end + FRAME_SIZE - 1) / FRAME_SIZE;
    for (uint32_t i = 0; i < kernel_frames; i++)
        bitmap_set(i);
}

uint32_t pmm_alloc_frame(void) {
    for (uint32_t i = 0; i < total_frames; i++) {
        if (!bitmap_test(i)) {
            bitmap_set(i);
            return i * FRAME_SIZE;
        }
    }
    return 0;  // out of memory
}

void pmm_free_frame(uint32_t addr) {
    uint32_t frame = addr / FRAME_SIZE;
    bitmap_clear(frame);
}