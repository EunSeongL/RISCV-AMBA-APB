# Day 2

### UVM 형태의 검증
#### System Verilog - S/W 형식의 검증을 위해 태어난 언어, Java, C++ 비슷

|  | **Verilog(VHDL)** | **System Verilog** |
| :-----: | :-----: | :-----: |
| **OOP(객체 지향)** | X (class문법 X) | O (class문법 O)|
| **DataType** | H/W 중심의 DataType | S/W 중심의 DataType + S/W 기능 추가 |
| **interface** | X | O (S/W{검증용 S/W} <=> H/W{DUT H/W})연결선(interface) |
| **randomization** | random (제한적 기능) | 각 데이터 타입 변수에 random 생성과 constraint 기능 {coner case 생성} |
|  |  |  |

