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

void delay(uint32_t t);
                            
int main()
{
    enum{LEFT, RIGHT};

    uint32_t data = 1;

    GPO_CR = 0xFF;
    GPI_CR = 0xFF;
    GPIO_CR |= 0x0F;
    GPIO_CR &= ~(0x0F<<4);
    
    uint32_t state = LEFT;

    while(1){
        switch(state)
        {
            case LEFT:
                data = (data >> 7) | (data << 1);
                if(GPIO_IDR & (1<<5)) state = RIGHT;
                break;
            case RIGHT:
                data = (data << 7) | (data >> 1);
                if(GPIO_IDR & (1<<6)) state = LEFT;
                break;
        }
        GPO_ODR = data;
        //data = GPI_IDR;
        delay(1000);
    }
    return 0;
}

void delay(uint32_t t)
{
    for(uint32_t i = 0; i < t; i++){
        for(uint32_t j = 0; j < 1000; j++);
    }
}

