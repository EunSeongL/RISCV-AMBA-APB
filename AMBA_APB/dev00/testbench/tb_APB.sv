`timescale 1ns / 1ps

module tb_APB();

    logic        PCLK;
    logic        PRESET;
    logic [31:0] PADDR;
    logic        PWRITE;
    logic        PENABLE;
    logic [31:0] PWDATA;
    logic        PSEL0;
    logic        PSEL1;
    logic        PSEL2;
    logic        PSEL3;
    logic [31:0] PRDATA0;
    logic [31:0] PRDATA1;
    logic [31:0] PRDATA2;
    logic [31:0] PRDATA3;
    logic        PREADY0;
    logic        PREADY1;
    logic        PREADY2;
    logic        PREADY3;
    logic        transfer;
    logic        ready;
    logic        write;
    logic [31:0] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;

    APB_Master U_APB_Master(.*);

    APB_Slave U_APB_Slave0 (
        .*,
        .PSEL(PSEL0),
        .PRDATA(PRDATA0),
        .PREADY(PREADY0)
    );
    APB_Slave U_APB_Slave1 (
        .*,
        .PSEL(PSEL1),
        .PRDATA(PRDATA1),
        .PREADY(PREADY1)
    );
    APB_Slave U_APB_Slave2 (
        .*,
        .PSEL(PSEL2),
        .PRDATA(PRDATA2),
        .PREADY(PREADY2)
    );
    APB_Slave U_APB_Slave3 (
        .*,
        .PSEL(PSEL3),
        .PRDATA(PRDATA3),
        .PREADY(PREADY3)
    );

    always #5 PCLK = ~PCLK;

    initial begin
        PCLK   = 1'b0;
        PRESET = 1'b1;
        #10;
        PRESET = 1'b0;
    end

    initial begin
        #10;

        // slave 0, 1, 2, 3 write test
        @(posedge PCLK);
        #1;
        transfer = 1;
        write = 1;
        addr = 32'h1000_0000; 
        wdata = 32'd10;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        @(posedge PCLK);
        #1;
        transfer = 1;
        write = 1;
        addr = 32'h1000_1000; 
        wdata = 32'd11;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        @(posedge PCLK);
        #1;
        transfer = 1;
        write = 1;
        addr = 32'h1000_2000; 
        wdata = 32'd12;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        @(posedge PCLK);
        #1;
        transfer = 1;
        write = 1;
        addr = 32'h1000_3000; 
        wdata = 32'd13;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        @(posedge PCLK);
        #1;
        transfer = 1;
        write = 0;
        addr = 32'h1000_0000; 
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        #50;
        $finish;
    end
endmodule
