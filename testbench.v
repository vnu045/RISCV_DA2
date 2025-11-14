module testbench();
	reg clk, reset;
	wire MemWrite;
	wire [31:0] WriteData, DataAdr, ReadDataM, InstrF;

	riscv dut(clk, reset, WriteData, DataAdr, ReadDataM, InstrF, MemWrite);
	
	initial
		begin
			clk <=1;
			reset <= 0; 
			# 10; 
			reset <= 1;
			
			$display("Simulation starts!");
			$monitor("Value of ALU = %d, InstrF = %b", DataAdr, InstrF);
			#5000;
			$stop;
		end
	


	always begin #5; clk <= ~clk; end
		 
	

endmodule