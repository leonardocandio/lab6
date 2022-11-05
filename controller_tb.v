`timescale 1ns/1ps
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
		#(1);
		reset <= 0;
	end

    always
        begin
          clk <= 1;
          #(1);
          clk <= 0;
          #(1);
        end
    
    initial
    


begin
Instr = 20'b11100000010011110000; 
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100010100000000010;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100010100000000011;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100010010000110111;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100001100001110100;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100000000000110101;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100000100001010101;
ALUFlags = 4'b0000;
#(8)
Instr = 20'b11100000010101011000;
ALUFlags = 4'b0010;
#(8)
Instr = 20'b00001010000000000000;
ALUFlags = 4'b0010;
#(6)
Instr = 20'b11100000010100111000;
ALUFlags = 4'b0010;
#(8)
Instr = 20'b10101010000000000000;
ALUFlags = 4'b1000;
#(6)
Instr = 20'b11100010100000000101;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100000010101111000;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b10110010100001010111;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100000010001110111;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100101100000110111;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100101100100000010;
ALUFlags = 4'b1000;
#(10)
Instr = 20'b11100000100011111111;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100010100000000010;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11101010000000000000;
ALUFlags = 4'b1000;
#(6)
Instr = 20'b11100010100000000010;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100010100000000010;
ALUFlags = 4'b1000;
#(8)
Instr = 20'b11100101100000000010;
ALUFlags = 4'b1000;
#(8)
$finish;
end
    
    initial begin
        $dumpfile("arm_control.vcd");
        $dumpvars;
    end

endmodule