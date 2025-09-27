# RISCV-AMBA-APB

![alt text](img/AMBA_APB_BD.png)

## 프로젝트 개요
> 직접 설계한 RISC-V RV32I CPU에 AMBA APB 버스를 기반으로 다양한 Peripheral 기능을 추가하고자 하였습니다.
## 개발 일정

| 구분                  | 8.27 | 8.28 | 8.29 | 8.30 | 8.31 | 9.1 |
|:----:|:----:|:----:|:----:|:----:|:----:|:---:|
| AMBA APB 구조 설계     |  O  |  O  |  O  |  O  |  O  |  O  |
| RAM, GPO Peripheral  |  O  |  O  |      |      |      |     |
| GPI, GPIO Peripheral |      |  O  |  O  |  O  |      |     |
| FND Peripheral       |      |      |      |  O  | O  |     |
| UART Peripheral      |      |      |      |    | O  |  O |

## 개발 환경

|       | **TOOL** |
| :-----: | :-----: |
| **IDE**   | ![VSCode](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white) |
| **Language** | ![Verilog](https://img.shields.io/badge/Verilog-5C2D91?style=for-the-badge&logoColor=white) ![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white) |
| **EDA**   | ![Vivado](https://img.shields.io/badge/Xilinx%20Vivado-FFB500?style=for-the-badge&logo=xilinx&logoColor=white) |

## APB (AMBA Peripheral Bus)

|**Write transfer with no wait states** | **Read transfer timing diagram** |
| :---: | :---: |
|<img width="450" height="250" alt="image" src="./img/Write transfer with no wait states .png">|<img width="450" height="250" alt="image" src="./img/Read transfer timing diagram.png">|

<div align="center">
    <img width="300" height="300" alt="image" src="./img/state.png"><br>
    State Diagram
</div>

## Memory Map

<details>
    <summary> 📝 Memory Map</summary>
    <img width="850" height="450" alt="image" src="./img/Memory_Map.png">
</details>

## Peripheral Block Diagram

<details>
    <summary> 🔖 RAM </summary>
    <img src="./img/APB_RAM.png" width=550 height=400>
</details>

<details>
    <summary> 🔖 GPO </summary>
    <img src="./img/APB_GPO.png" width=450 height=400>
</details>

<details>
    <summary> 🔖 GPI </summary>
    <img src="./img/APB_GPI.png" width=450 height=400>
</details>

<details>
    <summary> 🔖 GPIO </summary>
    <img src="./img/APB_GPIO.png" width=450 height=400>
</details>

<details>
    <summary> 🔖 FND </summary>
    <img src="./img/APB_FND.png" width=450 height=400>
</details>

<details>
    <summary> 🔖 UART </summary>
    <img src="./img/APB_UART.png" width=450 height=400>
</details>
