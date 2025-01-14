`timescale 1ns / 100ps

module EnergyMonitor(
    input clk,
    input reset,
    input washing,
    input rinsing,
    input spinning,
    output reg [7:0] energy_consumed
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            energy_consumed <= 0;
        else begin
            if (washing)
                energy_consumed <= energy_consumed + 5;
            else if (rinsing)
                energy_consumed <= energy_consumed + 3;
            else if (spinning)
                energy_consumed <= energy_consumed + 4;
        end
    end
endmodule

