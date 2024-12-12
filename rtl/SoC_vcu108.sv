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
  // output logic GPIO_LED_0_LS,
  // output logic GPIO_LED_1_LS,
  // output logic GPIO_LED_2_LS,
  // output logic GPIO_LED_3_LS,
  // output logic GPIO_LED_4_LS,
  // output logic GPIO_LED_5_LS,
  // output logic GPIO_LED_6_LS,
  // output logic GPIO_LED_7_LS
  
  //SW
  // input  logic GPIO_DIP_SW0,
  // input  logic GPIO_DIP_SW1,
  // input  logic GPIO_DIP_SW2,
  // input  logic GPIO_DIP_SW3
);

localparam NBYTES = 3;
localparam NTRANS = 41;
localparam PIXELS = 640 * 480;

logic rst_n_s;
logic clk_s, pixel_clk_s;
logic vs_s, hs_s;

logic done_s;

clk_wiz_0 clk_gen (
  .clk_in1_p (clk_i  ),
  .clk_in1_n (clk_n_i),

  .clk_out1  (clk_s),
  .clk_out2  (pixel_clk_s)
);



hdmi_controller_ADV7511_axi4
#(
  // HDMI generics
  .ACTIVE_H_PIXELS(640 /*1280*/),
  .H_FRONT_PORCH  (16  /*110 */),
  .H_SYNC_WIDTH   (96  /*40  */),
  .H_BACK_PORCH   (48  /*220 */),
  .ACTIVE_LINES   (480 /*720 */),
  .V_FRONT_PORCH  (11  /*5   */),
  .V_SYNC_WIDTH   (2   /*5   */),
  .V_BACK_PORCH   (31  /*20  */),
  .Y_FILE         ("Y_vga.mem" ),
  .UV_FILE        ("UV_vga.mem"),

  .NBYTES        (NBYTES       ),
  .NTRANS        (NTRANS       ),
  .I2C_INIT_FILE ("i2c_rom.mem")
)
hdmi_controller_ADV7511_axi4_0(
  .rst_n_i    (rst_n_s      ),
  .clk_i      (clk_s        ),
  .pixel_clk_i(pixel_clk_s  ),

  `include "hdmi_controller_ADV7511_axi4_con.svh"

  .vs_o       (HDMI_R_VSYNC ),
  .hs_o       (HDMI_R_HSYNC ),
  .ad_o       (HDMI_R_DE    ),
  .hdmi_d_o   (HDMI_R_D     ),
  .pixel_clk_o(HDMI_R_CLK   ),
  
  .scl_o      (iic_scl_o    ),
  .sda_io     (iic_sda_io   ),
  .i2c_done_o (GPIO_LED_0_LS),
  .i2c_mux_o  (iic_mux_o    ),
  .status_o   (status_s     )
);

axi_interconnect axi_interconnect_0 (
  .INTERCONNECT_ACLK    (clk_s  ),        // input wire INTERCONNECT_ACLK
  .INTERCONNECT_ARESETN (rst_n_s),  // input wire INTERCONNECT_ARESETN
  
  .S00_AXI_ARESET_OUT_N (/*Not connected*/   ),
  .S00_AXI_ACLK         (clk_s               ),
  `GEN_AXI_ITERCON_CON(S00, hdmi),

  .S01_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire S01_AXI_ARESET_OUT_N
  .S01_AXI_ACLK         (clk_s),                 // input wire S01_AXI_ACLK
  `GEN_AXI_ITERCON_CON(S01, bios),

  .M00_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire M00_AXI_ARESET_OUT_N
  .M00_AXI_ACLK         (clk_s),                  // input wire M00_AXI_ACLK
  `GEN_AXI_ITERCON_CON(M00, ddr4)
);

assign rst_n_s = !rst_i;
endmodule