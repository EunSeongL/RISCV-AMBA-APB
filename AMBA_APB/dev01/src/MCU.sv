`timescale 1ns / 1ps

module MCU (
    input logic clk,
    input logic reset
);
    wire         PCLK = clk;
    wire         PRESET = reset;
    // APB Interface Signals
    logic [11:0] PADDR;
    logic        PWRITE;
    logic        PENABLE;
    logic [31:0] PWDATA;

    logic        PSEL_RAM;
    logic        PSEL1;
    logic        PSEL2;
    logic        PSEL3;

    logic [31:0] PRDATA_RAM;
    logic [31:0] PRDATA1;
    logic [31:0] PRDATA2;
    logic [31:0] PRDATA3;

    logic        PREADY_RAM;
    logic        PREADY1;
    logic        PREADY2;
    logic        PREADY3;
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

    RAM U_APB_RAM (.*,
        .PADDR(PADDR[11:0]),
        .PSEL(PSEL_RAM),
        .PRDATA(PRDATA_RAM),
        .PREADY(PREADY_RAM)
    );

    APB_Master U_APB_Master(.*,
        .PSEL0(PSEL_RAM),
        .PRDATA0(PRDATA_RAM),
        .PREADY0(PREADY_RAM)
        );
endmodule
