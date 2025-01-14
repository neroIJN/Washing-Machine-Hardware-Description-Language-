`timescale 1ns / 100ps

module WaterControl(
    input clk,
    input reset,
    input start,
    output reg water_ready
);

    reg [3:0] water_level;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            water_level <= 0;
            water_ready <= 0;
        end 
        else if (start) begin
            if (water_level < 6)  // Required water level
                water_level <= water_level + 1;
            else
                water_ready <= 1;
        end
         else begin
            water_ready <= 0;
        end
    end
endmodule

