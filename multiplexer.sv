// Assumed bit_width_B < bit_width_A

module multiplexer #(
    parameter num_inputs = 1,
    parameter bit_width  = 1
) (
    input [num_inputs-1:0][bit_width-1:0] in,
    input logic [num_inputs-1:0] sel,
    output logic [bit_width-1:0] out,
    output logic [bit_width-1:0][num_inputs-1:0] inter
);

  integer i, j;
  
  always_comb begin
    out = {bit_width{1'b0}};
    for (i = 0; i < bit_width; i++) begin
      for (j = 0; j < num_inputs; j++) begin
        inter[i][j] = (sel[j] & in[j][i]);
      end
      
      out[i] = |(inter[i][num_inputs-1:0]);
    end
  end

endmodule: multiplexer
