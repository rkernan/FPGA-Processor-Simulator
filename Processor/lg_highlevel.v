`timescale 1ns / 1ps

module lg_highlevel();
	reg myclock;
	initial begin
		myclock = 0;
		#5000 $finish;
	end
	always begin
		#20 myclock = ~myclock;
	end
	wire clk;
	wire locked_sig;
	datapath lg_datapath(.clk(clk), .lock(locked_sig));
	pll pll_inst(.inclk0(myclock), .c0(clk), .locked(locked_sig));
endmodule
