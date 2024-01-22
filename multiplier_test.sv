

module multiplier_test #(parameter BIT_WIDTH_A = 8,
			parameter BIT_WIDTH_B = 8,
                        parameter BIT_WIDTH_OUT = BIT_WIDTH_A+BIT_WIDTH_B) 
			(input logic [BIT_WIDTH_A -1:0] input_wt,
			 input logic [BIT_WIDTH_B -1:0] wrData_act,
			 output logic [BIT_WIDTH_OUT-1:0] mul_test);

  
assign mul_test = BIT_WIDTH_OUT'(input_wt * wrData_act);
  

endmodule
	

