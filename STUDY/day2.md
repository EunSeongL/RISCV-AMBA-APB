# Day 2

### System Verilog - S/W 형식의 검증을 위해 태어난 언어, Java, C++ 비슷

|  | **Verilog(VHDL)** | **System Verilog** |
| :-----: | :-----: | :-----: |
| **OOP(객체 지향)** | X (class문법 X) | O (class문법 O)|
| **DataType** | H/W 중심의 DataType | S/W 중심의 DataType + S/W 기능 추가 |
| **interface** | X | O (S/W{검증용 S/W} <=> H/W{DUT H/W})연결선(interface) |
| **randomization** | random (제한적 기능) | 각 데이터 타입 변수에 random 생성과 constraint 기능 {coner case 생성} |

```
┌───────────────────────────┐
│ Verification S/W          │
│ (System Verilog)          │
└───────────┬───────────────┘
            │ 출력     │입력 
------------------------------interface
            ▼         ▲
┌───────────────────────────┐
│ DUT                       │
│ (Verilog, VHDL, SystemVerilog) │
└───────────────────────────┘
           
```

### System Verilog

```verilog
4-state(Vertor) : 0,1,x,z ex) logic, reg, wire
2-state(Vertor) : 0, 1 ex) bit

4-state(정수형) : integer(32bit)
2-state(정수형) : byte(8bit), shortint(16bit), int(32bit), longint(64bit)
```

## 배열

### 고정 길이 배열 (fixed-size array) = (static array)
- runtime에 배열 크기 변경 불가
- 이미 데이터가 몇 개인지 알 때 사용

```verilog
bit  arr[8]
byte arr1[4]     // 2-state 8bit 4개
int  arr2[16]    // 2-state 32bit 16개
```

### 동적 배열 (dynamic array)
- runtime에 배열 크기 변경 가능 
- 데이터가 몇 개인지 모를 때 사용

```verilog
bit  arr[];     // 2-state bit선언
arr = new[8];   // 2-state bit 8개

byte arr1[]      // 2-state byte 선언
arr1 = new[4];   // 2-state byte 4개

int  arr2[]      // 2-state 32bit
arr2 = new[16]   // 2-state int 16개, new : 동적 메모리 할당 후 (삭제, 변경 기능 있음)
```

### 큐 Type (Queue FIFO)

```verilog
bit que[$]
int que1[$]
que.push_back(1);
que.push_front(4);
que.pop_back();
que.pop_front();

```

```
Front          Back
┌─────┬─────┬─────┬─────┬─────┐
│  1  │  2  │  3  │     │     │ ← 1, 2, 3
└─────┴─────┴─────┴─────┴─────┘
← 1, 2, 3         
```

### 메모리 구조 

- new가 나오면 heap영역에 메모리 공간 생성 -> stack 영역에 현 주소 할당.<br>
- arr 은 Handler 라 한다.

```
┌─────────────┐
│    Stack    │
│    Heap     │
├─────────────┤
│   .Bss      │
├─────────────┤
│   .Data     │
├─────────────┤
│   .Text     │
└─────────────┘
```

### UVM 구조의 System Verilog검증 TestBench
> Simple 구조

```
+---------------------------------------+
| Test Bench                            |
|                                       |
|  +---------------------------------+  |
|  | env(class)                      |  |
|  |                                 |  |
|  |  +------------+ +------------+  |  |
|  |  | scoreboard | | generator  |  |  |
|  |  | pass  fail | | input data |  |  |
|  |  +------------+ +------------+  |  |
|  |        ▲              ▼ stimulus|  |
|  |  +------------+ +------------+  |  |
|  |  | monitor    | | driver     |  |  |
|  |  +------------+ +------------+  |  |
|  |        ▲              ▼         |  |
|  +---------------------------------+  |
|           ▲      <=      ▼            |
|  +---------------------------------+  |
|  |       Interface (connect)       |  |
|  +---------------------------------+  |
|           ▲ (output)     ▼ (input)    |
|  +---------------------------------+  |
|  |           DUT (HW)              |  |
|  +---------------------------------+  |
|                                       |
+---------------------------------------+
```

### MailBox
- generator와 driver 사이에 공유메모리 mailbox를 사용
- mailbox는 FIFO, Queue이다.

### LAB

```verilog
// transaction => 데이터의 묶음 generator내부
class transaction;
    rand bit [7:0] a;
    rand bit [7:0] b;
endclass //transaction

class generator;
    transaction tr;
    
    function new();      
    endfunction //new()

    task run(int run_count);
        repeat(run_count) begin
           tr = new(); // make instance (realized) heap memory영역에 class 자료형을 만든다
           tr.randomize();
        end
    endtask 

endclass //generator
```

```verilog
module tb_adder();              // 
    environment env;            // class
    adder_intf  adder_if();     // H/W (memory 가 아니다.)
    adder dut (                 // H/W
        .a      (adder_if.a),
        .b      (adder_if.b),
        .result (adder_if.result)
    );

    initial begin
        env = new(adder_if);   // new(virtual adder_intf adder_if = adder_if)
        env.run();
    end
endmodule
```

```verilog
class environment;
    generator gen;
    driver drv;
    mailbox #(transaction) gen2drv_mbox;

    function new(virtual adder_intf adder_if);  // virtual H/W를 S/W처럼 사용, 가상 Interface
        gen2drv_mbox = new();
        gen = new(gen2drv_mbox);
        drv = new(gen2drv_mbox, adder_if);      // 실제 H/W 정보 입력

    endfunction //new()

    task run();
        fork
            gen.run(20);
            drv.run();
        join_any
        #100; $finish();
    endtask //run

endclass //environment
```

> driver
```verilog
class driver;
    transaction tr;
    virtual adder_intf adder_if;
    mailbox #(transaction) gen2drv_mbox;

    function new(mailbox #(transaction) gen2drv_mbox, virtual adder_intf adder_if);
        this.gen2drv_mbox = gen2drv_mbox;
        this.adder_if = adder_if;
    endfunction //new()

    task run();
        forever begin
            gen2drv_mbox.get(tr);
            adder_if.a = tr.a;
            adder_if.b = tr.b;
        end
    endtask

endclass //driver
```