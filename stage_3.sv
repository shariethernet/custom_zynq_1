module stage3 #(
    parameter STAGE_1_NUM_INPUTS = 4,
    parameter STAGE_1_BIT_WIDTH = 8,
    parameter STAGE_1_MAX_SHIFT_AMT = STAGE_1_NUM_INPUTS - 1,
    parameter STAGE_1_OUT_BIT_WIDTH_NECESSARY = STAGE_1_BIT_WIDTH + STAGE_1_NUM_INPUTS - 1,
    parameter STAGE_3_OUT_BIT_WIDTH = STAGE_1_OUT_BIT_WIDTH_NECESSARY + $clog2(STAGE_1_NUM_INPUTS)
) (
    input [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] in,
    output logic [STAGE_3_OUT_BIT_WIDTH-1:0] out,
    output logic [$clog2(STAGE_1_NUM_INPUTS)-1:0][2**$clog2(STAGE_1_NUM_INPUTS)-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] inter
);

  adder #(
      .bit_width(STAGE_1_OUT_BIT_WIDTH_NECESSARY),
      .num_inputs(STAGE_1_NUM_INPUTS),
      .num_inputs_round(2 ** ($clog2(STAGE_1_NUM_INPUTS))),
      .add_out_width(STAGE_1_BIT_WIDTH + STAGE_1_MAX_SHIFT_AMT + $clog2(STAGE_1_NUM_INPUTS))
  ) adder_1 (
      .in(in),
      .add_out(out),
      .inter(inter)
  );

endmodule
