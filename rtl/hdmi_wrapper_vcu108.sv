module hdmi_wrapper_vcu108 (
  input  logic       clk_i  ,
  input  logic       clk_n_i,
  input  logic       rst_i,

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

  // LEDs
  output logic GPIO_LED_0_LS,
  output logic GPIO_LED_1_LS,
  output logic GPIO_LED_2_LS,
  output logic GPIO_LED_3_LS,
  output logic GPIO_LED_4_LS,
  output logic GPIO_LED_5_LS,
  output logic GPIO_LED_6_LS,
  output logic GPIO_LED_7_LS
);

localparam NBYTES = 3;
localparam NTRANS = 41;

logic[NBYTES-1:0] status_s[NTRANS];

logic rst_n_s;
logic clk_s, pixel_clk_s;
logic vs_s, hs_s;

clk_wiz_0 clk_gen (
  .clk_in1_p (clk_i  ),
  .clk_in1_n (clk_n_i),

  .clk_out1  (clk_s),
  .clk_out2  (pixel_clk_s)
);

hdmi_controller_ADV7511
#(
  // HDMI generics
  .ACTIVE_H_PIXELS(1280),
  .H_FRONT_PORCH  (110 ),
  .H_SYNC_WIDTH   (40  ),
  .H_BACK_PORCH   (220 ),
  .ACTIVE_LINES   (720 ),
  .V_FRONT_PORCH  (5   ),
  .V_SYNC_WIDTH   (5   ),
  .V_BACK_PORCH   (20  ),
  .FPS            (60  ),
  .FRAME_X_SCALE  (0   ), // These are 2^{frame_scale}
  .FRAME_Y_SCALE  (0   ), // These are 2^{frame_scale}

  // I2C generics
  .DIVIDER       (126          ),
  .START_HOLD    (35           ),
  .STOP_HOLD     (35           ),
  .FREE_HOLD     (75           ),
  .DATA_HOLD     (30           ),
  .NBYTES        (NBYTES       ),
  .NTRANS        (NTRANS       ),
  .I2C_INIT_FILE ("i2c_rom.mem")
)
hdmi_controller_ADV7511_0(
  .rst_n_i    (rst_n_s      ),
  .clk_i      (clk_s        ),
  .pixel_clk_i(pixel_clk_s  ),
  .vs_o       (vs_s         ),
  .hs_o       (hs_s         ),
  .ad_o       (HDMI_R_DE    ),
  .hdmi_d_o   (HDMI_R_D     ),
  .scl_o      (iic_scl_o    ),
  .sda_io     (iic_sda_io   ),
  .i2c_done_o (GPIO_LED_0_LS),
  .status_o   (status_s     ),

  .pxl_addr_i (0            ),
  .pxl_data_i (0            ),
  .pxl_en_i   (1'b0         )
);

assign HDMI_R_VSYNC = ~vs_s;
assign HDMI_R_HSYNC = ~hs_s;
assign HDMI_R_CLK   = pixel_clk_s;

assign iic_mux_o = 1'b1;

assign rst_n_s = !rst_i;

assign GPIO_LED_1_LS = 1'b0;
assign GPIO_LED_2_LS = status_s[0][0];
assign GPIO_LED_3_LS = status_s[0][1];
assign GPIO_LED_4_LS = status_s[0][2];
assign GPIO_LED_5_LS = status_s[1][0];
assign GPIO_LED_6_LS = status_s[1][1];
assign GPIO_LED_7_LS = status_s[1][2];
endmodule