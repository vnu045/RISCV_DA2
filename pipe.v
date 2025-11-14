module pipe(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] InstrF,
	 output wire [31:0] PC,
	 output wire MemWriteM,
    output wire [31:0] ALUResultM,
    output wire [31:0] BM,
	 input  wire [31:0] ReadDataM
);

    // ========= Wire kết nối giữa các module =========
    wire [3:0]  ALUCtrLE;
    wire        ALUSrcAE, ALUSrcBE;
    wire        MemReadM;
    wire        RegWriteM, RegWriteW, PCSrc, ResultSrcE0, PCJalSrcE;
    wire [1:0]  ImmSrcD, ResultSrcW;
    wire [1:0]  ForwardAE, ForwardBE;
    wire [4:0]  RS1D, RS2D, RS1E, RS2E;
    wire [4:0]  RDE, RDM, RDW;
    wire        ZeroE;
	 wire [31:0] InstrD;

    // ========= Khối controller =========
    controller control_unit (
        .clk(clk),
        .reset(rst),
        .op(InstrD[6:0]),
        .funct3(InstrD[14:12]),
        .funct7b5(InstrD[30]),
        .ZeroE(ZeroE),
        .ResultSrcE0(ResultSrcE0),
        .ResultSrcW(ResultSrcW),
        .MemWriteM(MemWriteM),
        .PCJalSrcE(PCJalSrcE),
        .PCSrcE(PCSrc),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ImmSrcD(ImmSrcD),
        .ALUControlE(ALUCtrLE)
    );

    // ========= Khối datapath chính =========
    datapath0 datapath01 (
        .clk(clk),
        .rst(rst),
        .InstrF(InstrF),
        .ALUCtrLE(ALUCtrLE),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .RegWriteW(RegWriteW),
        .PCSrc(PCSrc),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ImmSrcD(ImmSrcD),
        .ResultSrcW(ResultSrcW),
        .InstrD(InstrD),
		  .PC(PC),
        .ALUResultM(ALUResultM),
        .BM(BM),
        .ReadDataM(ReadDataM),
        .RS1D(RS1D), .RS2D(RS2D),
        .RS1E(RS1E), .RS2E(RS2E),
        .RDE(RDE), .RDM(RDM), .RDW(RDW),
        .ZeroE(ZeroE)
    );

    // ========= Khối hazard unit =========
    hazard haz (
        .Rs1D(RS1D),
        .Rs2D(RS2D),
        .Rs1E(RS1E),
        .Rs2E(RS2E),
        .RdE(RDE),
        .RdM(RDM),
        .RdW(RDW),
        .RegWriteM(RegWriteM), 
        .RegWriteW(RegWriteW),
        .ResultSrcE0(ResultSrcE0),
        .PCSrcE(PCSrc),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule
