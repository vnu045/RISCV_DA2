module datapath0(	input  wire clk, rst,
input wire [31:0] InstrF,

input wire [2:0]  ALUCtrLE,
input wire        ALUSrcAE, ALUSrcBE, RegWriteW, PCSrc,
input wire [1:0]  ForwardAE, ForwardBE, ImmSrcD, ResultSrcW,
output wire [31:0] InstrD, PC,
output wire [31:0] ALUResultM, BM,
input wire [31:0] ReadDataM,
output wire [4:0] RS1D, RS2D, RS1E, RS2E,
output wire [4:0] RDE, RDM, RDW,
output wire ZeroE
);

wire [31:0] IfPC, Adder4, PCD, Adder4D, PCE, Adder4E, Adder4M, Adder4W;
wire [31:0] ALUResultE, ALUResultW;
wire [31:0] RD1D, RD2D, ImmOD, RD1E, RD2E, ImmOE, RDD;
wire [31:0] AE, BE, ScrAE, ScrBE, ResultW, ReadDataW;

wire [31:0] predicted_target;
wire        btb_hit;
wire        predict_taken;
wire        actual_taken;
wire [31:0] actual_target;
wire        update_en;

//wire [31:0] Adder4;
wire [31:0] PC_next;


adder a0(PC, 32'd4, Adder4);

btb btb0(
  .clk(clk),
  .reset(rst),
  .PC(PC),                  // địa chỉ hiện tại (IF stage)
  .update_en(update_en),    // tín hiệu cập nhật
  .actual_target(actual_target),
  .actual_taken(actual_taken),
  .predicted_target(predicted_target),
  .hit(btb_hit)
);
bht bht0(
  .clk(clk),
  .reset(rst),
  .pc_index(PC[9:2]),       // dùng 8 bit thấp làm index
  .update_en(update_en),
  .actual_taken(actual_taken),
  .predict_taken(predict_taken)
);

mux3 m_pcnext( Adder4, predicted_target, ALUResultE, {PCSrc, (btb_hit & predict_taken)}, IfPC);
//mux2 m0(Adder4, ALUResultE, PCSrc, IfPC);


d_ff pc0(IfPC, clk, rst, PC);

//instr_memory i0(pc, instr);

ifid i1(	clk, rst, InstrF, PC, Adder4, 
			InstrD, PCD, Adder4D);
assign RS1D = InstrD[19:15];
assign RS2D = InstrD[24:20];	
assign RDD = InstrD[11:7];		
regfile reg0(	clk, rst, RS1D, RS2D, RDW, RegWriteW, ResultW,  
					RD1D, RD2D);
extend imm0(	InstrD[31:7], ImmSrcD,
					ImmOD);

idex i2(	clk, rst, PCD, Adder4D, RD1D, RD2D, ImmOD, RDD, RS1D, RS2D,
			PCE, Adder4E, RD1E, RD2E, ImmOE, RDE, RS1E, RS2E);

mux3 ma1(RD1E, ResultW, ALUResultM, ForwardAE, AE);
mux2 ma2(PCE, AE, ALUSrcAE, ScrAE);

mux3 mb1(RD2E, ResultW, ALUResultM, ForwardBE, BE);
mux2 mb2(BE, ImmOE, ALUSrcBE, ScrBE);

//Branchtaken bran(a, b, result)

alu alu0(ScrAE, ScrBE, ALUCtrLE, ALUResultE, ZeroE);

//
assign actual_taken  = PCSrc;          
assign actual_target = ALUResultE;     
assign update_en     = 1'b1;           

//

exmem i3(clk, rst, Adder4E, ALUResultE, BE, RDE, 
			Adder4M, ALUResultM, BM, RDM); 
//dmem d1(ALUResultM (addr), BM(datain), MemWriteM, 
//	ReadDataM);

memwb i4(clk, rst, Adder4M, ALUResultM, ReadDataM, RDM, 
			Adder4W, ALUResultW, ReadDataW, RDW);
mux3 wb(ALUResultW, ReadDataW, Adder4W, ResultSrcW, ResultW);
endmodule
