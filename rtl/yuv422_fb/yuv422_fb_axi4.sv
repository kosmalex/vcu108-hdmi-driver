module yuv422_fb_axi4 #(
  parameter PIXELS  = 1280 * 760,
  parameter Y_FILE  = "Y.mem",
  parameter UV_FILE = "UV.mem",

  localparam ADR_BITS = $clog2(PIXELS)
)(
  input  logic               clk_i,
  input  logic               rst_n_i,

  `include "axi_io.svh"

  input  logic[ADR_BITS-1:0] rd_addr_i,
  output logic[15:0]         rd_d_o
);

logic[ADR_BITS-1:0] wr_addr_s;
logic[23:0]         wr_d_s   ;
logic               wr_en_s  ;

axi2bram_native axi2bram_native_0 (
  .*,

  .s_axi_aclk    (clk_i            ), // input wire s_axi_aclk
  .s_axi_aresetn (rst_n_i          ), // input wire s_axi_aresetn

  .bram_rst_a    (/*Not connected*/), // output wire bram_rst_a
  .bram_clk_a    (/*Not connected*/), // output wire bram_clk_a
  .bram_en_a     (/*Not connected*/), // output wire bram_en_a
  .bram_we_a     (wr_en_s          ), // output wire [3 : 0] bram_we_a
  .bram_addr_a   (wr_addr_s        ), // output wire [19 : 0] bram_addr_a
  .bram_wrdata_a (wr_d_s           ), // output wire [31 : 0] bram_wrdata_a
  .bram_rddata_a ('d0              )  // input wire [31 : 0] bram_rddata_a
);

yuv422_fb #(
  .PIXELS (PIXELS ),
  .Y_FILE (Y_FILE ),
  .UV_FILE(UV_FILE)
)(
  .*,

  .wr_addr_i (wr_addr_s),
  .wr_d_i    (wr_d_s   ),
  .wr_en_i   (wr_en_s  )
);
endmodule