module hdmi_controller_ADV7511
#(
  // HDMI generics
  parameter ACTIVE_H_PIXELS = 1280,
  parameter H_FRONT_PORCH   = 110 ,
  parameter H_SYNC_WIDTH    = 40  ,
  parameter H_BACK_PORCH    = 220 ,
  parameter ACTIVE_LINES    = 720 ,
  parameter V_FRONT_PORCH   = 5   ,
  parameter V_SYNC_WIDTH    = 5   ,
  parameter V_BACK_PORCH    = 20  ,
  parameter FPS             = 60  ,
  parameter FRAME_X_SCALE   = 0   , // These are 2^{frame_scale}
  parameter FRAME_Y_SCALE   = 0   , // These are 2^{frame_scale}

  // I2C generics
  parameter DIVIDER         = 13,
  parameter START_HOLD      = 5 ,
  parameter STOP_HOLD       = 5 ,
  parameter FREE_HOLD       = 5 ,
  parameter DATA_HOLD       = 2 ,
  parameter NBYTES          = 3 ,
  parameter NTRANS          = 41,
  parameter I2C_INIT_FILE   = "i2c_rom.mem",

  localparam FB_X         = ACTIVE_H_PIXELS >> FRAME_X_SCALE,
  localparam FB_Y         = ACTIVE_LINES    >> FRAME_Y_SCALE,
  localparam FB_ADDR_BITS = $clog2(FB_X*FB_Y)
)(
  input  logic                   clk_i      ,
  input  logic                   rst_n_i    ,
  input  logic                   pixel_clk_i,

  input  logic[FB_ADDR_BITS-1:0] pxl_addr_i ,
  input  logic[23:0]             pxl_data_i ,
  input  logic                   pxl_en_i   ,  

  // HDMI
  output logic                   vs_o    , //Vertical sync out
  output logic                   hs_o    , //Horizontal sync out
  output logic                   ad_o    ,
  output logic[15:0]             hdmi_d_o,

  // I2C or IIC
  output logic                   scl_o      ,
  inout  logic                   sda_io     ,
  output logic                   i2c_done_o ,
  output logic[NBYTES-1:0]       status_o[NTRANS]
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

logic[HCNTR_BITS-1:0]        hcount_s;
logic[VCNTR_BITS-1:0]        vcount_s;
logic[15:0]                  rd_data_s;

(* use_dsp = "yes" *) 
logic[$clog2(FB_X*FB_Y)-1:0] rd_addr_s;

assign rd_addr_s = vcount_s * FB_X + hcount_s;
assign hdmi_d_o  = ad_o ? rd_data_s : 16'b0;

yuv422_fb #(
  .PIXELS(FB_X*FB_Y)
)
yuv422_fb_0(
  .*,
  .clk_i     (pixel_clk_i),
  .wr_addr_i (pxl_addr_i),
  .wr_d_i    (pxl_data_i),
  .wr_en_i   (pxl_en_i  ),
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
  .FPS             (FPS            ) 
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

endmodule