
module CIM_CHIP_no_pad_no_scan_parametrized #( 
  parameter NUM_STACKS = 8,
  parameter STAGE_1_NUM_INPUTS = 8,//should be power of 2
  parameter STAGE_1_BIT_WIDTH = 8,
  parameter SRAM_THROUGHPUT = 1, //cycles/bit - should be power of 2
  parameter STAGE_4_BIT_WIDTH = 4,
  parameter SIZE_ACT_ARRAY = 1,
  parameter STAGE_1_MAX_SHIFT_AMT = STAGE_1_NUM_INPUTS-1,
  parameter STAGE_1_MUX_2_NUM_INPUTS = STAGE_1_NUM_INPUTS+1,
  parameter STAGE_1_OUT_BIT_WIDTH = STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT+$clog2(STAGE_1_NUM_INPUTS),
  parameter STAGE_1_OUT_BIT_WIDTH_NECESSARY = STAGE_1_NUM_INPUTS + STAGE_1_BIT_WIDTH-1, //For signed representation
  parameter STAGE_3_OUT_BIT_WIDTH = STAGE_1_OUT_BIT_WIDTH_NECESSARY+ $clog2(STAGE_1_NUM_INPUTS),
 parameter counter_bit_width = $clog2(SRAM_THROUGHPUT)+$clog2(STAGE_1_NUM_INPUTS),
 parameter STAGE_4_OUT_BIT_WIDTH = STAGE_3_OUT_BIT_WIDTH+STAGE_4_BIT_WIDTH
  )
(input logic clk,
input logic reset,
input logic wrEn_queue,
input logic [STAGE_4_BIT_WIDTH-1:0] wrData_queue,
input logic DISABLE_STAGE_1,
input logic DISABLE_STAGE_4,
input logic wrEn_act_array,
input logic [NUM_STACKS-1:0][SIZE_ACT_ARRAY-1:0][STAGE_1_BIT_WIDTH-1:0] wrData_act,
input logic [NUM_STACKS-1:0][STAGE_1_BIT_WIDTH-1:0] input_wt,
input logic SRAM_flop_en_in,//Chicken bit
input logic flop_1_en_in,//Chicken bit
input logic flop_3_en_in,//Chicken bit
input logic queue_en_in,//Chicken bit for stage 2
input logic [$clog2(STAGE_1_BIT_WIDTH)-1:0] wrPtr_d_in, //Chicken bit
input logic in,//Chicken bit for safety reasons
input logic wrPtr_over_in, //Chicken bit
input logic DISABLE_STAGE_2,//Chicken bit
input logic DISABLE_STAGE_3,//Chicken bit
input logic chicken_bit,
output logic [1:0] stage_4_o, //Chicken bit
output logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_in,
output logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_flop_in,
output logic [NUM_STACKS-1:0][SIZE_ACT_ARRAY-1:0][STAGE_1_BIT_WIDTH-1:0] wrData_act_q,
output logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out,
output logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] adder_out,
//output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] extended_in,//Not included in chip because mux_2_in is a superset
output logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] stage_1_out,

output logic [NUM_STACKS-1:0][STAGE_1_MUX_2_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] mux_2_in,
output logic [NUM_STACKS-1:0][STAGE_1_MUX_2_NUM_INPUTS-1:0] sel,
output logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_in,
output logic [NUM_STACKS-1:0][$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_q,
output logic [NUM_STACKS-1:0][$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_d,
output logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_out,
output logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_3_in,
output logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out,
output logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out_acc,
output logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_4_in,
output logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q,
output logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q1,
output logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q2,
output logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_d,
//output logic [$clog2(STAGE_1_NUM_INPUTS):0][2**$clog2(STAGE_1_NUM_INPUTS)-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_inter, //Not used in chip
//output logic [STAGE_4_BIT_WIDTH-1:0] rdData_queue, // Not used in chip
output logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out_mul,
output logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out,
output logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] mult_inter,
output logic [NUM_STACKS-1:0] weight_zero, 
output logic [STAGE_1_BIT_WIDTH+STAGE_1_NUM_INPUTS-1:0] mul_test,
output logic [NUM_STACKS-1:0] done);

genvar i;

logic [NUM_STACKS-1:0] [1:0] stage_4_out_dummy;
assign stage_4_o = stage_4_out_dummy[0][1:0];
generate for (i=0; i< NUM_STACKS; i++) begin
CIM_CHIP_no_pad_no_scan #(.STAGE_1_NUM_INPUTS(STAGE_1_NUM_INPUTS),//should be power of 2
  .STAGE_1_BIT_WIDTH (STAGE_1_BIT_WIDTH),
  .SRAM_THROUGHPUT (SRAM_THROUGHPUT), //cycles/bit - should be power of 2
  .STAGE_4_BIT_WIDTH (STAGE_4_BIT_WIDTH),
  .SIZE_ACT_ARRAY (SIZE_ACT_ARRAY),
  .STAGE_1_MAX_SHIFT_AMT (STAGE_1_MAX_SHIFT_AMT),
  .STAGE_1_MUX_2_NUM_INPUTS (STAGE_1_MUX_2_NUM_INPUTS),
  .STAGE_1_OUT_BIT_WIDTH (STAGE_1_OUT_BIT_WIDTH),
  .STAGE_1_OUT_BIT_WIDTH_NECESSARY (STAGE_1_OUT_BIT_WIDTH_NECESSARY), //For signed representation
 .STAGE_3_OUT_BIT_WIDTH (STAGE_3_OUT_BIT_WIDTH),
 .counter_bit_width (counter_bit_width),
 .STAGE_4_OUT_BIT_WIDTH (STAGE_4_OUT_BIT_WIDTH)) dut 
(.clk(clk), .reset(reset),.wrEn_queue(wrEn_queue), .wrData_queue (wrData_queue), .DISABLE_STAGE_1(DISABLE_STAGE_1), .DISABLE_STAGE_4(DISABLE_STAGE_4), .wrEn_act_array(wrEn_act_array), .wrData_act(wrData_act[i]),.input_wt(input_wt[i]),.SRAM_flop_en_in(SRAM_flop_en_in), .flop_1_en_in(flop_1_en_in), .flop_3_en_in(flop_3_en_in),.queue_en_in(queue_en_in), .wrPtr_d_in(wrPtr_d_in), .in(in),.wrPtr_over_in(wrPtr_over_in), .DISABLE_STAGE_2(DISABLE_STAGE_2),.DISABLE_STAGE_3(DISABLE_STAGE_3), .stage_4_o(stage_4_out_dummy[i]), .stage_1_in(stage_1_in[i]), .stage_1_flop_in(stage_1_flop_in[i]), .wrData_act_q(wrData_act_q[i]), .shift_out(shift_out[i]), .adder_out(adder_out[i]),.stage_1_out(stage_1_out[i]),.mux_2_in(mux_2_in[i]), .sel(sel[i]), .stage_2_in(stage_2_in[i]), .wrPtr_q(wrPtr_q[i]), .wrPtr_d(wrPtr_d[i]), .stage_2_out(stage_2_out[i]), .stage_3_in(stage_3_in[i]), .stage_3_out(stage_3_out[i]), .stage_3_out_acc(stage_3_out_acc[i]), .stage_4_in(stage_4_in[i]), .counter_q(counter_q[i]), .counter_q1(counter_q1[i]), .counter_q2(counter_q2[i]),.counter_d(counter_d[i]),.stage_4_out_mul(stage_4_out_mul[i]),.stage_4_out(stage_4_out[i]),.mult_inter(mult_inter[i]), .chicken_bit(chicken_bit), .weight_zero(weight_zero[i]),.done(done[i]));
end
endgenerate 

multiplier_test #(.BIT_WIDTH_A(STAGE_1_BIT_WIDTH),
.BIT_WIDTH_B(STAGE_1_NUM_INPUTS),
.BIT_WIDTH_OUT(STAGE_1_NUM_INPUTS+STAGE_1_BIT_WIDTH)) multiply (.wrData_act(wrData_act_q[0][0]),.input_wt(input_wt[0]),.mul_test(mul_test));

endmodule