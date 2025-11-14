module exmem (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] Adder4E,
    input  wire [31:0] ALUResultE,
    input  wire [31:0] BE,
    input  wire [4:0]  RDE,
    output reg  [31:0] Adder4M,
    output reg  [31:0] ALUResultM,
    output reg  [31:0] BM,
    output reg  [4:0]  RDM
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        Adder4M    <= 32'b0;
        ALUResultM <= 32'b0;
        BM         <= 32'b0;
        RDM        <= 5'b0;
    end else begin
        Adder4M    <= Adder4E;
        ALUResultM <= ALUResultE;
        BM         <= BE;
        RDM        <= RDE;
    end
end

endmodule
