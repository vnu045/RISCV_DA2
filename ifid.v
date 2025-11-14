module ifid (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] InstrF,
    input  wire [31:0] PC,
    input  wire [31:0] Adder4,
    output reg  [31:0] InstrD,
    output reg  [31:0] PCD,
    output reg  [31:0] Adder4D
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        InstrD  <= 32'b0;
        PCD     <= 32'b0;
        Adder4D <= 32'b0;
    end else begin
        InstrD  <= InstrF;
        PCD     <= PC;
        Adder4D <= Adder4;
    end
end

endmodule
