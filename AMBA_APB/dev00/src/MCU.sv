`timescale 1ns / 1ps

module MCU (
    input logic clk,
    input logic reset
);

    logic [31:0] instrCode;
    logic [31:0] instrMemAddr;
    logic        busWe;
    logic [31:0] busAddr;
    logic [31:0] busWData;
    logic [31:0] busRData;
    logic        transfer;
    logic        ready;

    logic [31:0] PADDR;
    logic        PWRITE;
    logic        PENABLE;
    logic [31:0] PWDATA;
    logic        PSEL0;
    logic [31:0] PRDATA0;
    logic        PREADY0;
    
    ROM U_ROM (
        .addr(instrMemAddr),
        .data(instrCode)
    );

    CPU_RV32I U_RV32I (.*);

    APB_Master U_APB_Master (
        .PCLK       (clk),
        .PRESET     (reset),
        .PADDR      (PADDR),
        .PWRITE     (PWRITE),
        .PENABLE    (PENABLE),
        .PWDATA     (PWDATA),
        .PSEL0      (PSEL0),
        .PRDATA0    (PRDATA0),
        .PREADY0    (PREADY0),
        .transfer   (transfer),
        .ready      (ready),
        .write      (busWe),
        .addr       (busAddr),
        .wdata      (busWData),
        .rdata      (busRData)
    );

    RAM U_APB_RAM (
        .PCLK       (clk),
        .PADDR      (PADDR),
        .PWRITE     (PWRITE),
        .PENABLE    (PENABLE),
        .PWDATA     (PWDATA),
        .PSEL       (PSEL0),
        .PRDATA     (PRDATA0),
        .PREADY     (PREADY0)
    );

endmodule
