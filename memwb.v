module memwb (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] Adder4M,
    input  wire [31:0] ALUResultM,
    input  wire [31:0] ReadDataM,
    input  wire [4:0]  RDM,
    output reg  [31:0] Adder4W,
    output reg  [31:0] ALUResultW,
    output reg  [31:0] ReadDataW,
    output reg  [4:0]  RDW
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        Adder4W    <= 32'b0;
        ALUResultW <= 32'b0;
        ReadDataW  <= 32'b0;
        RDW        <= 5'b0;
    end else begin
        Adder4W    <= Adder4M;
        ALUResultW <= ALUResultM;
        ReadDataW  <= ReadDataM;
        RDW        <= RDM;
    end
end

endmodule
