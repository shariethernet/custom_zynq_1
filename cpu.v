module cpu (
    input clk,
    input reset,
    output reg [31:0] iaddr,
    input [31:0] idata,
    output [31:0] daddr,
    input [31:0] drdata,
    output [31:0] dwdata,
    output [3:0] dwe,
    output [32*32-1:0] registers
);

  // Add logic here

  
  always @(posedge clk) begin
      if (reset) iaddr <= 0;
      else iaddr <= next_pc;
    end

endmodule
