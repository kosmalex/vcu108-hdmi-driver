`include "./utilities.svh"

module SoC_vcu108 (
  input  logic       sys_clk_i  ,
  input  logic       sys_clk_n_i,
  input  logic       rst_i,
  
  //DDR
//  input  logic       c0_sys_clk_n,
//  input  logic       c0_sys_clk_p,
//  output logic[16:0] c0_ddr4_adr,
//  output logic[1:0]  c0_ddr4_ba,
//  output logic[0:0]  c0_ddr4_cke,
//  output logic[0:0]  c0_ddr4_cs_n,
//  inout  logic[7:0]  c0_ddr4_dm_dbi_n,
//  inout  logic[63:0] c0_ddr4_dq,
//  inout  logic[7:0]  c0_ddr4_dqs_c,
//  inout  logic[7:0]  c0_ddr4_dqs_t,
//  output logic[0:0]  c0_ddr4_odt,
//  output logic[0:0]  c0_ddr4_bg,
//  output logic       c0_ddr4_reset_n,
//  output logic       c0_ddr4_act_n,
//  output logic[0:0]  c0_ddr4_ck_c,
//  output logic[0:0]  c0_ddr4_ck_t,

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
  output logic GPIO_LED_3_LS,
  output logic GPIO_LED_4_LS,
  output logic GPIO_LED_5_LS,
  output logic GPIO_LED_6_LS,
  output logic GPIO_LED_7_LS,
  
  //SW
  // input  logic GPIO_DIP_SW0,
  // input  logic GPIO_DIP_SW1,
  // input  logic GPIO_DIP_SW2,
  // input  logic GPIO_DIP_SW3

  //BTN
  input logic GPIO_SW_E,
  input logic GPIO_SW_W,
  input logic GPIO_SW_N,
  input logic GPIO_SW_S,
  input logic GPIO_SW_C
);

  // logic GPIO_LED_0_LS;
  // logic GPIO_LED_1_LS;

localparam NBYTES = 3;
localparam NTRANS = 41;
localparam PIXELS = 640 * 480;

logic rst_n_s;
logic clk_s, pixel_clk_s;
logic vs_s, hs_s;

logic done_s;

`GEN_AXI_WIRE_RO(hdmi, 32, 32, 4);
`GEN_AXI_WIRE_WO(loader, 32, 32, 4);
`GEN_AXI_WIRE   (ddr4, 32, 32, 4);

logic[4:0] pressed;

btn_detector btn_detector_0 (
  .clk_i    (clk_s),
  .rst_n_i  (rst_n_s),
  .btn_i    (GPIO_SW_N),
  .pressed_o( pressed[0]),
  .*
);
btn_detector btn_detector_1 (
  .clk_i    (clk_s),
  .rst_n_i  (rst_n_s),
  .btn_i    (GPIO_SW_S),
  .pressed_o(pressed[1]),
  .*
);
btn_detector btn_detector_2 (
  .clk_i    (clk_s),
  .rst_n_i  (rst_n_s),
  .btn_i    (GPIO_SW_W),
  .pressed_o(pressed[2]),
  .*
);
btn_detector btn_detector_3 (
  .clk_i    (clk_s),
  .rst_n_i  (rst_n_s),
  .btn_i    (GPIO_SW_E),
  .pressed_o(pressed[3]),
  .*
);
btn_detector btn_detector_4 (
  .clk_i    (clk_s),
  .rst_n_i  (rst_n_s),
  .btn_i    (GPIO_SW_C),
  .pressed_o(pressed[4]),
  .*
);

always_ff @(posedge clk_s) begin
  if (!rst_n_s) begin
    GPIO_LED_3_LS <= 'd0;
    GPIO_LED_4_LS <= 'd0;
    GPIO_LED_5_LS <= 'd0;
    GPIO_LED_6_LS <= 'd0;
    GPIO_LED_7_LS <= 'd0;
  end else begin
    case(1'b1)
      pressed[0]: GPIO_LED_3_LS <= ~GPIO_LED_3_LS;
      pressed[1]: GPIO_LED_4_LS <= ~GPIO_LED_4_LS;
      pressed[2]: GPIO_LED_5_LS <= ~GPIO_LED_5_LS;
      pressed[3]: GPIO_LED_6_LS <= ~GPIO_LED_6_LS;
      pressed[4]: GPIO_LED_7_LS <= ~GPIO_LED_7_LS;
    endcase
  end
end

// clk_wiz_0 clk_gen (
//   .clk_in1_p (sys_clk_i  ),
//   .clk_in1_n (sys_clk_n_i),

//   .clk_out1  (clk_s),
//   .clk_out2  (pixel_clk_s)
// );

// hdmi_driver
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
//   .Y_FILE         ("init_fb.mem" ),
//   .UV_FILE        ("init_fb.mem"),

//   .NBYTES        (NBYTES       ),
//   .NTRANS        (NTRANS       ),
//   .I2C_INIT_FILE ("i2c_rom.mem")
// )
// hdmi_driver_0(
//   .rst_n_i    (rst_n_s      ),
//   .clk_i      (clk_s        ),
//   .pixel_clk_i(pixel_clk_s  ),

//   .vs_o       (HDMI_R_VSYNC ),
//   .hs_o       (HDMI_R_HSYNC ),
//   .ad_o       (HDMI_R_DE    ),
//   .hdmi_d_o   (HDMI_R_D     ),
//   .pixel_clk_o(HDMI_R_CLK   ),
  
//   .scl_o      (iic_scl_o    ),
//   .sda_io     (iic_sda_io   ),
//   .i2c_done_o (GPIO_LED_0_LS),
//   .i2c_mux_o  (iic_mux_o    ),
//   .*
// );

// ddr_loader #(
//   .INIT_FILE("ddr_loader.mem")
// )
// ddr_loader_0(.rst_n_i(rst_n_s), .clk_i(clk_s), .done_o(GPIO_LED_1_LS), .*);

// axi_interconnect axi_interconnect_0 (
//   .INTERCONNECT_ACLK    (clk_s  ),        // input wire INTERCONNECT_ACLK
//   .INTERCONNECT_ARESETN (rst_n_s),  // input wire INTERCONNECT_ARESETN
  
//   .S00_AXI_ARESET_OUT_N (/*Not connected*/   ),
//   .S00_AXI_ACLK         (clk_s               ),
//   `GEN_AXI_ITERCON_CON_SFRO(S00, hdmi),

//   .S01_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire S01_AXI_ARESET_OUT_N
//   .S01_AXI_ACLK         (clk_s),                 // input wire S01_AXI_ACLK
//   `GEN_AXI_ITERCON_CON_SFWO(S01, loader),

//   .M00_AXI_ARESET_OUT_N (/*Not connected*/   ),  // output wire M00_AXI_ARESET_OUT_N
//   .M00_AXI_ACLK         (clk_s),                  // input wire M00_AXI_ACLK
//   `GEN_AXI_ITERCON_CON(M00, ddr4)
// );

// ddr4_controller ddr4_controller_0(
//   .clk_i       (clk_s  ),
//   .rst_n_i     (rst_n_s),

//   .c0_init_calib_complete(GPIO_LED_7_LS),
//   .*
// );



assign rst_n_s = !rst_i;
endmodule