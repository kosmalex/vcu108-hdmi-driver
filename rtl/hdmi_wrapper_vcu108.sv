module hdmi_wrapper_vcu108 (
  input  logic       clk_i  ,
  input  logic       clk_n_i,
  input  logic       rst_n_i,

  // HDMI
  output logic       HDMI_R_CLK, //pixel_clk
  output logic       HDMI_R_HSYNC,
  output logic       HDMI_R_VSYNC,
  output logic       HDMI_R_DE, //active video
  output logic[15:0] HDMI_R_D,
  
  // I2C or IIC
  inout  logic iic_sda_io,
  output logic iic_scl_o,
  output logic iic_mux_o,
  output logic GPIO_LED_0_LS
);

logic clk_s, pixel_clk_s;
logic vs_s, hs_s;

clk_wiz_0 clk_gen (
  .clk_in1_p (clk_i  ),
  .clk_in1_n (clk_n_i),

  .clk_out1  (clk_s  )
);

clk_divider #(
  .DIVIDER (4)
)
clk_divider_0(
  .clk_i   (clk_s),
  .hold_i  (1'b0),
  .reset_i (1'b0),
  .clk_o   (pixel_clk_s)
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
  .clk_i      (clk_s        ),
  .pixel_clk_i(pixel_clk_s  ),
  .vs_o       (vs_s         ),
  .hs_o       (hs_s         ),
  .ad_o       (HDMI_R_DE    ),
  .hdmi_d_o   (HDMI_R_D     ),
  .scl_o      (iic_scl_o    ),
  .sda_io     (iic_sda_io   ),
  .i2c_done_o (GPIO_LED_0_LS),

  .pxl_addr_i (0            ),
  .pxl_data_i (0            ),
  .pxl_en_i   (1'b0         )
);

assign HDMI_R_VSYNC = ~vs_s;
assign HDMI_R_HSYNC = ~hs_s;
assign HDMI_R_CLK   = pixel_clk_s;

assign iic_mux_o = 1'b1;
endmodule