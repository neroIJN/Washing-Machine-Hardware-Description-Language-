`timescale 1ns / 100ps

module ChildLock(
    input clk,
    input reset,
    input enable_lock,
    output reg lock_active
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            lock_active <= 0;
        else
            lock_active <= enable_lock;
    end
endmodule
