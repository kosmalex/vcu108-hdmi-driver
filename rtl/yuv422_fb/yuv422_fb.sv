module yuv422_fb #(
  parameter PIXELS    = 1280 * 760,
  parameter INIT_FILE = "dummy.mem",

  localparam ADR_BITS = $clog2(PIXELS)
)(
  input  logic               clk_i,

  input  logic[ADR_BITS-1:0] wr_addr_i,
  output logic[23:0]         wr_d_i,
  output logic               wr_en_i,

  input  logic[ADR_BITS-1:0] rd_addr_i,
  output logic[15:0]         rd_d_o
);

logic[7:0] y_s, cb_s, cr_s;
logic[7:0] chroma_s;

bram #(
  .LINES (PIXELS),
  .DW    (8)
)
Y_mem(
  .*,
  .wr_addr_i (wr_addr_i    ),
  .wr_d_i    (wr_d_i[23-:8]),
  .wr_en_i   (wr_en_i      ),

  .rd_addr_i (rd_addr_i),
  .rd_d_o    (y_s      )
);

bram #(
  .LINES (PIXELS >> 1),
  .DW    (16)
)
CbCr_mem(
  .*,
  .wr_addr_i (wr_addr_i[ADR_BITS-1:1]),
  .wr_d_i    (wr_d_i[0+:16]        ),
  .wr_en_i   (wr_en_i              ),

  .rd_addr_i (rd_addr_i[ADR_BITS-1:1]),
  .rd_d_o    ({cb_s, cr_s})
);

assign chroma_s = rd_addr_i[0] ? cb_s : cr_s;
assign rd_d_o   = {chroma_s, y_s};

endmodule