

module lg_highlevel(CLOCK_50);

input CLOCK_50; 

wire clk;
wire locked_sig; 

datapath lg_datapath(.clk(clk), .lock(locked_sig));

pll	pll_inst (
	.inclk0 ( CLOCK_50 ),
	.c0 ( clk ),
	.locked ( locked_sig )
	);



endmodule