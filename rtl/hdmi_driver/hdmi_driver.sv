`include "../utilities.svh"

module hdmi_driver
#(
  // HDMI generics
  parameter ACTIVE_H_PIXELS = 1280    ,
  parameter H_FRONT_PORCH   = 110     ,
  parameter H_SYNC_WIDTH    = 40      ,
  parameter H_BACK_PORCH    = 220     ,
  parameter ACTIVE_LINES    = 720     ,
  parameter V_FRONT_PORCH   = 5       ,
  parameter V_SYNC_WIDTH    = 5       ,
  parameter V_BACK_PORCH    = 20      ,
  parameter FPS             = 60      ,
  parameter SYNC_POLARITY   = 0       ,
  parameter FRAME_X_SCALE   = 0       , // These are 2^{frame_scale}
  parameter FRAME_Y_SCALE   = 0       , // These are 2^{frame_scale}
  parameter Y_FILE          = "Y.mem" ,
  parameter UV_FILE         = "UV.mem",

  // I2C generics
  parameter DIVIDER         = 126, // 400 kHz @ 100Mhz clk_i
  parameter START_HOLD      = 35,
  parameter STOP_HOLD       = 35,
  parameter FREE_HOLD       = 75,
  parameter DATA_HOLD       = 30,
  parameter NBYTES          = 3 ,
  parameter NTRANS          = 41,
  parameter I2C_INIT_FILE   = "i2c_rom.mem",

  localparam FB_X         = ACTIVE_H_PIXELS >> FRAME_X_SCALE,
  localparam FB_Y         = ACTIVE_LINES    >> FRAME_Y_SCALE,
  localparam FB_ADDR_BITS = $clog2(FB_X*FB_Y)
)(
  input  logic             clk_i      ,
  input  logic             rst_n_i    ,
  input  logic             pixel_clk_i,

  `GEN_AXI_MST_IF_RO (hdmi, 32, 32, 4),

  // HDMI
  output logic             vs_o       , //Vertical sync out
  output logic             hs_o       , //Horizontal sync out
  output logic             ad_o       ,
  output logic             pixel_clk_o,
  output logic[15:0]       hdmi_d_o   ,

  // I2C or IIC
  output logic             scl_o      ,
  inout  logic             sda_io     ,
  output logic             i2c_done_o ,
  output logic             i2c_mux_o
);

logic         cdma_introut_s;
logic         virgin_s;
logic         start_ctrl_s;

logic[7 : 0]  s_axi_CTRL_AWADDR ;
logic         s_axi_CTRL_AWVALID;
logic         s_axi_CTRL_AWREADY;
logic[31 : 0] s_axi_CTRL_WDATA  ;
logic[3 : 0]  s_axi_CTRL_WSTRB  ;
logic         s_axi_CTRL_WVALID ;
logic         s_axi_CTRL_WREADY ;
logic[1 : 0]  s_axi_CTRL_BRESP  ;
logic         s_axi_CTRL_BVALID ;
logic         s_axi_CTRL_BREADY ;
logic[7 : 0]  s_axi_CTRL_ARADDR ;
logic         s_axi_CTRL_ARVALID;
logic         s_axi_CTRL_ARREADY;
logic[31 : 0] s_axi_CTRL_RDATA  ;
logic[1 : 0]  s_axi_CTRL_RRESP  ;
logic         s_axi_CTRL_RVALID ;
logic         s_axi_CTRL_RREADY ;

`GEN_AXI_WIRE_WO(m, 32, 32, 4);

axi4lite_ctrl
#(
  .N         (4        ),
  .ADDRW     (8        ),
  .DATAW     (24       ),
  .INIT_FILE ("hdmi_dma.mem")
)
axi4lite_ctrl_0 (
  .done_o (),
  .start_i(virgin_s),
  .*
);

axi_cdma_hdmi axi_cdma_hdmi_0 (
  .cdma_introut      (cdma_introut_s),        // output wire cdma_introut
  .cdma_tvect_out    (),       // output wire [31 : 0] cdma_tvect_out

  .s_axi_lite_aclk   (clk_i),               // input wire s_axi_lite_aclk
  .s_axi_lite_aresetn(rst_n_i),             // input wire s_axi_lite_aresetn
  
  .s_axi_lite_awready(s_axi_CTRL_AWREADY ), // output wire s_axi_lite_awready
  .s_axi_lite_awvalid(s_axi_CTRL_AWVALID ), // input wire s_axi_lite_awvalid
  .s_axi_lite_awaddr (s_axi_CTRL_AWADDR[5:0]  ), // input wire [5 : 0] s_axi_lite_awaddr
  .s_axi_lite_wready (s_axi_CTRL_WREADY  ), // output wire s_axi_lite_wready
  .s_axi_lite_wvalid (s_axi_CTRL_WVALID  ), // input wire s_axi_lite_wvalid
  .s_axi_lite_wdata  (s_axi_CTRL_WDATA   ), // input wire [31 : 0] s_axi_lite_wdata
  .s_axi_lite_bready (s_axi_CTRL_BREADY  ), // input wire s_axi_lite_bready
  .s_axi_lite_bvalid (s_axi_CTRL_BVALID  ), // output wire s_axi_lite_bvalid
  .s_axi_lite_bresp  (s_axi_CTRL_BRESP   ), // output wire [1 : 0] s_axi_lite_bresp
  .s_axi_lite_arready(s_axi_CTRL_ARREADY ), // output wire s_axi_lite_arready
  .s_axi_lite_arvalid(s_axi_CTRL_ARVALID ), // input wire s_axi_lite_arvalid
  .s_axi_lite_araddr (s_axi_CTRL_ARADDR[5:0]  ), // input wire [5 : 0] s_axi_lite_araddr
  .s_axi_lite_rready (s_axi_CTRL_RREADY  ), // input wire s_axi_lite_rready
  .s_axi_lite_rvalid (s_axi_CTRL_RVALID  ), // output wire s_axi_lite_rvalid
  .s_axi_lite_rdata  (s_axi_CTRL_RDATA   ), // output wire [31 : 0] s_axi_lite_rdata
  .s_axi_lite_rresp  (s_axi_CTRL_RRESP   ), // output wire [1 : 0] s_axi_lite_rresp
  
  .m_axi_aclk(clk_i),                       // input wire m_axi_aclk
  `GEN_AXI_CON_RO_DMA(m, hdmi),
  `GEN_AXI_CON_WO_DMA(m, m)
);

hdmi_controller_ADV7511_axi4
#(
  .ACTIVE_H_PIXELS(ACTIVE_H_PIXELS),
  .H_FRONT_PORCH  (H_FRONT_PORCH  ),
  .H_SYNC_WIDTH   (H_SYNC_WIDTH   ),
  .H_BACK_PORCH   (H_BACK_PORCH   ),
  .ACTIVE_LINES   (ACTIVE_LINES   ),
  .V_FRONT_PORCH  (V_FRONT_PORCH  ),
  .V_SYNC_WIDTH   (V_SYNC_WIDTH   ),
  .V_BACK_PORCH   (V_BACK_PORCH   ),
  .FPS            (FPS            ),
  .SYNC_POLARITY  (SYNC_POLARITY  ),
  .FRAME_X_SCALE  (FRAME_X_SCALE  ),
  .FRAME_Y_SCALE  (FRAME_Y_SCALE  ),
  .Y_FILE         (Y_FILE         ),
  .UV_FILE        (UV_FILE        ),
  .DIVIDER        (DIVIDER      ),
  .START_HOLD     (START_HOLD   ),
  .STOP_HOLD      (STOP_HOLD    ),
  .FREE_HOLD      (FREE_HOLD    ),
  .DATA_HOLD      (DATA_HOLD    ),
  .NBYTES         (NBYTES       ),
  .NTRANS         (NTRANS       ),
  .I2C_INIT_FILE  (I2C_INIT_FILE)
)
hdmi_controller_ADV7511_axi4_0(
  `GEN_AXI_CON_WO (s, m),
  .*
);

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    virgin_s <= 1'b1;
  end else if (virgin_s) begin
    virgin_s <= 1'b0;
  end
end

assign start_ctrl_s = virgin_s;

assign m_axi_awid   = 'd0;
assign m_axi_awlock = 'd0;
assign m_axi_awqos  = 'd0;

assign hdmi_axi_arid   = 'd0;
assign hdmi_axi_arlock = 'd0;
assign hdmi_axi_arqos  = 'd0;
endmodule