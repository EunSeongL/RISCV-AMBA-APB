#include <stdint.h>

typedef struct {
    uint32_t CR;
    uint32_t ODR;
} GPO_TypeDef;

typedef struct {
    uint32_t CR;
    uint32_t IDR;
} GPI_TypeDef;

typedef struct {
    uint32_t CR;
    uint32_t IDR;
    uint32_t ODR;
} GPIO_TypeDef;

typedef struct {
    uint32_t CR;
    uint32_t FDR;
} FND_TypeDef;

typedef struct {
    uint32_t CSR;
    uint32_t BRR;
    uint32_t TXD;
    uint32_t RXD;
} UART_TypeDef;

#define APB_BASE 0x10000000

#define GPO_BASE  (APB_BASE + 0x1000)
#define GPO       ((GPO_TypeDef *)(GPO_BASE))

#define GPI_BASE  (APB_BASE + 0x2000)
#define GPI       ((GPI_TypeDef *)(GPI_BASE))

#define GPIO_BASE (APB_BASE + 0x3000)
#define GPIO      ((GPIO_TypeDef *)(GPIO_BASE))

#define FND_BASE  (APB_BASE + 0x4000)
#define FND       ((FND_TypeDef *)(FND_BASE))

#define UART_BASE (APB_BASE + 0x5000)
#define UART      ((UART_TypeDef *)(UART_BASE))


void FND_Init(FND_TypeDef *fnd);
void FND_WriteData(FND_TypeDef * fnd, uint32_t d);


void delay(uint32_t t);

void UART_Init(UART_TypeDef * uart);
void UART_SetBaudrate(UART_TypeDef * uart, uint32_t baud);
void UART_SendData(UART_TypeDef * uart, uint32_t data);
uint32_t UART_ReceiveData(UART_TypeDef * uart);

int main()
{

    //FND_Init(FND);
    UART_Init(UART);

    //uint32_t fnd_data = 0;
    uint32_t uart_data = 0;
    uint32_t baudrate = 9600;

/*
    while(1)
    {
      FND_WriteData(FND, fnd_data);
      fnd_data++;
      delay(1000);  
    }
*/

    UART_SetBaudrate(UART, baudrate);

    while(1)
    {
        // Loop Back for test
        uart_data = UART_ReceiveData(UART);
        delay(10);
        UART_SendData(UART, uart_data);
    }

    return 0;
}

/*
void FND_Init(FND_TypeDef *fnd)
{
    fnd->CR = 0x01;
}

void FND_WriteData(FND_TypeDef * fnd, uint32_t d)
{
    fnd->FDR = d;
}
*/

void delay(uint32_t t)
{
    for(int i = 0; i < t; i++){
        for(int j=0;j<1000;j++);
    }
}

void UART_Init(UART_TypeDef * uart)
{
    uart->CSR = 0x03;
}

void UART_SetBaudrate(UART_TypeDef * uart, uint32_t baud)
{
    uart->BRR = baud;
}

void UART_SendData(UART_TypeDef * uart, uint32_t data)
{
    uart->TXD = data;
}

uint32_t UART_ReceiveData(UART_TypeDef * uart)
{
    while(!(uart->CSR&(0x01<<4)));
    return uart->RXD;
}