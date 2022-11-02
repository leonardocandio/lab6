module multi_tb;
reg clk;
reg reset;
wire [31:0] WriteData;
wire [31:0] Adr;
wire MemWrite;
top dut(
  .clk(clk),
  .reset(reset),
  .WriteData(WriteData),
  .Adr(Adr),
  .MemWrite(MemWrite)
);

initial begin
  reset <= 1;
  #10;
  reset <= 0;
end
always begin
  clk <= 1;
  #5;
  clk <= 0;
  #5;
end
always @(negedge clk) begin
  #1000;
  $finish;
end
initial begin
  $dumpfile("multi_tb.vcd");
  $dumpvars(0, multi_tb);
end
endmodule