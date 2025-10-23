 module stall_flush 
 	(
	input [4:0] Rs1D, Rs2D, 
	input [4:0] RdE, 
	input PCSrcE, ResultSrcE,

	output StallF, StallD,
	output FlushD, FlushE
	);

 	wire lwStall;

 	assign lwStall = ResultSrcE & ((Rs1D == RdE) | (Rs2D == RdE));
 	
    assign StallF = lwStall;
    assign StallD = lwStall;

    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;

 endmodule 