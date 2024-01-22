module flip_flop #(parameter size = 1,
                   parameter bit_width = 1)
  (input [size-1:0][bit_width-1:0] d,
   input logic [size-1:0] en,
   input logic reset,
   input logic clk,
   output logic [size-1:0][bit_width-1:0] q);
  integer i,j;
  always @(posedge clk) begin
    for(i=0; i< size; i++) begin
      for(j=0; j< bit_width; j++) begin
      if(~reset)
          q[i][j] <= 1'b0;
      else if (en)  
          q[i][j] <= d[i][j];
      end
    end
  end
endmodule
