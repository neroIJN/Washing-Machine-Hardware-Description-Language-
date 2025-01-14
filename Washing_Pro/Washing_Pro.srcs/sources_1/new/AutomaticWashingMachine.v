`timescale 1ns / 100ps

module AutomaticWashingMachine(
    input clk,
    input reset,
    input start,
    input enable_lock,
    input clean_trigger,
    input [1:0] cycle_mode,
    output complete,
    output [7:0] energy_consumed
);

    wire wash_enable, rinse_enable, spin_enable;
    wire water_ready, temp_ready, load_ready, cycle_ready;
    wire detergent_ok, balanced_load, cleaning_done;
    wire lock_active;
    
    // Instantiate Control Unit
    ControlUnit control_unit (
        .clk(clk),
        .reset(reset),
        .start(start),
        .water_ready(water_ready),
        .temp_ready(temp_ready),
        .load_ready(load_ready),
        .wash_enable(wash_enable),
        .rinse_enable(rinse_enable),
        .spin_enable(spin_enable),
        .complete(complete)
    );

    // Instantiate Temperature Control
    TemperatureControl temp_control (
        .clk(clk),
        .reset(reset),
        .start(start),
        .temp_ready(temp_ready)
    );

    // Instantiate Water Control
    WaterControl water_control (
        .clk(clk),
        .reset(reset),
        .start(start),
        .water_ready(water_ready)
    );

    // Instantiate Load Sensing
    LoadSensing load_sensing (
        .clk(clk),
        .reset(reset),
        .start(start),
        .load_ready(load_ready)
    );

    // Instantiate Cycle Customization
    CycleCustomization cycle_custom (
        .clk(clk),
        .reset(reset),
        .start(start),
        .cycle_mode(cycle_mode),
        .cycle_ready(cycle_ready),
        .wash_duration(),
        .rinse_duration(),
        .spin_duration()
    );

    // Instantiate Smart Sensing
    SmartSensing smart_sensing (
        .clk(clk),
        .reset(reset),
        .detergent_ok(detergent_ok),
        .balanced_load(balanced_load)
    );

    // Instantiate Child Lock
    ChildLock child_lock (
        .clk(clk),
        .reset(reset),
        .enable_lock(enable_lock),
        .lock_active(lock_active)
    );

    // Instantiate Auto Clean
    AutoClean auto_clean (
        .clk(clk),
        .reset(reset),
        .clean_trigger(clean_trigger),
        .cleaning_done(cleaning_done)
    );

    // Instantiate Energy Monitor
    EnergyMonitor energy_monitor (
        .clk(clk),
        .reset(reset),
        .washing(wash_enable),
        .rinsing(rinse_enable),
        .spinning(spin_enable),
        .energy_consumed(energy_consumed)
    );

endmodule