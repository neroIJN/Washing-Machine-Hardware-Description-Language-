`timescale 1ns / 100ps

module CycleCustomization(
    input clk,
    input reset,
    input start,
    input [1:0] cycle_mode,  // 00: Normal, 01: Quick, 10: Heavy
    output reg cycle_ready,
    output reg [3:0] wash_duration,
    output reg [3:0] rinse_duration,
    output reg [3:0] spin_duration
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wash_duration <= 0;
            rinse_duration <= 0;
            spin_duration <= 0;
            cycle_ready <= 0;
        end 
        else if (start) begin
            case (cycle_mode)
            //Normal mode
                2'b00: begin
                    wash_duration <= 8;
                    rinse_duration <= 6;
                    spin_duration <= 4;
                end
            //Quick mode
                2'b01: begin
                    wash_duration <= 4;
                    rinse_duration <= 3;
                    spin_duration <= 2;
                end
            //Heavy mode
                2'b10: begin
                    wash_duration <= 12;
                    rinse_duration <= 8;
                    spin_duration <= 6;
                end
                default: begin
                    wash_duration <= 8;
                    rinse_duration <= 6;
                    spin_duration <= 4;
                end
            endcase
            cycle_ready <= 1;
        end else begin
            cycle_ready <= 0;
        end
    end
endmodule
