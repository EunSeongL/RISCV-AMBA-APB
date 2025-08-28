`timescale 1ns / 1ps

module MCU (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] gpi,
    output logic [7:0] gpo,
    inout  logic [7:0] gpio
);
    wire         PCLK = clk;
    wire         PRESET = reset;
    // APB Interface Signals
    logic [11:0] PADDR;
    logic        PWRITE;
    logic        PENABLE;
    logic [31:0] PWDATA;

    logic        PSEL_RAM;
    logic        PSEL_GPO;
    logic        PSEL_GPI;
    logic        PSEL_GPIO;

    logic [31:0] PRDATA_RAM;
    logic [31:0] PRDATA_GPO;
    logic [31:0] PRDATA_GPI;
    logic [31:0] PRDATA_GPIO;

    logic        PREADY_RAM;
    logic        PREADY_GPO;
    logic        PREADY_GPI;
    logic        PREADY_GPIO;
    // Internal Interface Signals
    logic        transfer;
    logic        ready;
    logic        write;
    logic [31:0] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;
    // CPU Interface Signals
    logic [31:0] instrCode;
    logic [31:0] instrMemAddr;
    logic        busWe;
    logic [31:0] busAddr;
    logic [31:0] busWData;
    logic [31:0] busRData;

    assign write = busWe;
    assign addr  = busAddr;
    assign wdata = busWData;
    assign busRData = rdata;

    ROM U_ROM (
        .addr(instrMemAddr),
        .data(instrCode)
    );

    CPU_RV32I U_RV32I (.*);

    RAM U_APB_RAM (
        .*,
        .PADDR(PADDR[11:0]),
        .PSEL(PSEL_RAM),
        .PRDATA(PRDATA_RAM),
        .PREADY(PREADY_RAM)
    );

    APB_Master U_APB_Master(
        .*,
        .PSEL0(PSEL_RAM),
        .PSEL1(PSEL_GPO),
        .PSEL2(PSEL_GPI),
        .PSEL3(PSEL_GPIO),
        
        .PRDATA0(PRDATA_RAM),
        .PRDATA1(PRDATA_GPO),
        .PRDATA2(PRDATA_GPI),
        .PRDATA3(PRDATA_GPIO),
        
        .PREADY0(PREADY_RAM),
        .PREADY1(PREADY_GPO),
        .PREADY2(PREADY_GPI),
        .PREADY3(PREADY_GPIO)
    );

    GPO_Periph U_GPO_Periph (
        .*,
        .PSEL(PSEL_GPO),
        .PRDATA(PRDATA_GPO),
        .PREADY(PREADY_GPO)
    );

    GPI_Periph U_GPI_Periph (
        .*,
        .PSEL(PSEL_GPI),
        .PRDATA(PRDATA_GPI),
        .PREADY(PREADY_GPI)
    );

    GPIO_Periph U_GPIOA (
        .*,
        .PSEL(PSEL_GPIO),
        .PRDATA(PRDATA_GPIO),
        .PREADY(PREADY_GPIO)
    );
endmodule
