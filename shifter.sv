module shifter #(
    parameter bit_width = 1,
    parameter shift_amt = 1
) (
    input [bit_width-1:0] in,
    output [bit_width+shift_amt-1:0] out
);

  assign out = in << shift_amt;

endmodule: shifter
