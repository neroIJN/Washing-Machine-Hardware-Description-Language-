`timescale 1ns / 100ps

module AutoClean(
    input clk,
    input reset,
    input clean_trigger,
    output reg cleaning_done
);

    reg [3:0] clean_cycle_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clean_cycle_counter <= 0;
            cleaning_done <= 0;
        end 
        else if (clean_trigger) begin
            if (clean_cycle_counter < 4) // Example clean cycle
                clean_cycle_counter <= clean_cycle_counter + 1;
            else
                cleaning_done <= 1;
        end else begin
            cleaning_done <= 0;
            clean_cycle_counter <= 0;
        end
    end
endmodule

