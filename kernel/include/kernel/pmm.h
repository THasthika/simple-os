#ifndef PMM_HEADER
#define PMM_HEADER 1

#include <stdint.h>

#define FRAME_SIZE 4096

void pmm_init(uint32_t mboot_addr);
uint32_t pmm_alloc_frame(void);
void pmm_free_frame(uint32_t addr);

#endif