// All verification components are placed in this top testbench module
module tb_top;

	// Declare variables that need to be connected to the design instance
	// These variables are assigned some values that in turn gets transferred to
	// the design as inputs because they are connected with the ports in the design
	reg clk;
	wire en;
	wire wr;
	wire data;

	// Instantiate the design module and connect the variables declared above
	// with the ports in the design
	design myDsn ( .clk (clk),
	               .en  (en),
	               .wr  (wr),
	               . ...
	               .rdata);

	// Develop rest of the testbench and write stimulus that can be driven to the design
endmodule