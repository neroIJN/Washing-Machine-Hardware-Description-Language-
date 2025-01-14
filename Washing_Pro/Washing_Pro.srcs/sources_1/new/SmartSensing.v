`timescale 1ns / 100ps

module SmartSensing(
    input clk,
    input reset,
    output reg detergent_ok,
    output reg balanced_load
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            detergent_ok <= 0;
            balanced_load <= 0;
        end else begin
            detergent_ok <= 1;  // Simulate detergent is available
            balanced_load <= 1;  // Simulate load is balanced
        end
    end
endmodule

