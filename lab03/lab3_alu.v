module lab3_alu(
  //clock and control signals
  input clk,
  input rst_n,
  //input
  input [15:0] inputA, inputB,
  input [4:0] instruction,
  //output
  output reg [15:0] alu_out
);
	reg [15:0] inputA_reg, inputB_reg;
	reg [4:0] instruction_reg;
	reg [15:0] f;
	
	always@(posedge clk ) begin
		
		if(rst_n==0) begin
			inputA_reg <= 16'b0;
			inputB_reg <= 16'b0;
			instruction_reg <= 5'b0;
			alu_out <= 16'b0;
		end

		else	begin

			alu_out <= f;
		end
	end


	always@* begin
		inputA_reg <= inputA;
		inputB_reg <= inputB;
		instruction_reg <= instruction;
	end

	always@*	begin
		case(instruction_reg)
			5'b00000 : f = inputA_reg;
			5'b00001 : f = inputA_reg + 1;
			5'b00010 : f = inputA_reg + (~inputB_reg);
			5'b00011 : f = inputA_reg + (~inputB_reg) + 1;
			5'b00100 : f = inputA_reg + inputB_reg;
			5'b00101 : f = inputA_reg + inputB_reg + 1;
			5'b00110 : f = inputB_reg;
			5'b00111 : f = inputA_reg - 1;
			
			5'b01000 : f = inputA_reg & inputB_reg;
			5'b01001 : f = inputA_reg | inputB_reg;
			5'b01010 : f = inputA_reg ^ inputB_reg;
			5'b01011 : f = ~inputA_reg;
			
			5'b10000 : f = inputB_reg >> 1;
			5'b10001 : f = inputB_reg << 1;
			5'b10010 : f = {inputB_reg[0], inputB_reg[15:1]};
			5'b10011 : f = {inputB_reg[14:0], inputB_reg[15]};
			
			default : f = inputA_reg;
		endcase
	end
		
endmodule
