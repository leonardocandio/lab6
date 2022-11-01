module mainfsm (
	clk,
	reset,
	Op,
	Funct,
	IRWrite,
	AdrSrc,
	ALUSrcA,
	ALUSrcB,
	ResultSrc,
	NextPC,
	RegW,
	MemW,
	Branch,
	ALUOp
);
	input wire clk;
	input wire reset;
	input wire [1:0] Op;
	input wire [5:0] Funct;
	output wire IRWrite;
	output wire AdrSrc;
	output wire [1:0] ALUSrcA;
	output wire [1:0] ALUSrcB;
	output wire [1:0] ResultSrc;
	output wire NextPC;
	output wire RegW;
	output wire MemW;
	output wire Branch;
	output wire ALUOp;
	reg [3:0] state;
	reg [3:0] nextstate;
	reg [12:0] controls;
	localparam [3:0] FETCH = 0;
	localparam [3:0] DECODE = 1;
	localparam [3:0] MEMADR = 2;
	localparam [3:0] MEMREAD=3;
	localparam [3:0] MEMWB=4;
	localparam [3:0] MEMWRITE=5;
	localparam [3:0] EXECUTER = 6;
	localparam [3:0] EXECUTEI = 7;
	localparam [3:0] ALUWB=8;
	localparam [3:0] BRANCH = 9;
	localparam [3:0] UNKNOWN = 10;

	// state register
	always @(posedge clk or posedge reset)
		if (reset)
			state <= FETCH;
		else
			state <= nextstate;
	

	// ADD CODE BELOW
  	// Finish entering the next state logic below.  We've completed the 
  	// first two states, FETCH and DECODE, for you.

  	// next state logic
	always @(*)
		casex (state)
			FETCH: nextstate = DECODE;
			DECODE:
				case (Op)
					2'b01: nextstate = MEMADR;
					2'b00:
						if (Funct[5])
							nextstate = EXECUTEI;
						else
							nextstate = EXECUTER;
					
					2'b10: nextstate = BRANCH;
					default: nextstate = UNKNOWN;
				endcase
			MEMADR:
				if(Funct[0])
					nextstate=MEMREAD;
				else
					nextstate=MEMWRITE;
			EXECUTER:
				nextstate=ALUWB;
			EXECUTEI:
				nextstate=ALUWB;
			MEMREAD:
				nextstate=MEMWB;
			default: nextstate = FETCH;
		endcase

	// ADD CODE BELOW
	// Finish entering the output logic below.  We've entered the
	// output logic for the first two states, FETCH and DECODE, for you.

	// state-dependent output logic
	always @(*)
		case (state)

			//1 0 0 0 0 0 10 01 10 0
			FETCH: controls = 13'b1000101001100;
			//0 0 0 0 1 0 10 01 10 0
			DECODE: controls = 13'b0001001001100;
			//0 0 0 0 1 0 10 00 01 0
			MEMADR: controls= 13'b0000101000010;
			//0 0 0 0 1 0 10 00 00 1
			EXECUTER: controls = 13'b0000001000001;
			//0 0 0 0 1 0 10 00 01 1
			EXECUTEI: controls = 13'b0000101000011;
			//0 1 0 0 1 0 10 10 01 0
			BRANCH: controls= 13'b0100101010010;
			//0 0 0 0 1 1 00 00 01 0 heredar
			MEMREAD: controls= 13'b0000110000010;
			//0 0 0 0 1 1 00 00 01 0
			MEMWRITE: controls= 13'b0010110000010;
			//0 0 0 1 1 0 00 00 01 1
			ALUWB: controls= 13'b0001100000011;
			//0 0 0 1 1 1 01 01 01 0
			MEMWB: controls= 13'b0001110101010;
			
			default: controls = 13'bxxxxxxxxxxxxx;
		endcase
	assign {NextPC, Branch, MemW, RegW, IRWrite, AdrSrc, ResultSrc, ALUSrcA, ALUSrcB, ALUOp} = controls;
endmodule