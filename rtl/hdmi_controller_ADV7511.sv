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

  // I2C generics
  parameter DIVIDER         = 50  ,
  parameter START_HOLD      = 10  ,
  parameter STOP_HOLD       = 10  ,
  parameter FREE_HOLD       = 10  ,
  parameter DATA_HOLD       = 5   ,
  parameter NBYTES          = 3   ,
  parameter NTRANS          = 1   ,
  parameter INIT_FILE       = "i2c_rom.mem"
)(
  input  logic                 clk_i      ,
  input  logic                 rst_n_i    ,
  input  logic                 pixel_clk_i,

  // HDMI
  output logic                 vs_o       , //vertical sync out
  output logic                 hs_o       , //horizontal sync out
  output logic                 ad_o       ,
  // I2C or IIC
  output logic                 scl_o      ,
  inout  logic                 sda_io
);

logic start_1cc_i;
assign start_1cc_i = 1;

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

  .hcount_o (/*Unconnected*/),
  .vcount_o (/*Unconnected*/),
  .nf_o     (/*Unconnected*/),
  .fc_o     (/*Unconnected*/) 
);

i2c_controller
#(
  .DIVIDER    (DIVIDER   ),
  .START_HOLD (START_HOLD),
  .STOP_HOLD  (STOP_HOLD ),
  .FREE_HOLD  (FREE_HOLD ),
  .DATA_HOLD  (DATA_HOLD ),
  .NBYTES     (NBYTES    ),
  .NTRANS     (NTRANS    ),
  .INIT_FILE  (INIT_FILE )
)
i2c_controller (.*);

endmodule