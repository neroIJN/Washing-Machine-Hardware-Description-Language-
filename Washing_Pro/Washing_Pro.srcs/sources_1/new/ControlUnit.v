`timescale 1ns / 100ps

module ControlUnit(
    input clk,
    input reset,
    input start,
    input water_ready,
    input temp_ready,
    input load_ready,
    output reg wash_enable,
    output reg rinse_enable,
    output reg spin_enable,
    output reg complete
);

    reg [2:0] current_state, next_state;
    parameter IDLE = 3'b000, WASH = 3'b001, RINSE = 3'b010, SPIN = 3'b011, DONE = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        wash_enable = 0;
        rinse_enable = 0;
        spin_enable = 0;
        complete = 0;

        case (current_state)
            IDLE: begin
                if (start && water_ready && temp_ready && load_ready)
                    next_state = WASH;
                else
                    next_state = IDLE;
            end
            WASH: begin
                wash_enable = 1;
                next_state = RINSE;
            end
            RINSE: begin
                rinse_enable = 1;
                next_state = SPIN;
            end
            SPIN: begin
                spin_enable = 1;
                next_state = DONE;
            end
            DONE: begin
                complete = 1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule