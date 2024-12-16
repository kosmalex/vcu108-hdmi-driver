module yuv422_fb #(
  parameter PIXELS  = 1280 * 760,
  parameter Y_FILE  = "Y.mem",
  parameter UV_FILE = "UV.mem",

  localparam ADR_BITS = $clog2(PIXELS)
)(
  input  logic               clk_i,
  input  logic               rst_n_i,

  input  logic[ADR_BITS-1:0] wr_addr_i,
  input  logic[31:0]         wr_d_i,
  input  logic               wr_en_i,

  input  logic[ADR_BITS-1:0] rd_addr_i,
  output logic[15:0]         rd_d_o
);

localparam EFF_PIXELS = PIXELS >> 1;
localparam ADR_W      = $clog2(EFF_PIXELS);

logic[31:0] uy_s;
// logic[15:0] vy_s;

// logic       uy_wen_s;
// logic       vy_wen_s;

// logic[ADR_W-1:0] uy_addr_s;
// logic[ADR_W-1:0] vy_addr_s;

/* Ignore chroma parts
logic[7:0] cb_s, cr_s;
logic[7:0] chroma_s;
*/

// logic[7:0] cb_s, cr_s;
// logic[7:0] chroma_s;

logic [ADR_W-1:0] addr_s;
assign addr_s = rd_addr_i >> 1;

bram #(
  .LINES    (PIXELS >> 1),
  .DW       (32),
  .INIT_FILE(Y_FILE)
)
UYVY_mem(
  .*,
  .wr_addr_i (wr_addr_i),
  .wr_d_i    (wr_d_i   ),
  .wr_en_i   (wr_en_i  ),

  .rd_addr_i (addr_s),
  .rd_d_o    (uy_s                )
);

// bram #(
//   .LINES    (PIXELS >> 1),
//   .DW       (16),
//   .INIT_FILE(UV_FILE)
// )
// VY_mem_1(
//   .*,
//   .wr_addr_i (vy_addr_s    ),
//   .wr_d_i    (wr_d_i[31:16]),
//   .wr_en_i   (vy_wen_s     ),

//   .rd_addr_i (rd_addr_i),
//   .rd_d_o    (vy_s      )
// );

// always_ff @(posedge clk_i) begin
//   if (!rst_n_i) begin
//     uy_addr_s <= 'd0;
//     vy_addr_s <= 'd0;
//   end else begin
//     if (uy_wen_s) begin
//       if (uy_addr_s < EFF_PIXELS-1) begin
//         uy_addr_s <= uy_addr_s + 'd1;
//       end else begin
//         uy_addr_s <= 'd0;
//       end
//     end 
    
//     if (vy_wen_s) begin
//       if (vy_addr_s < EFF_PIXELS-1) begin
//         vy_addr_s <= vy_addr_s + 'd1;
//       end else begin
//         vy_addr_s <= 'd0;
//       end
//     end 
//   end
// end

// always_comb begin
//   {uy_wen_s, vy_wen_s} = 'd0;
  
//   if(wr_addr_i[0])
//     vy_wen_s = 1'b1;
//   else begin
//     uy_wen_s = 1'b1;
//   end
// end

// logic rd_addr_sel_s;
// always_ff @(negedge clk_i) begin
//   if (!rst_n_i) begin
//     rd_addr_sel_s <= 'd0;
//   end else begin
//     rd_addr_sel_s <= rd_addr_i[0];
//   end
// end

// logic [15:0] rd_test_o;

assign rd_d_o = rd_addr_i[0] ? {uy_s[23:16], uy_s[31:24]} : {uy_s[7:0], uy_s[15:8]};
// assign rd_test_o = rd_addr_sel_s ? {uy_s[23:16], uy_s[31:24]} : {uy_s[7:0], uy_s[15:8]};

/* Ignore chroma components for now
bram #(
  .LINES    (PIXELS >> 1),
  .DW       (16),
  .INIT_FILE(UV_FILE)
)
CbCr_mem(
  .*,
  .wr_addr_i (wr_addr_i[ADR_BITS-1:1]),
  .wr_d_i    (wr_d_i[0+:16]        ),
  .wr_en_i   (wr_en_i              ),

  .rd_addr_i (rd_addr_i[ADR_BITS-1:1]),
  .rd_d_o    ({cb_s, cr_s})
);

assign chroma_s = rd_addr_i[0] ? cr_s : cb_s;
assign rd_d_o   = {chroma_s, y_s};
*/
//assign rd_d_o = {8'b0, y_s};

endmodule