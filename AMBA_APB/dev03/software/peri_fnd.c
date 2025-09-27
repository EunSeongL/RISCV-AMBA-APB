#include <stdint.h>

void delay(uint32_t t);

typedef struct
{
    uint32_t CR;
    uint32_t FDR;
} FND_TypeDef;

#define APB_BASE  0x10000000
#define FND_BASE  (APB_BASE + 0x4000)
#define FND       ((FND_TypeDef *)(FND_BASE))

void FND_init(FND_TypeDef *fnd);
void FND_WriteData(FND_TypeDef *fnd, uint32_t d);

int main()
{
    FND_init(FND);
    
    uint32_t data = 0;

    while(1)
    {
        FND_WriteData(FND, data);
        data++;
        delay(1000);
    }
    return 0;
}

void FND_init(FND_TypeDef *fnd)
{
    fnd->CR = 0x01;
}

void FND_WriteData(FND_TypeDef * fnd, uint32_t d)
{
    fnd->FDR = d;
}

void delay(uint32_t t)
{
    for (int i = 0; i < t; i++){
        for(int j = 0; j < 1000; j++);
    }
}

