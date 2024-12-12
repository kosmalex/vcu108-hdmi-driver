module video_generator #(
  parameter INIT_FILE = "tpg_ctrl.mem"
)(
  input logic  clk_i,
  input logic  rst_n_i,
  
  output logic done_o,
    
  output logic [0:0]  m_axis_video_TVALID,
  input  logic [0:0]  m_axis_video_TREADY,
  output logic [23:0] m_axis_video_TDATA ,
  output logic [0:0]  m_axis_video_TUSER ,
  output logic [0:0]  m_axis_video_TLAST
);

logic[7 : 0]    s_axi_CTRL_AWADDR ;
logic           s_axi_CTRL_AWVALID;
logic           s_axi_CTRL_AWREADY;
logic[31 : 0]   s_axi_CTRL_WDATA  ;
logic[3 : 0]    s_axi_CTRL_WSTRB  ;
logic           s_axi_CTRL_WVALID ;
logic           s_axi_CTRL_WREADY ;
logic[1 : 0]    s_axi_CTRL_BRESP  ;
logic           s_axi_CTRL_BVALID ;
logic           s_axi_CTRL_BREADY ;
logic[7 : 0]    s_axi_CTRL_ARADDR ;
logic           s_axi_CTRL_ARVALID;
logic           s_axi_CTRL_ARREADY;
logic[31 : 0]   s_axi_CTRL_RDATA  ;
logic[1 : 0]    s_axi_CTRL_RRESP  ;
logic           s_axi_CTRL_RVALID ;
logic           s_axi_CTRL_RREADY ;

axi4lite_ctrl #(
  .INIT_FILE(INIT_FILE)
) tpg_ctrl (
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .done_o (done_o),

    .s_axi_CTRL_AWADDR(s_axi_CTRL_AWADDR),
    .s_axi_CTRL_AWVALID(s_axi_CTRL_AWVALID),
    .s_axi_CTRL_AWREADY(s_axi_CTRL_AWREADY),
    .s_axi_CTRL_WDATA(s_axi_CTRL_WDATA),
    .s_axi_CTRL_WSTRB(s_axi_CTRL_WSTRB),
    .s_axi_CTRL_WVALID(s_axi_CTRL_WVALID),
    .s_axi_CTRL_WREADY(s_axi_CTRL_WREADY),
    .s_axi_CTRL_BRESP(s_axi_CTRL_BRESP),
    .s_axi_CTRL_BVALID(s_axi_CTRL_BVALID),
    .s_axi_CTRL_BREADY(s_axi_CTRL_BREADY),
    .s_axi_CTRL_ARADDR(s_axi_CTRL_ARADDR),
    .s_axi_CTRL_ARVALID(s_axi_CTRL_ARVALID),
    .s_axi_CTRL_ARREADY(s_axi_CTRL_ARREADY),
    .s_axi_CTRL_RDATA(s_axi_CTRL_RDATA),
    .s_axi_CTRL_RRESP(s_axi_CTRL_RRESP),
    .s_axi_CTRL_RVALID(s_axi_CTRL_RVALID),
    .s_axi_CTRL_RREADY(s_axi_CTRL_RREADY)
);

// Controll parameters
// 0x0010: 0x2D0             Active lines per frame
// 0x0018: 0x500             Active pixels per line
// 0x0020: 0x1 (H ramp)      Video pattern
// 0x0040: 0x2 (YUV422)      Color format
// 0x00d0: 0x0 (Progressive) Interlaced or not video mode
// 0x0000: 8'b10000001       Start core and auto-restart core after every transaction
v_tpg_0 tpg (
  .s_axi_CTRL_AWADDR (s_axi_CTRL_AWADDR),      // input wire [7 : 0] s_axi_CTRL_AWADDR
  .s_axi_CTRL_AWVALID(s_axi_CTRL_AWVALID),    // input wire s_axi_CTRL_AWVALID
  .s_axi_CTRL_AWREADY(s_axi_CTRL_AWREADY),    // output wire s_axi_CTRL_AWREADY
  .s_axi_CTRL_WDATA  (s_axi_CTRL_WDATA),        // input wire [31 : 0] s_axi_CTRL_WDATA
  .s_axi_CTRL_WSTRB  (s_axi_CTRL_WSTRB),        // input wire [3 : 0] s_axi_CTRL_WSTRB
  .s_axi_CTRL_WVALID (s_axi_CTRL_WVALID),      // input wire s_axi_CTRL_WVALID
  .s_axi_CTRL_WREADY (s_axi_CTRL_WREADY),      // output wire s_axi_CTRL_WREADY
  .s_axi_CTRL_BRESP  (s_axi_CTRL_BRESP),        // output wire [1 : 0] s_axi_CTRL_BRESP
  .s_axi_CTRL_BVALID (s_axi_CTRL_BVALID),      // output wire s_axi_CTRL_BVALID
  .s_axi_CTRL_BREADY (s_axi_CTRL_BREADY),      // input wire s_axi_CTRL_BREADY
  .s_axi_CTRL_ARADDR (s_axi_CTRL_ARADDR),      // input wire [7 : 0] s_axi_CTRL_ARADDR
  .s_axi_CTRL_ARVALID(s_axi_CTRL_ARVALID),    // input wire s_axi_CTRL_ARVALID
  .s_axi_CTRL_ARREADY(s_axi_CTRL_ARREADY),    // output wire s_axi_CTRL_ARREADY
  .s_axi_CTRL_RDATA  (s_axi_CTRL_RDATA),        // output wire [31 : 0] s_axi_CTRL_RDATA
  .s_axi_CTRL_RRESP  (s_axi_CTRL_RRESP),        // output wire [1 : 0] s_axi_CTRL_RRESP
  .s_axi_CTRL_RVALID (s_axi_CTRL_RVALID),      // output wire s_axi_CTRL_RVALID
  .s_axi_CTRL_RREADY (s_axi_CTRL_RREADY),      // input wire s_axi_CTRL_RREADY

  .ap_clk(clk_i),                            // input wire ap_clk                              ok
  .ap_rst_n(rst_n_i),                        // input wire ap_rst_n                               ok
  .fid(),                                  // output wire [0 : 0] fid                           ok
  .fid_in(1'b0),                            // input wire [0 : 0] fid_in                           ok
  .interrupt(),                      // output wire interrupt                                   ok
  
  .m_axis_video_TKEEP (),    // output wire [2 : 0] m_axis_video_TKEEP
  .m_axis_video_TSTRB (),    // output wire [2 : 0] m_axis_video_TSTRB
  .m_axis_video_TID   (),        // output wire [0 : 0] m_axis_video_TID
  .m_axis_video_TDEST (),    // output wire [0 : 0] m_axis_video_TDEST

  .*
);

endmodule