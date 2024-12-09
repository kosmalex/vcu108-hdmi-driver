module hdmi_wrapper_nexys7 (
  input  logic                   clk_i      ,
  input  logic                   rst_n_i    ,

  // HDMI
  output logic                   vs_o    , //Vertical sync out
  output logic                   hs_o    , //Horizontal sync out
  output logic                   ad_o    ,

  output logic[3:0]              red_o,
  output logic[3:0]              green_o,
  output logic[3:0]              blue_o,

  // I2C or IIC
  output logic                   scl_o      ,
  inout  logic                   sda_io     ,
  output logic                   i2c_done_o
);

logic pixel_clk_s;
logic vs_s, hs_s;

logic[15:0] hdmi_d_s;

clk_wiz_0 clk_gen
(
  .clk_in1 (clk_i      ),
  .clk_out1(pixel_clk_s)
);

hdmi_controller_ADV7511
#(
  // HDMI generics
  .ACTIVE_H_PIXELS(640 ),
  .H_FRONT_PORCH  (16  ),
  .H_SYNC_WIDTH   (96  ),
  .H_BACK_PORCH   (48  ),
  .ACTIVE_LINES   (480 ),
  .V_FRONT_PORCH  (11  ),
  .V_SYNC_WIDTH   (2   ),
  .V_BACK_PORCH   (31  ),
  .FPS            (30  ),
  .FRAME_X_SCALE  (0   ), // These are 2^{frame_scale}
  .FRAME_Y_SCALE  (0   ), // These are 2^{frame_scale}

  // I2C generics
  .DIVIDER       (50           ),
  .START_HOLD    (10           ),
  .STOP_HOLD     (10           ),
  .FREE_HOLD     (10           ),
  .DATA_HOLD     (5            ),
  .NBYTES        (3            ),
  .NTRANS        (41           ),
  .I2C_INIT_FILE ("i2c_rom.mem")
)
hdmi_controller_ADV7511_0(
  .*,
  .clk_i      (pixel_clk_s),
  .pixel_clk_i(pixel_clk_s),

  .vs_o(vs_s),
  .hs_o(hs_s),

  .hdmi_d_o(hdmi_d_s),

  .pxl_addr_i(0)   ,
  .pxl_data_i(0)   ,
  .pxl_en_i  (1'b0) 
);

assign vs_o = ~vs_s;
assign hs_o = ~hs_s;

assign red_o   = hdmi_d_s[7:4];
assign green_o = hdmi_d_s[7:4];
assign blue_o  = hdmi_d_s[7:4];

endmodule