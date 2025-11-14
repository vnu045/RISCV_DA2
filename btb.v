module btb(
  input wire clk,
  input wire reset,
  input wire [31:0] PC,
  input wire update_en,
  input wire [31:0] actual_target,
  input wire actual_taken,
  output wire [31:0] predicted_target,
  output wire hit
);
  reg [31:10] tag_table [0:255];
  reg [31:0]  target_table [0:255];
  reg valid [0:255];

  wire [7:0] index = PC[9:2];
  wire [31:10] pc_tag = PC[31:10];

  assign hit = valid[index] && (tag_table[index] == pc_tag);
  assign predicted_target = target_table[index];

  always @(posedge clk) begin
    if (update_en && actual_taken) begin
      tag_table[index]    <= pc_tag;
      target_table[index] <= actual_target;
      valid[index]        <= 1'b1;
    end
  end
endmodule
