# DAY 3

(*) 0x10000000
(*)은 주소를 가리키게 된다.

메모리 공간을 잡고 싶을 때
(int *) 0x10000000 
int 는 4Byte 

Data Type
-> 자료형
-> Data 형태
-> Data 모양
-> Data 크기 -> Memory 안에 있는 값 

(int *) 0x10000000 
메모리 공간 4Byte만큼 할당

(char *) 0x10000008
메모리 공간 1Btye만큼 할당

```c
#define FND_BASE  (APB_BASE + 0x4000)

typedef struct
{
    uint32_t CR;
    uint32_t FDR;
} FND_TypeDef;
```

(FND_TypeDef *) 0x10004000
-> uint32_t CR, uint32_t FDR 총 8Byte
컴파일러는 메모리 공간 8Byte만큼 할당

```c
((FND_TypeDef *) (0x10004000)).CR => 주소
((FND_TypeDef *) (0x10004000)) -> CR = 0x01 => 주소 안의 메모리 공간 
```

포인터 변수는 주소를 가리키는 변수 

주소가 4Byte일 때,

int *pA; => pA는 주소를 받는 변수

char *pB; => pB는 4Byte, *pB는 1Byte

int **ppA => ppA = &pA => 0x10001000
int *pA => pa = &A => 0x10000000
int *A

**ppA = 10