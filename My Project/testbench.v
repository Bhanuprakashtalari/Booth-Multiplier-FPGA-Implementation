module testbench;

    // Define parameters
    parameter CLK_PERIOD = 10; // Clock period in time units
    parameter SIM_TIME = 100;  // Simulation time in time units

    // Inputs
    reg clk;
    reg start;
    reg [7:0] mc;
    reg [7:0] mp;

    // Outputs
    wire [15:0] prod;
    wire busy;

    // Instantiate the booth_multiplier module
    booth_multiplier uut (
        .prod(prod),
        .busy(busy),
        .mc(mc),
        .mp(mp),
        .clk(clk),
        .start(start)
    );

    
    always #((CLK_PERIOD)/2) clk = ~clk;

  
    initial begin
      
        clk = 0;
        start = 0;
        mc = 3; // multiplicand
        mp = 10; //  multiplier

        // Apply start signal
        start = 1;
        #20; // Wait for a few clock cycles
        start = 0;

        // Wait for multiplication to complete
        repeat (SIM_TIME) @(posedge clk) begin
            if (!busy) begin
                $display("Multiplication completed.");
                $finish;
            end
        end

        // Timeout if multiplication does not complete within SIM_TIME
        $display("Multiplication timed out.");
        $finish;
    end

endmodule
