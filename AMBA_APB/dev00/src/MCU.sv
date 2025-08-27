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

    ROM U_ROM (
        .addr(instrMemAddr),
        .data(instrCode)
    );

    CPU_RV32I U_RV32I (.*);

    APB_Master U_APB_Master (
        .PCLK       (clk),
        .PRESET     (reset),
        .transfer   (transfer),
        .ready      (ready),
        .write      (busWe),
        .addr       (busAddr), 
        .wdata      (busWData),
        .rdata      (busRData)
    );
endmodule
