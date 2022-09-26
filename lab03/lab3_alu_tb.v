module test_alu;
reg clk, rst_n;
reg [15:0] inputA, inputB, true_out;
reg [4:0] instruction;
wire [15:0] alu_out;

reg [15:0] old_inputA, old_inputB, old_instruction;
reg [15:0] old1_inputA, old1_inputB, old1_instruction;
integer i, j, k, l;
integer outfile, infile, pat_error;

parameter CYCLE = 10;
parameter INSTRUCTION_NUM = 16;
parameter INPUT_NUM = 16;

// Instantiate ALU circuit module
lab3_alu my_alu(
  .clk(clk),
  .rst_n(rst_n),
  .inputA(inputA),
  .inputB(inputB),
  .instruction(instruction),
  .alu_out(alu_out)
);

//system 
initial begin : proc_system
  clk = 1;
  rst_n = 1;
  // system reset
  #(CYCLE) rst_n = 0;
  #(CYCLE) rst_n = 1;
end
always #(CYCLE/2) clk=~clk;


reg [15:0] pat_A [0:INPUT_NUM*INPUT_NUM*INSTRUCTION_NUM-1];
reg [15:0] pat_B [0:INPUT_NUM*INPUT_NUM*INSTRUCTION_NUM-1];
reg [4:0] pat_Intr [0:INPUT_NUM*INPUT_NUM*INSTRUCTION_NUM-1];
reg [15:0] golden [0:INPUT_NUM*INPUT_NUM*INSTRUCTION_NUM-1];

//answer check
initial begin
  $readmemh("pat_a.dat",pat_A);
  $readmemh("pat_b.dat",pat_B);
  $readmemh("pat_instr.dat",pat_Intr);
  $readmemh("golden.dat",golden);
  pat_error = 0;

  inputA = 0;
  inputB = 0;
  instruction = 0;

  wait(rst_n==0);
  wait(rst_n==1);
  #(CYCLE*2);
  for(l=0; l<INSTRUCTION_NUM*INPUT_NUM*INPUT_NUM; l=l+1) begin
    @(negedge clk);

    instruction=pat_Intr[l];
    inputA=pat_A[l];
    inputB=pat_B[l];

    @(negedge clk);
    if(alu_out!==golden[l])begin
      pat_error = pat_error + 1;
      $display("*********** Pattern No.%d is wrong **********", l);
      $display("inputA = %b, inputB = %b, instruction = %b",inputA,inputB,instruction);  
      $display("golden = %b, but your answer is %b QQ Orz ",golden[l], alu_out);  
      $finish;
    end
  end
  $display("Congratulations!! The functionality of your ALU is correct!!");  
  #(CYCLE) $finish;
end


initial begin
   $fsdbDumpfile("lab3_alu.fsdb");
   $fsdbDumpvars;
end

// Main pattern


endmodule
