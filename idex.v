module idex (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] PCD,
    input  wire [31:0] Adder4D,
    input  wire [31:0] RD1D,
    input  wire [31:0] RD2D,
    input  wire [31:0] ImmOD,
    input  wire [4:0]  RDD, RS1D, RS2D,
    output reg  [31:0] PCE,
    output reg  [31:0] Adder4E,
    output reg  [31:0] RD1E,
    output reg  [31:0] RD2E,
    output reg  [31:0] ImmOE,
    output reg  [4:0]  RDE, RS1E, RS2E
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        PCE      <= 32'b0;
        Adder4E  <= 32'b0;
        RD1E     <= 32'b0;
        RD2E     <= 32'b0;
        ImmOE    <= 32'b0;
        RDE      <= 5'b0;
		  RS1E      <= 5'b0;
		  RS2E      <= 5'b0;
    end else begin
        PCE      <= PCD;
        Adder4E  <= Adder4D;
        RD1E     <= RD1D;
        RD2E     <= RD2D;
        ImmOE    <= ImmOD;
        RDE      <= RDD;
		  RS1E      <= RS1D;
		  RS2E      <= RS2D;
    end
end

endmodule
