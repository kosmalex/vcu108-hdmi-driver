module bram32_16 #(
  parameter LINES     = 16,
  parameter INIT_FILE = "dummy.mem"
)(
  input  logic                    clk_i,

  input  logic[$clog2(LINES)-1:0] wr_addr_i,
  input  logic[31:0]            wr_d_i,
  input  logic                    wr_en_i,

  input  logic[$clog2(LINES*2)-1:0] rd_addr_i,
  output logic[15:0]              rd_d_o
);

(* ram_style = "block" *)
logic [31:0] mem[LINES];

initial begin
  $readmemh(INIT_FILE, mem);
end

always_ff @(negedge clk_i) begin
  if(wr_en_i) begin
    mem[wr_addr_i] <= wr_d_i;
  end
end

always_ff @(negedge clk_i) begin
  rd_d_o <= rd_addr_i[0] ? mem[rd_addr_i[$clog2(LINES*2)-1:1]][31:16] : mem[rd_addr_i[$clog2(LINES*2)-1:1]][15:0];
end

endmodule