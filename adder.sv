// Format the inputs in a way that the max-bit width input is equal to bit-width and the unnecessary MSB bits are already zero'ed out

module adder #(
    parameter bit_width = 1,
    parameter num_inputs = 1,
    parameter num_levels = $clog2(num_inputs),
    parameter num_inputs_round = 2 ** num_levels,
    parameter add_out_width = bit_width + $clog2(num_inputs)
) (
    input  logic [num_inputs-1:0][bit_width-1:0] in,
    output logic [bit_width + $clog2(num_inputs)-1:0] add_out,
    output logic [num_levels:0][num_inputs_round-1:0][add_out_width-1:0] inter
);

  genvar level, pos;
  generate
    for (level = 0; level <= num_levels; level++) begin
      localparam pos_per_level = num_inputs_round >> level;
      localparam bit_width_per_level = bit_width + level;
      localparam buffer_bits = add_out_width - bit_width_per_level;

      if (level == 0) begin
        for (pos = 0; pos < pos_per_level; pos++) begin
          if (pos < num_inputs) begin
            assign inter[level][pos][add_out_width-1:0] = add_out_width'({
              {buffer_bits{in[pos][bit_width-1]}}, in[pos][bit_width-1:0]
            });
          end
          else begin
            assign inter[level][pos][add_out_width-1:0] = '0;
          end
        end
      end

     else begin
        for (pos = 0; pos < num_inputs_round; pos++) begin
          if (pos < pos_per_level) begin
            assign inter[level][pos][add_out_width-1:0] = add_out_width'(inter[level-1][2*pos] + inter[level-1][2*pos+1]);
          end else begin
            assign inter[level][pos][add_out_width-1:0] = '0;
          end

        end
      end

    end
  endgenerate

  assign add_out = inter[num_levels][0];

endmodule: adder
