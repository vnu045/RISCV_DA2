module riscv (input wire 			clk, reset, 
			output wire [31:0] 	WriteDataM,  DataAdrM, ReadDataM, InstrF,
			output wire 			MemWriteM);
				
	wire [31:0] PCF, PCout;
	
// instantiate processor and memories
	pipe rv( clk, reset, InstrF, PCF, MemWriteM, DataAdrM, WriteDataM, ReadDataM);
	imem Imem0(PCF, InstrF);
	dmem Dmem0(clk, reset, DataAdrM[9:2], MemWriteM, WriteDataM, ReadDataM);

endmodule