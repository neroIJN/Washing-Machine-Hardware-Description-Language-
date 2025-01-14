`timescale 1ns / 100ps

module TemperatureControl(
    input clk,
    input reset,
    input start,
    output reg temp_ready
);

    reg [3:0] temp_level;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_level <= 0;
            temp_ready <= 0;
        end else if (start) begin
            if (temp_level < 8)  // Simulated target temperature level
                temp_level <= temp_level + 1;
            else
                temp_ready <= 1;
        end
         else begin
            temp_ready <= 0;
        end
    end
endmodule
