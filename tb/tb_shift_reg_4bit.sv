`timescale 1ns / 1ps

module tb_shift_reg_4bit;

    logic       clk;
    logic       rst;
    logic       enable;
    logic       serial_in;
    logic [3:0] parallel_out;

    // Instantiate the Unit Under Test (UUT)
    shift_reg_4bit uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );

    // Generate 100 MHz clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk       = 0;
        rst       = 1;
        enable    = 0;
        serial_in = 0;
        #15;

        // Release reset and enable shifting
        rst    = 0;
        enable = 1;

        // Shift in bit sequence: 1 -> 0 -> 1 -> 1 (one bit per clock cycle)
        serial_in = 1; #10; // Expected parallel_out: 0001
        serial_in = 0; #10; // Expected parallel_out: 0010
        serial_in = 1; #10; // Expected parallel_out: 0101
        serial_in = 1; #10; // Expected parallel_out: 1011

        // Shift in zeros to flush the register
        serial_in = 0; #40;

        $finish;
    end

endmodule
