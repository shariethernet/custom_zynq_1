

module multiplier #(parameter bit_width_A = 13,
                    parameter bit_width_B = 4,
                    parameter bit_width_out = bit_width_A+bit_width_B) //Assumed bit_width_B < bit_width_A
  (input logic [bit_width_A-1:0] in_A,
   input logic [bit_width_B-1:0] in_B,
   output logic [bit_width_out-1:0] out,
   output logic [bit_width_out-1:0][bit_width_out-1:0] inter);

  localparam num_levels = $clog2(bit_width_out);
  localparam num_inputs_round = 2**$clog2(bit_width_out);
  localparam add_out_width = bit_width_out+$clog2(bit_width_out);
  logic [num_levels:0][num_inputs_round-1:0][add_out_width-1:0] intermediate;
  logic [bit_width_out-1:0] inter_A;
  logic [bit_width_out-1:0] inter_B;
  genvar i;
  localparam buffer_bits_A = bit_width_out - bit_width_A;
  localparam buffer_bits_B = bit_width_out - bit_width_B;
  assign inter_A = bit_width_out'({{buffer_bits_A{in_A[bit_width_A-1]}}, in_A[bit_width_A-1:0]});
  assign inter_B = bit_width_out'({{buffer_bits_B{in_B[bit_width_B-1]}}, in_B[bit_width_B-1:0]});

  //Generate partial products
  generate
    for (i = 0; i < bit_width_out; i++) begin
      assign inter[i] = (bit_width_out)'((inter_A & {bit_width_out{inter_B[i]}}) << i);
    end
  endgenerate

  logic [bit_width_out+$clog2(bit_width_out)-1:0] out_add;
  assign out = bit_width_out'(out_add);
  //Adder tree
  adder #(
      .bit_width(bit_width_out),
      .num_inputs(bit_width_out),
      .num_levels(num_levels),
      .num_inputs_round(num_inputs_round),
      .add_out_width(add_out_width)
  ) adder_1 (
      .in(inter),
      .add_out(out_add),
      .inter(intermediate)
  );

endmodule: multiplier
