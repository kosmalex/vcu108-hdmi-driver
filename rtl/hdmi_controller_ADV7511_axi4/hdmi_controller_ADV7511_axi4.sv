module hdmi_controller_ADV7511
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

  `GEN_AXI_MST_IF

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

localparam TOTAL_PIXELS = ACTIVE_H_PIXELS 
                          + H_FRONT_PORCH 
                          + H_SYNC_WIDTH  
                          + H_BACK_PORCH; //Horizontal pixel count
localparam TOTAL_LINES  = ACTIVE_LINES    
                          + V_FRONT_PORCH 
                          + V_SYNC_WIDTH  
                          + V_BACK_PORCH; //Vertical pixel count
localparam HCNTR_BITS   = $clog2(TOTAL_PIXELS);
localparam VCNTR_BITS   = $clog2(TOTAL_LINES);
localparam PIXELS       = FB_X * FB_Y;

logic[HCNTR_BITS-1:0]        hcount_s;
logic[VCNTR_BITS-1:0]        vcount_s;
logic[15:0]                  rd_data_s;

logic[$clog2(FB_X*FB_Y)-1:0] rd_addr_s;

`include "axi_wires.svh"

cdc_hdmi_fifo cdc_hdmi_fifo_0 (
  .s_aresetn (rst_n_i    ), // input wire s_aresetn
  .s_aclk    (clk_i      ), // input wire s_aclk
  .m_aclk    (pixel_clk_i), // input wire m_aclk
  .*
);

yuv422_axi_fb #(
  .PIXELS  (FB_X*FB_Y),
  .Y_FILE  (Y_FILE   ),
  .UV_FILE (UV_FILE  )
)
yuv422_fb_axi_0(
  `include "yuv422_fb_axi_con.svh"

  .clk_i     (pixel_clk_i),
  .rd_addr_i (rd_addr_s ),
  .rd_d_o    (rd_data_s )
);

video_controller #(
  .ACTIVE_H_PIXELS (ACTIVE_H_PIXELS),
  .H_FRONT_PORCH   (H_FRONT_PORCH  ),
  .H_SYNC_WIDTH    (H_SYNC_WIDTH   ),
  .H_BACK_PORCH    (H_BACK_PORCH   ),
  .ACTIVE_LINES    (ACTIVE_LINES   ),
  .V_FRONT_PORCH   (V_FRONT_PORCH  ),
  .V_SYNC_WIDTH    (V_SYNC_WIDTH   ),
  .V_BACK_PORCH    (V_BACK_PORCH   ),
  .FPS             (FPS            ),
  .SYNC_POLARITY   (SYNC_POLARITY  )
)
video_controller_0 (
  .*,
  .hcount_o (hcount_s),
  .vcount_o (vcount_s),
  .nf_o     (/*Not connected*/),
  .fc_o     (/*Not connected*/)
);

i2c_controller
#(
  .DIVIDER    (DIVIDER      ),
  .START_HOLD (START_HOLD   ),
  .STOP_HOLD  (STOP_HOLD    ),
  .FREE_HOLD  (FREE_HOLD    ),
  .DATA_HOLD  (DATA_HOLD    ),
  .NBYTES     (NBYTES       ),
  .NTRANS     (NTRANS       ),
  .INIT_FILE  (I2C_INIT_FILE)
)
i2c_controller(
  .*,
  .start_1cc_i(1'b1      ),
  .done_o     (i2c_done_o)
);

always_ff @(posedge pixel_clk_i) begin
  if (!rst_n_i) begin
    rd_addr_s <= 'd0;
  end else begin
    if (ad_o) begin
      rd_addr_s <= (rd_addr_s < PIXELS-1) ? rd_addr_s + 'd1 : 'd0;
    end
  end
end

assign hdmi_d_o    = ad_o ? rd_data_s : 16'b0;
assign pixel_clk_i = pixel_clk_o;

endmodule