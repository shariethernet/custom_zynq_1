



//Num_entries needs to be a power of 2
module queue #(parameter num_entries = 10,
               parameter bit_width = 8)
  (input logic [bit_width-1:0] in,
   input logic clk,
   input logic reset,
   input logic en,
   input logic disable_stage,
   input logic [$clog2(num_entries)-1:0] wrPtr_d_in,
   output logic [num_entries-1:0][bit_width-1:0] out,
   output logic [$clog2(num_entries)-1:0] wrPtr_q,
   output logic [$clog2(num_entries)-1:0] wrPtr_d);

  genvar i;
  generate for (i=0 ; i <num_entries; i++) begin
    flip_flop #(.size(1),.bit_width(bit_width)) queue_1 (.d(in),.q(out[i]),.en((wrPtr_q == i)&en),.clk(clk),.reset(reset));
  end
  endgenerate
  logic [$clog2(num_entries)-1:0] DISABLE_STAGE_2_extended;
  assign DISABLE_STAGE_2_extended = {($clog2(num_entries)){disable_stage}};
  assign wrPtr_d = ((~DISABLE_STAGE_2_extended) & (wrPtr_q+1)) | (wrPtr_d_in);

  flip_flop #(.size(1), .bit_width($clog2(num_entries))) wrPtr (.d(wrPtr_d),.q(wrPtr_q), .en(en), .clk(clk),.reset(reset));


endmodule

