module stage1 #(
    parameter STAGE_1_NUM_INPUTS = 4,
    parameter STAGE_1_BIT_WIDTH = 8,
    parameter STAGE_1_MAX_SHIFT_AMT = STAGE_1_NUM_INPUTS - 1,
    parameter STAGE_1_MUX_2_NUM_INPUTS = STAGE_1_NUM_INPUTS + 1,
    parameter STAGE_1_OUT_BIT_WIDTH = STAGE_1_BIT_WIDTH + STAGE_1_MAX_SHIFT_AMT + $clog2(
        STAGE_1_NUM_INPUTS
    )
) (
    input [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] in,
    input DISABLE_STAGE_1,  //Should be an IO port
    input [$clog2(STAGE_1_NUM_INPUTS)-1:0] count,
    output logic [STAGE_1_OUT_BIT_WIDTH-1:0] out,
    output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out,
    output logic [STAGE_1_OUT_BIT_WIDTH-1:0] adder_out,
    output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] extended_in,
    output logic [STAGE_1_MUX_2_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] mux_2_in,
    output logic [STAGE_1_MUX_2_NUM_INPUTS-1:0] sel
);
  logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out_inter;

  //logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out;
  //logic [STAGE_1_OUT_BIT_WIDTH-1:0] adder_out;
  //logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] extended_in;
  //logic [STAGE_1_MUX_2_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] mux_2_in;
  //logic [STAGE_1_MUX_2_NUM_INPUTS-1:0] sel;
  logic [STAGE_1_OUT_BIT_WIDTH-1:0][STAGE_1_MUX_2_NUM_INPUTS-1:0] inter_mux;
  genvar i;
  //Row of shifters
  generate
    for (i = 0; i < STAGE_1_MAX_SHIFT_AMT + 1; i++) begin

      shifter #(
          .bit_width(STAGE_1_BIT_WIDTH),
          .shift_amt(i)
      ) shift_1 (
          .in (in[i]),
          .out(shift_out_inter[i][STAGE_1_BIT_WIDTH+i-1:0])
      );
      assign shift_out[i][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] = (STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT)'({
        {STAGE_1_MAX_SHIFT_AMT{shift_out_inter[i][STAGE_1_BIT_WIDTH+i-1]}},
        shift_out_inter[i][STAGE_1_BIT_WIDTH+i-1:0]
      });
    end
  endgenerate
  //logic [$clog2(STAGE_1_NUM_INPUTS)-1:0][((2**$clog2(STAGE_1_NUM_INPUTS))-1):0][(STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT+$clog2(STAGE_1_NUM_INPUTS)-1):0] inter;            
  //Adder reduction
  adder #(
      .bit_width(STAGE_1_BIT_WIDTH + STAGE_1_MAX_SHIFT_AMT),
      .num_inputs(STAGE_1_NUM_INPUTS),
      .num_levels($clog2(STAGE_1_NUM_INPUTS)),
      .num_inputs_round(2 ** ($clog2(STAGE_1_NUM_INPUTS))),
      .add_out_width(STAGE_1_BIT_WIDTH + STAGE_1_MAX_SHIFT_AMT + $clog2(STAGE_1_NUM_INPUTS))
  ) adder_1 (
      .in(shift_out),
      .add_out(adder_out),
      .inter(inter)
  );

  //Format inputs for mux  
  for (i = 0; i < STAGE_1_NUM_INPUTS; i++) begin
    assign extended_in[i][STAGE_1_OUT_BIT_WIDTH-1:STAGE_1_BIT_WIDTH] = '0;
    assign extended_in[i][STAGE_1_BIT_WIDTH-1:0] = in[i];
  end
  assign mux_2_in = {adder_out, extended_in};
  //Generate selects
  for (i = 0; i < STAGE_1_NUM_INPUTS; i++) begin
    assign sel[i] = DISABLE_STAGE_1 & (count == i);
  end
  assign sel[STAGE_1_NUM_INPUTS] = ~DISABLE_STAGE_1;

  //Multiplexer
  multiplexer #(
      .bit_width (STAGE_1_OUT_BIT_WIDTH),
      .num_inputs(STAGE_1_MUX_2_NUM_INPUTS)
  ) mux_1 (
      .in(mux_2_in),
      .sel(sel),
      .out(out),
      .inter(inter_mux)
  );

endmodule
