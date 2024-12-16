`include "./utilities.svh"

module SoC_vcu108_dbg (
  input  logic       sys_clk_i  ,
  input  logic       sys_clk_n_i,
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
  output logic GPIO_LED_1_LS
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

  //BTN
  // input logic GPIO_SW_E,
  // input logic GPIO_SW_W
);

// assign GPIO_LED_1_LS = GPIO_SW_E;

localparam NBYTES = 3;
localparam NTRANS = 41;
localparam PIXELS = 640 * 480;

logic rst_n_s;
logic clk_s, pixel_clk_s;
logic vs_s, hs_s;

logic done_s;

`GEN_AXI_WIRE_RO(hdmi, 32, 32, 4);
`GEN_AXI_WIRE_WO(loader, 32, 32, 4);
`GEN_AXI_WIRE   (s, 32, 64, 4);

clk_wiz_0 clk_gen (
  .clk_in1_p (sys_clk_i  ),
  .clk_in1_n (sys_clk_n_i),

  .clk_out1  (clk_s),
  .clk_out2  (pixel_clk_s)
);

// hdmi_controller_ADV7511
// #(
//   // HDMI generics
//   .ACTIVE_H_PIXELS(640 /*1280*/),
//   .H_FRONT_PORCH  (16  /*110 */),
//   .H_SYNC_WIDTH   (96  /*40  */),
//   .H_BACK_PORCH   (48  /*220 */),
//   .ACTIVE_LINES   (480 /*720 */),
//   .V_FRONT_PORCH  (11  /*5   */),
//   .V_SYNC_WIDTH   (2   /*5   */),
//   .V_BACK_PORCH   (31  /*20  */),
//   .Y_FILE         ("UY.mem" ),
//   .UV_FILE        ("VY.mem"),

//   .NBYTES        (NBYTES       ),
//   .NTRANS        (NTRANS       ),
//   .I2C_INIT_FILE ("i2c_rom.mem")
// )
// hdmi_controller_ADV7511_0(
//   .rst_n_i    (rst_n_s      ),
//   .clk_i      (clk_s        ),
//   .pixel_clk_i(pixel_clk_s  ),

//   .pxl_addr_i('d0),
//   .pxl_data_i('d0),
//   .pxl_en_i  ('d0),  

//   .vs_o       (HDMI_R_VSYNC ),
//   .hs_o       (HDMI_R_HSYNC ),
//   .ad_o       (HDMI_R_DE    ),
//   .hdmi_d_o   (HDMI_R_D     ),
//   .pixel_clk_o(HDMI_R_CLK   ),
  
//   .scl_o      (iic_scl_o    ),
//   .sda_io     (iic_sda_io   ),
//   .i2c_done_o (GPIO_LED_0_LS),
//   .i2c_mux_o  (iic_mux_o    )
// );

hdmi_driver
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
  .Y_FILE         ("init_fb.mem" ),
  .UV_FILE        ("VY.mem"),

  .NBYTES        (NBYTES       ),
  .NTRANS        (NTRANS       ),
  .I2C_INIT_FILE ("i2c_rom.mem")
)
hdmi_driver_0(
  .rst_n_i    (rst_n_s      ),
  .clk_i      (clk_s        ),
  .pixel_clk_i(pixel_clk_s  ),

  .start_i    (GPIO_LED_1_LS),

  .vs_o       (HDMI_R_VSYNC ),
  .hs_o       (HDMI_R_HSYNC ),
  .ad_o       (HDMI_R_DE    ),
  .hdmi_d_o   (HDMI_R_D     ),
  .pixel_clk_o(HDMI_R_CLK   ),
  
  .scl_o      (iic_scl_o    ),
  .sda_io     (iic_sda_io   ),
  .i2c_done_o (GPIO_LED_0_LS),
  .i2c_mux_o  (iic_mux_o    ),
  .*
);

ddr_loader #(
  .INIT_FILE("ddr_loader.mem")
)
ddr_loader_0(.rst_n_i(rst_n_s), .clk_i(clk_s), .done_o(GPIO_LED_1_LS), .*);

axi_interconnect axi_interconnect_0 (
  .INTERCONNECT_ACLK    (clk_s  ),        // input wire INTERCONNECT_ACLK
  .INTERCONNECT_ARESETN (rst_n_s),  // input wire INTERCONNECT_ARESETN
  
  .S00_AXI_ARESET_OUT_N (/*Not connected*/   ),
  .S00_AXI_ACLK         (clk_s               ),
  `GEN_AXI_ITERCON_CON_SFRO(S00, hdmi),

  .S01_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire S01_AXI_ARESET_OUT_N
  .S01_AXI_ACLK         (clk_s),                 // input wire S01_AXI_ACLK
  `GEN_AXI_ITERCON_CON_SFWO(S01, loader),

  .M00_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire M00_AXI_ARESET_OUT_N
  .M00_AXI_ACLK         (clk_s),                  // input wire M00_AXI_ACLK
  `GEN_AXI_ITERCON_CON(M00, s)
);

blk_mem_gen_0 ddr_dummy (
  .rsta_busy(),          // output wire rsta_busy
  .rstb_busy(),          // output wire rstb_busy
  .s_aclk(clk_s),                // input wire s_aclk
  .s_aresetn(rst_n_s),          // input wire s_aresetn
  .*
);

assign rst_n_s = !rst_i;
endmodule