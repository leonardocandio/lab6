`timescale 1s/1s
module controller_tb();
    reg clk;
	reg reset;
	reg [31:12] Instr;
	reg [3:0] ALUFlags;
	wire PCWrite;
	wire MemWrite;
	wire RegWrite;
	wire IRWrite;
	wire AdrSrc;
	wire [1:0] RegSrc;
	wire [1:0] ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [1:0] ResultSrc;
	wire [1:0] ImmSrc;
	wire [1:0] ALUControl;
    reg [31:0] vectornum;
    reg [31:0] errors;
    
    controller dut(
                    .clk(clk), 
                    .reset(reset), 
                    .Instr(Instr), 
                    .ALUFlags(ALUFlags), 
                    .PCWrite(PCWrite), 
                    .MemWrite(MemWrite), 
                    .RegWrite(RegWrite),
                    .IRWrite(IRWrite),
                    .AdrSrc(AdrSrc),
                    .RegSrc(RegSrc),
                    .ALUSrcA(ALUSrcA),
                    .ALUSrcB(ALUSrcB),
                    .ResultSrc(ResultSrc),
                    .ImmSrc(ImmSrc),
                    .ALUControl(ALUControl));
    
    initial begin
		reset <= 1;
		#(9)
			;
		reset <= 0;
	end

    always
        begin
            clk <= 1;
		    #(1)
			;
		    clk <= 0;
		    #(1)
			;
        end
    
    initial
    

//Banco de prubas
//ADD R5, R5, R4    	1110 000 0100 0 0101 0101 0000 0000 0100 
//ADD R2, R0, #10   	1110 001 0100 0 0000 0010 0000 0000 0001 
//SUB R7, R7, R2    	1110 000 0010 0 0111 0111 0000 0000 0010 
//SUB R7, R3, #9    	1110 001 0010 0 0011 0111 0000 0000 1001 
//ORR R4, R7, R2  	    1110 000 1100 0 0111 0100 0000 0000 0010 
//AND R5, R3, R4  	    1110 000 0000 0 0011 0101 0000 0000 0100 
//LDR R2, [R0, #96]  	1110 010 1100 1 0000 0010 0000 0110 0000 
//STR R7, [R3, #84]  	1110 010 1100 0 0011 0111 0000 0101 0100 
//B END             	1110 101 0000 0 0000 0000 0000 0000 0001  
//END:

    begin
        Instr = 20'b11100000100001010101;
        #10
        Instr = 20'b11100000010001110111;
        #10
        Instr = 20'b11100001100001110100;
        #10
        Instr = 20'b11100000000000110101;
        #10
        Instr = 20'b11100001100001110100;
        #10
        Instr = 20'b11100000000000110101;
        #10
        Instr = 20'b11100101100100000010;
        #10
        Instr = 20'b11100101100000110111;
        #10
        Instr = 20'b11101010000000000000;
        $finish;
    end    
    initial begin
        $dumpfile("arm_control.vcd");
        $dumpvars;
    end

endmodule