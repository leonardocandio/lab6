module alu ( input [31:0] a,b,
              input [2:0] ALUControl,
             output reg [31:0] Result, //assign always block
             output wire [3:0] ALUFlags); //explicit wire for assign with {}
  
  wire negative, zero, carry, overflow; // define wire for each flag (n,z,c,v)
  wire [31:0] condinvb;
  wire [32:0] sum;
  
  assign condinvb = ALUControl[0] ? ~b : b;
  assign sum = a + condinvb + ALUControl[0];
  /*
  ALUControl Logic
  000: sum
  001: sub
  010: and
  011: or
  100: xor/eor
  */
  always @(*)
  begin
    
    casex (ALUControl[2:0]) //case, casex, casez
      3'b00?: Result = sum;
      3'b010: Result = a & b;
      3'b011: Result = a | b;
      3'b100: Result = a ^ b;
    endcase
  
  end
 //flags: result -> negative, zero
  assign negative = Result[31];
  assign zero = (Result == 32'b0);
  //flags: additional logic -> v, c
  assign carry = (ALUControl[2:1]==2'b00) & sum[32];
  assign overflow = (ALUControl[2:1]==2'b00) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);

  assign ALUFlags = {negative, zero, carry, overflow};

endmodule