`include "utilities.svh"

module ddr4_controller (
  input  logic      c0_sys_clk_p,
  input  logic      c0_sys_clk_n,
  input  logic      clk_i,
  input  logic      rst_n_i,

  `GEN_AXI_SLV_IF(ddr4, 32, 64, 4),

  output logic[16:0] c0_ddr4_adr,
  output logic[1:0]  c0_ddr4_ba,
  output logic[0:0]  c0_ddr4_cke,
  output logic[0:0]  c0_ddr4_cs_n,
  inout  logic[7:0]  c0_ddr4_dm_dbi_n,
  inout  logic[63:0] c0_ddr4_dq,
  inout  logic[7:0]  c0_ddr4_dqs_c,
  inout  logic[7:0]  c0_ddr4_dqs_t,
  output logic[0:0]  c0_ddr4_odt,
  output logic[0:0]  c0_ddr4_bg,
  output logic       c0_ddr4_reset_n,
  output logic       c0_ddr4_act_n,
  output logic[0:0]  c0_ddr4_ck_c,
  output logic[0:0]  c0_ddr4_ck_t,

  output logic       c0_init_calib_complete
);

logic ui_clk_s;
logic ui_rst_n_s, ui_rst_s;

`GEN_AXI_WIRE(m, 31, 64, 4);

cdc_mig_axi_fifo cdc_mig_axi_fifo_0 (
  .s_aclk         (clk_i         ), // input wire s_aclk
  .s_aresetn      (ui_rst_n_s    ), // input wire s_aresetn
  
  `GEN_AXI_CON_QOS(s, ddr4       ),
  .s_axi_awregion       ('d0),
  .s_axi_arregion       ('d0),
  
  .m_aclk               (ui_clk_s      ), // input wire m_aclk
  .m_axi_awregion       (),
  .m_axi_arregion       (),
  .*
);

ddr4_0 ddr4_00 (
  .c0_sys_clk_p               (c0_sys_clk_p              ), // input wire c0_sys_clk_p
  .c0_sys_clk_n               (c0_sys_clk_n              ), // input wire c0_sys_clk_n
  .sys_rst                    (!rst_n_i                  ), // input wire sys_rst
  .c0_ddr4_aresetn            (rst_n_i                   ), // input wire c0_ddr4_aresetn
  .c0_ddr4_ui_clk             (ui_clk_s                  ), // output wire c0_ddr4_ui_clk
  .c0_ddr4_ui_clk_sync_rst    (ui_rst_s                  ), // output wire c0_ddr4_ui_clk_sync_rst
  .c0_init_calib_complete     (c0_init_calib_complete    ),

  .c0_ddr4_adr     (c0_ddr4_adr),      // output wire[16:0] c0_ddr4_adr,
  .c0_ddr4_ba      (c0_ddr4_ba),       // output wire[1:0]  c0_ddr4_ba,
  .c0_ddr4_cke     (c0_ddr4_cke),      // output wire[0:0]  c0_ddr4_cke,
  .c0_ddr4_cs_n    (c0_ddr4_cs_n),     // output wire[0:0]  c0_ddr4_cs_n,
  .c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n), // inout  wire[7:0]  c0_ddr4_dm_dbi_n,
  .c0_ddr4_dq      (c0_ddr4_dq),       // inout  wire[63:0] c0_ddr4_dq,
  .c0_ddr4_dqs_c   (c0_ddr4_dqs_c),    // inout  wire[7:0]  c0_ddr4_dqs_c,
  .c0_ddr4_dqs_t   (c0_ddr4_dqs_t),    // inout  wire[7:0]  c0_ddr4_dqs_t,
  .c0_ddr4_odt     (c0_ddr4_odt),      // output wire[0:0]  c0_ddr4_odt,
  .c0_ddr4_bg      (c0_ddr4_bg),       // output wire[0:0]  c0_ddr4_bg,
  .c0_ddr4_reset_n (c0_ddr4_reset_n),  // output wire       c0_ddr4_reset_n,
  .c0_ddr4_act_n   (c0_ddr4_act_n),    // output wire       c0_ddr4_act_n,
  .c0_ddr4_ck_c    (c0_ddr4_ck_c),     // output wire[0:0]  c0_ddr4_ck_c,
  .c0_ddr4_ck_t    (c0_ddr4_ck_t),     // output wire[0:0]  c0_ddr4_ck_t,

  `GEN_AXI_CON_QOS (c0_ddr4_s, m),

  .dbg_bus(),
  .dbg_clk()
);

always @(posedge ui_clk_s) begin : buf_rst 
  ui_rst_n_s <= ~ui_rst_s;
end

endmodule