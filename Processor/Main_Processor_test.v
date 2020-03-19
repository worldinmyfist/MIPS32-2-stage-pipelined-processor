`timescale 1ns / 1ps

module Main_Processor_test;

	// Inputs
	reg clock;

	// Outputs
	wire [31:0] busa;
	wire [31:0] busb;
	wire [31:0] busw;
	wire [31:0] x;

	// Instantiate the Unit Under Test (UUT)
	Main_Proc_2 uut (
		.clock(clock), 
		.busa(busa), 
		.busb(busb), 
		.busw(busw), 
		.x(x)
	);

	initial begin
		// Initialize Inputs
		clock = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
		begin
		#1 clock = ~clock;
	 end
      
      
endmodule

