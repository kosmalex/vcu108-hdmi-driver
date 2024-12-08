module bram #(
  parameter LINES     = 16,
  parameter DW        = 32,
  parameter INIT_FILE = "dummy.mem"
)(
  input  logic                    clk_i,

  input  logic[$clog2(LINES)-1:0] wr_addr_i,
  input  logic[DW-1:0]            wr_d_i,
  input  logic                    wr_en_i,

  input  logic[$clog2(LINES)-1:0] rd_addr_i,
  output logic[DW-1:0]            rd_d_o
);

(* ram_style = "block" *)
logic [DW-1:0] mem[LINES];

initial begin
  $readmemh(INIT_FILE, mem);
end

always_ff @(posedge clk_i) begin
  if(wr_en_i) begin
    mem[wr_addr_i] <= wr_d_i;
  end
end

assign rd_d_o = mem[rd_addr_i];

endmodule