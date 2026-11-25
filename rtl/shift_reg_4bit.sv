module shift_reg_4bit (
    input logic clk,
    input logic rst, // Synchronous Reset (Active High)
    input logic enable, // Shift enable signal
    input logic serial_in, // 1-bit serial data input
    output logic [3:0] parallel_out // 4-bit parallel data output
);

    // Sequential logic for left-shifting data
    always_ff @(posedge clk) begin
        if (rst) begin  
            parallel_out <= 4'b0000;
        end else if (enable) begin
            // Concatenate lower 3 bits with new serial_in bit at LSB
            parallel_out <= {parallel_out[2:0], serial_in};
        end
    end

endmodule
