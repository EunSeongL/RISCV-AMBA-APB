#include <stdint.h>

#define APB_BASE  0x10000000
#define GPO_BASE  (APB_BASE + 0x1000)
#define GPO_CR    *(uint32_t *)(GPO_BASE + 0x00)
#define GPO_ODR   *(uint32_t *)(GPO_BASE + 0x04)
#define GPI_BASE  (APB_BASE + 0x2000)
#define GPI_CR    *(uint32_t *)(GPI_BASE + 0x00)
#define GPI_IDR   *(uint32_t *)(GPI_BASE + 0x04)
#define GPIO_BASE  (APB_BASE + 0x3000)
#define GPIO_CR    *(uint32_t *)(GPIO_BASE + 0x00)
#define GPIO_IDR   *(uint32_t *)(GPIO_BASE + 0x04)
#define GPIO_ODR   *(uint32_t *)(GPIO_BASE + 0x08)
#define FND_BASE  (APB_BASE + 0x4000)
#define FND_ODR    *(uint32_t *)(FND_BASE + 0x00)

void delay(uint32_t t);

int main()
{
    uint32_t data = 1;
   

    while(1){
        for (int i = 0; i < 10000; i++){
            FND_ODR = i;
            if(i == 9999){
                i = 0;
            }
            delay(100);
        }
    }
    
    return 0;
}

void delay(uint32_t t)
{
    for(uint32_t i = 0; i < t; i++){
        for(uint32_t j = 0; j < 1000; j++);
    }
}

