

module CIM_CHIP_no_pad_no_scan #( parameter STAGE_1_NUM_INPUTS = 8,//should be power of 2
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
input logic [SIZE_ACT_ARRAY-1:0][STAGE_1_BIT_WIDTH-1:0] wrData_act,
input logic [STAGE_1_BIT_WIDTH-1:0] input_wt,
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
output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_in,
output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_flop_in,
output logic [SIZE_ACT_ARRAY-1:0][STAGE_1_BIT_WIDTH-1:0] wrData_act_q,
output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out,
output logic [STAGE_1_OUT_BIT_WIDTH-1:0] adder_out,
//output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] extended_in,//Not included in chip because mux_2_in is a superset
output logic [STAGE_1_OUT_BIT_WIDTH-1:0] stage_1_out,

output logic [STAGE_1_MUX_2_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] mux_2_in,
output logic [STAGE_1_MUX_2_NUM_INPUTS-1:0] sel,
output logic [STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_in,
output logic [$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_q,
output logic [$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_d,
output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_out,
output logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_3_in,
output logic [STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out,
output logic [STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out_acc,
output logic [STAGE_3_OUT_BIT_WIDTH-1:0] stage_4_in,
output logic [counter_bit_width-1:0] counter_q,
output logic [counter_bit_width-1:0] counter_q1,
output logic [counter_bit_width-1:0] counter_q2,
output logic [counter_bit_width-1:0] counter_d,
//output logic [$clog2(STAGE_1_NUM_INPUTS):0][2**$clog2(STAGE_1_NUM_INPUTS)-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_inter, //Not used in chip
//output logic [STAGE_4_BIT_WIDTH-1:0] rdData_queue, // Not used in chip
output logic [STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out_mul,
output logic [STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out,
output logic [STAGE_4_OUT_BIT_WIDTH-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] mult_inter,
output logic weight_zero,
output logic done);

logic [STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] extended_in; //Not used in chip
logic [$clog2(STAGE_1_NUM_INPUTS):0][2**$clog2(STAGE_1_NUM_INPUTS)-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_inter;//Not used in chip

logic [STAGE_4_BIT_WIDTH-1:0] rdData_queue; // Not used in chip
logic [STAGE_1_NUM_INPUTS-1:0] [STAGE_1_BIT_WIDTH-1:0] input_wt_extend;
logic [STAGE_1_NUM_INPUTS-1:0] sparse;

genvar i;
generate for (i=0; i<STAGE_1_NUM_INPUTS; i++) begin
assign input_wt_extend[i] = input_wt;
end
endgenerate
// Flop array for activation storage
flip_flop #(.size(SIZE_ACT_ARRAY),.bit_width(STAGE_1_BIT_WIDTH)) act_array (.clk(clk), .reset(reset), .en(wrEn_act_array), .d(wrData_act),.q(wrData_act_q));
genvar j;
generate for (i=0; i< STAGE_1_NUM_INPUTS; i++) begin: num_inputs
for(j=0; j<STAGE_1_BIT_WIDTH; j++) begin: bit_width
assign stage_1_in[i][j] = wrData_act_q[SIZE_ACT_ARRAY-1][i] & input_wt_extend[i][j];
end: bit_width
assign sparse[i] = (stage_1_in[i]=='0) ? 1'b1 : 1'b0;
end: num_inputs
endgenerate

assign weight_zero = &(sparse);

logic [STAGE_3_OUT_BIT_WIDTH-1:0] stage_4_in_chicken;
logic SRAM_flop_en;
generate if (SRAM_THROUGHPUT > 1)
assign SRAM_flop_en = (&(counter_d[$clog2(SRAM_THROUGHPUT)-1:0]) & (~chicken_bit)) | (SRAM_flop_en_in);
else
assign SRAM_flop_en = (1'b1 & ~chicken_bit) | (SRAM_flop_en_in);
endgenerate
//assign SRAM_flop_en = (SRAM_THROUGHPUT > 1 ) ? (&(counter_d[$clog2(SRAM_THROUGHPUT)-1:0])) : 1'b1;

flip_flop #(.size(STAGE_1_NUM_INPUTS),.bit_width(STAGE_1_BIT_WIDTH)) SRAM_flop (.clk(clk), .reset(reset),.en({STAGE_1_NUM_INPUTS{SRAM_flop_en}}),.d(stage_1_in),.q(stage_1_flop_in));

assign counter_d = counter_q + 1'b1;
//Flip flop for counter
flip_flop #(.size(1),.bit_width(counter_bit_width)) counter_1 (.clk(clk), .reset(reset), .en(1'b1),
                                           .d(counter_d),.q(counter_q));
logic [$clog2(STAGE_1_NUM_INPUTS)-1:0] counter_d_disable;
logic [$clog2(STAGE_1_NUM_INPUTS)-1:0] counter_q_disable;

assign counter_d_disable = counter_q_disable+1;
//Flip flop for disable stage 1 counter
flip_flop #(.size(1),.bit_width($clog2(STAGE_1_NUM_INPUTS))) counter_disable (.clk(clk), .reset(reset), .en(counter_d[0]),.d(counter_d_disable),.q(counter_q_disable));
//Stage 1 - Dot product
stage1 #(.STAGE_1_NUM_INPUTS(STAGE_1_NUM_INPUTS),.STAGE_1_BIT_WIDTH(STAGE_1_BIT_WIDTH),
.STAGE_1_MAX_SHIFT_AMT(STAGE_1_MAX_SHIFT_AMT),.STAGE_1_MUX_2_NUM_INPUTS(STAGE_1_MUX_2_NUM_INPUTS),
.STAGE_1_OUT_BIT_WIDTH(STAGE_1_OUT_BIT_WIDTH))
stage1 (.in(stage_1_flop_in),.DISABLE_STAGE_1(DISABLE_STAGE_1), .count(counter_q_disable),.out(stage_1_out),.shift_out(shift_out),.adder_out(adder_out),.extended_in(extended_in), .mux_2_in(mux_2_in),.sel(sel));

logic flop_1_en;
generate if (SRAM_THROUGHPUT > 1)
assign flop_1_en = (&(counter_q[$clog2(SRAM_THROUGHPUT)-1:0]) & (~chicken_bit)) | (flop_1_en_in);
else
assign flop_1_en = (1'b1 & ~chicken_bit) | (flop_1_en_in);
endgenerate

//assign flop_1_en = (SRAM_THROUGHPUT > 1 ) ? (&(counter_q[$clog2(SRAM_THROUGHPUT)-1:0])) : 1'b1;
//Pipeline stage 1-2
flip_flop #(.size(1),.bit_width(STAGE_1_OUT_BIT_WIDTH_NECESSARY)) stage_2_flop (.clk(clk), .reset(reset), .en(flop_1_en), .d(stage_1_out[STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0]),.q(stage_2_in));
flip_flop #(.size(1),.bit_width(counter_bit_width)) counter_2 (.clk(clk), .reset(reset), .en(1'b1),.d(counter_q),.q(counter_q1));
//Stage 2 - Write into queue

logic queue_en;
generate if (SRAM_THROUGHPUT > 1)
assign queue_en = (&(counter_q1[$clog2(SRAM_THROUGHPUT)-1:0]) & (~chicken_bit)) | (queue_en_in);
else
assign queue_en = (~chicken_bit & 1'b1) | (queue_en_in);
endgenerate
//assign queue_en = (SRAM_THROUGHPUT > 1 ) ? (&(counter_q1[$clog2(SRAM_THROUGHPUT)-1:0])) : 1'b1;
queue #(.num_entries(STAGE_1_NUM_INPUTS), .bit_width(STAGE_1_OUT_BIT_WIDTH_NECESSARY))
queue_1 (.in(stage_2_in), .clk(clk), .reset(reset), .en(queue_en), .out(stage_2_out),.wrPtr_d_in(wrPtr_d_in),.disable_stage(wrPtr_over_in), .wrPtr_q(wrPtr_q), .wrPtr_d(wrPtr_d));

assign stage_3_in = (DISABLE_STAGE_2) ? stage_2_in : stage_2_out ;

//Stage 3 - Accumulation
stage3 #(.STAGE_1_NUM_INPUTS(STAGE_1_NUM_INPUTS),
.STAGE_1_BIT_WIDTH(STAGE_1_BIT_WIDTH),
.STAGE_1_MAX_SHIFT_AMT(STAGE_1_MAX_SHIFT_AMT),
.STAGE_1_OUT_BIT_WIDTH_NECESSARY(STAGE_1_OUT_BIT_WIDTH_NECESSARY),
.STAGE_3_OUT_BIT_WIDTH(STAGE_3_OUT_BIT_WIDTH)) acc (
.in(stage_3_in),
.out(stage_3_out_acc),
.inter(stage_3_inter));
assign stage_3_out = (DISABLE_STAGE_3) ? (stage_3_in): (stage_3_out_acc);

flip_flop #(.size(1),.bit_width(counter_bit_width)) counter_3 (.clk(clk), .reset(reset), .en(1'b1),.d(counter_q1),.q(counter_q2));

logic flop_3_en;

assign flop_3_en = (&(counter_q2[counter_bit_width-1:0]) & ~chicken_bit) | (flop_3_en_in);

//assign flop_3_en = (SRAM_THROUGHPUT > 1 ) ? &(counter_q2[counter_bit_width-1:0]) : 1'b1;
//Stage 3 - Flip flop
flip_flop #(.size(1),.bit_width(STAGE_3_OUT_BIT_WIDTH)) stage_3_flop (.clk(clk), .reset(reset), .en(flop_3_en), .d(stage_3_out),.q(stage_4_in));

//Done logic
logic flop_3_en_out;
flip_flop #(.size(1),.bit_width(1)) done_flop (.clk(clk), .reset(reset), .en(1'b1), .d(flop_3_en),.q(flop_3_en_out));
assign done = (flop_3_en) ? 1'b1: 1'b0; 
//Stage 4 - Flip flop - queue
flip_flop #(.size(1),.bit_width(STAGE_4_BIT_WIDTH)) stage_4_flop (.clk(clk), .reset(reset), .en(wrEn_queue), .d(wrData_queue),.q(rdData_queue));

assign stage_4_in_chicken = {STAGE_3_OUT_BIT_WIDTH{in}};
multiplier #(.bit_width_A(STAGE_3_OUT_BIT_WIDTH),.bit_width_B(STAGE_4_BIT_WIDTH),
.bit_width_out(STAGE_4_OUT_BIT_WIDTH)) mult
(.in_A(stage_4_in | stage_4_in_chicken),.in_B(rdData_queue),.out(stage_4_out_mul),.inter(mult_inter));

//Final mux for choosing whether to use STAGE 4 or not
assign stage_4_out = (DISABLE_STAGE_4)? {{(STAGE_4_OUT_BIT_WIDTH-STAGE_3_OUT_BIT_WIDTH){stage_4_in[STAGE_3_OUT_BIT_WIDTH-1]}},stage_4_in[STAGE_3_OUT_BIT_WIDTH-1:0]} : (stage_4_out_mul);
assign stage_4_o = stage_4_out[1:0];
endmodule