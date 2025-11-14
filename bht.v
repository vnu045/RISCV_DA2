module bht(
  input wire clk,
  input wire reset,
  input wire [7:0] pc_index,        
  input wire update_en,             
  input wire actual_taken,
  output wire predict_taken
);
  reg [1:0] tablebht [0:255];          

  wire [1:0] counter = tablebht[pc_index];
  assign predict_taken = counter[1]; 

  always @(posedge clk) begin
    if (update_en) begin
      if (actual_taken && tablebht[pc_index] != 2'b11)
        tablebht[pc_index] <= tablebht[pc_index] + 1;
      else if (!actual_taken && tablebht[pc_index] != 2'b00)
        tablebht[pc_index] <= tablebht[pc_index] - 1;
    end
  end
endmodule
