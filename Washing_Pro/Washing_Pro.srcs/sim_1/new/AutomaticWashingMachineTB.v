`timescale 1ns / 100ps

module AutomaticWashingMachineTB;
    reg clk, reset, start, enable_lock, clean_trigger;
    reg [1:0] cycle_mode;
    wire complete;
    wire [7:0] energy_consumed;

    // Instantiate the AutomaticWashingMachine top module
    AutomaticWashingMachine uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .enable_lock(enable_lock),
        .clean_trigger(clean_trigger),
        .cycle_mode(cycle_mode),
        .complete(complete),
        .energy_consumed(energy_consumed)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Simulation process
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        start = 0;
        enable_lock = 0;
        clean_trigger = 0;
        cycle_mode = 2'b00;

        // Reset the system
        $display("///// Starting the washing machine simulation...");
        #10 reset = 0;

        // Begin the washing process
        $display("==== Initializing washing cycle at time %t", $time);
        start = 1;
        
        // Load Sensing Phase
        #10 $display("Load Sensing: Detecting load weight...");
        #30 if (uut.load_sensing.load_ready) $display("Load Sensing: Load is ready at time %t", $time);

        // Water Fill Phase
        #10 $display("Water Control: Filling water to the required level...");
        #30 if (uut.water_control.water_ready) $display("Water Control: Water level is ready at time %t", $time);

        // Temperature Control Phase
        #10 $display("Temperature Control: Heating water to the desired temperature...");
        #40 if (uut.temp_control.temp_ready) $display("Temperature Control: Water temperature is ready at time %t", $time);

        // Smart Sensing Phase
        #10 $display("Smart Sensing: Checking detergent and load balance...");
        #20 if (uut.smart_sensing.detergent_ok && uut.smart_sensing.balanced_load) 
            $display("Smart Sensing: Detergent and load balance are OK at time %t", $time);

        // Wash Cycle Phase
        #10 cycle_mode = 2'b01;  // Quick wash cycle for demonstration
        $display("==== Wash Cycle: Starting wash cycle in Quick mode...");
        #60 $display("Wash Cycle: Washing in progress...");

        // Rinse Cycle Phase
        #10 $display("==== Rinse Cycle: Starting rinse cycle...");
        #30 $display("Rinse Cycle: Rinsing in progress...");

        // Spin Cycle Phase
        #10 $display("==== Spin Cycle: Starting spin cycle...");
        #20 $display("Spin Cycle: Spinning in progress...");

        // Auto-Clean Phase
        #10 clean_trigger = 1;
        $display("==== Auto-Clean: Starting auto-cleaning...");
        #10 clean_trigger = 0;
        #20 if (uut.auto_clean.cleaning_done) $display("Auto-Clean: Cleaning completed at time %t", $time);

        // Wait for cycle completion
        wait(complete);
        $display("==== Washing cycle completed at time %t", $time);
        $display("==== Total energy consumed: %d units", energy_consumed);

        // End the simulation
        #10 $display("==== Ending simulation at time %t", $time);
        $finish;
    end

    // Monitor outputs in the console for each functional stage
    always @(posedge clk) begin
        if (uut.control_unit.wash_enable) begin
            $display("///// WASH phase active at time %t", $time);
        end
        else if (uut.control_unit.rinse_enable) begin
            $display("///// RINSE phase active at time %t", $time);
        end
        else if (uut.control_unit.spin_enable) begin
            $display("///// SPIN phase active at time %t", $time);
        end
        if (uut.load_sensing.load_ready) begin
            $display("##### Load Sensing: Load ready at time %t", $time);
        end
        if (uut.water_control.water_ready) begin
            $display("##### Water Control: Water level ready at time %t", $time);
        end
        if (uut.temp_control.temp_ready) begin
            $display("##### Temperature Control: Temperature reached at time %t", $time);
        end
        if (uut.smart_sensing.detergent_ok && uut.smart_sensing.balanced_load) begin
            $display("##### Smart Sensing: Detergent and load balance OK at time %t", $time);
        end
        if (uut.auto_clean.cleaning_done) begin
            $display("##### Auto-Clean: Cleaning completed at time %t", $time);
        end
        if (complete) begin
            $display("///// Washing cycle completed at time %t", $time);
        end
    end
endmodule