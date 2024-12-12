`include "utilities.svh"

module ddr4_controller (
  input  logic      sys_clk_i,
  input  logic      sys_clk_n_i,
  input  logic      clk_i,
  input  logic      rst_n_i,

  `GEN_AXI_SLV_IF(ddr4, 31, 64, 4),

  output wire[16:0] c0_ddr4_adr,
  output wire[1:0]  c0_ddr4_ba,
  output wire       c0_ddr4_cke,
  output wire       c0_ddr4_cs_n,
  inout  wire[8:0]  c0_ddr4_dm_dbi_n,
  inout  wire[71:0] c0_ddr4_dq,
  inout  wire[8:0]  c0_ddr4_dqs_c,
  inout  wire[8:0]  c0_ddr4_dqs_t,
  output wire       c0_ddr4_odt,
  output wire       c0_ddr4_bg,
  output wire       c0_ddr4_act_n,
  output wire       c0_ddr4_ck_c,
  output wire       c0_ddr4_ck_t,

  output wire       c0_init_calib_complete
);

logic ui_clk_s;
logic ui_rst_n_s, ui_rst_s;

`GEN_AXI_WIRE(m, 31, 64, 4);

cdc_mig_axi_fifo cdc_mig_axi_fifo_0 (
  .s_aclk         (clk_i         ), // input wire s_aclk
  .s_aresetn      (ui_rst_n_s    ), // input wire s_aresetn
  
  `GEN_AXI_CON    (ddr4          ),
  
  .m_aclk         (ui_clk_s      ), // input wire m_aclk
  .*
);

ddr4_mig ddr4_mig_0 (
  .c0_sys_clk_p               (sys_clk_i                 ), // input wire c0_sys_clk_p
  .c0_sys_clk_n               (sys_clk_n_i               ), // input wire c0_sys_clk_n
  .sys_rst                    (!rst_n_i                  ), // input wire sys_rst
  .c0_ddr4_reset_n            (rst_n_i                   ), // output wire c0_ddr4_reset_n
  .c0_ddr4_aresetn            (rst_n_i                   ), // input wire c0_ddr4_aresetn
  .c0_ddr4_interrupt          (/*Not connected*/         ), // output wire c0_ddr4_interrupt
  
  .c0_ddr4_ui_clk             (ui_clk_s                  ), // output wire c0_ddr4_ui_clk
  .c0_ddr4_ui_clk_sync_rst    (ui_rst_s                  ), // output wire c0_ddr4_ui_clk_sync_rst

  .c0_ddr4_s_axi_ctrl_awvalid (1'b0                      ), // input wire c0_ddr4_s_axi_ctrl_awvalid
  .c0_ddr4_s_axi_ctrl_awready (/*Not connected*/         ), // output wire c0_ddr4_s_axi_ctrl_awready
  .c0_ddr4_s_axi_ctrl_awaddr  (1'b0                      ), // input wire [31 : 0] c0_ddr4_s_axi_ctrl_awaddr
  .c0_ddr4_s_axi_ctrl_wvalid  (1'b0                      ), // input wire c0_ddr4_s_axi_ctrl_wvalid
  .c0_ddr4_s_axi_ctrl_wready  (/*Not connected*/         ), // output wire c0_ddr4_s_axi_ctrl_wready
  .c0_ddr4_s_axi_ctrl_wdata   (1'b0                      ), // input wire [31 : 0] c0_ddr4_s_axi_ctrl_wdata
  .c0_ddr4_s_axi_ctrl_bvalid  (/*Not connected*/         ), // output wire c0_ddr4_s_axi_ctrl_bvalid
  .c0_ddr4_s_axi_ctrl_bready  (1'b0                      ), // input wire c0_ddr4_s_axi_ctrl_bready
  .c0_ddr4_s_axi_ctrl_bresp   (/*Not connected*/         ), // output wire [1 : 0] c0_ddr4_s_axi_ctrl_bresp
  .c0_ddr4_s_axi_ctrl_arvalid (1'b0                      ), // input wire c0_ddr4_s_axi_ctrl_arvalid
  .c0_ddr4_s_axi_ctrl_arready (/*Not connected*/         ), // output wire c0_ddr4_s_axi_ctrl_arready
  .c0_ddr4_s_axi_ctrl_araddr  (1'b0                      ), // input wire [31 : 0] c0_ddr4_s_axi_ctrl_araddr
  .c0_ddr4_s_axi_ctrl_rvalid  (/*Not connected*/         ), // output wire c0_ddr4_s_axi_ctrl_rvalid
  .c0_ddr4_s_axi_ctrl_rready  (1'b0                      ), // input wire c0_ddr4_s_axi_ctrl_rready
  .c0_ddr4_s_axi_ctrl_rdata   (/*Not connected*/         ), // output wire [31 : 0] c0_ddr4_s_axi_ctrl_rdata
  .c0_ddr4_s_axi_ctrl_rresp   (/*Not connected*/         ), // output wire [1 : 0] c0_ddr4_s_axi_ctrl_rresp

  `GEN_AXI_CON (c0_ddr4_, s),
  // .c0_ddr4_s_axi_awid         (s_axi_awid        ), // input wire [3 : 0] c0_ddr4_s_axi_awid
  // .c0_ddr4_s_axi_awaddr       (s_axi_awaddr      ), // input wire [30 : 0] c0_ddr4_s_axi_awaddr
  // .c0_ddr4_s_axi_awlen        (s_axi_awlen       ), // input wire [7 : 0] c0_ddr4_s_axi_awlen
  // .c0_ddr4_s_axi_awsize       (s_axi_awsize      ), // input wire [2 : 0] c0_ddr4_s_axi_awsize
  // .c0_ddr4_s_axi_awburst      (s_axi_awburst     ), // input wire [1 : 0] c0_ddr4_s_axi_awburst
  // .c0_ddr4_s_axi_awlock       (s_axi_awlock      ), // input wire [0 : 0] c0_ddr4_s_axi_awlock
  // .c0_ddr4_s_axi_awcache      (s_axi_awcache     ), // input wire [3 : 0] c0_ddr4_s_axi_awcache
  // .c0_ddr4_s_axi_awprot       (s_axi_awprot      ), // input wire [2 : 0] c0_ddr4_s_axi_awprot
  // .c0_ddr4_s_axi_awqos        (s_axi_awqos       ), // input wire [3 : 0] c0_ddr4_s_axi_awqos
  // .c0_ddr4_s_axi_awvalid      (s_axi_awvalid     ), // input wire c0_ddr4_s_axi_awvalid
  // .c0_ddr4_s_axi_awready      (s_axi_awready     ), // output wire c0_ddr4_s_axi_awready
  // .c0_ddr4_s_axi_wdata        (s_axi_wdata       ), // input wire [63 : 0] c0_ddr4_s_axi_wdata
  // .c0_ddr4_s_axi_wstrb        (s_axi_wstrb       ), // input wire [7 : 0] c0_ddr4_s_axi_wstrb
  // .c0_ddr4_s_axi_wlast        (s_axi_wlast       ), // input wire c0_ddr4_s_axi_wlast
  // .c0_ddr4_s_axi_wvalid       (s_axi_wvalid      ), // input wire c0_ddr4_s_axi_wvalid
  // .c0_ddr4_s_axi_wready       (s_axi_wready      ), // output wire c0_ddr4_s_axi_wready
  // .c0_ddr4_s_axi_bready       (s_axi_bready      ), // input wire c0_ddr4_s_axi_bready
  // .c0_ddr4_s_axi_bid          (s_axi_bid         ), // output wire [3 : 0] c0_ddr4_s_axi_bid
  // .c0_ddr4_s_axi_bresp        (s_axi_bresp       ), // output wire [1 : 0] c0_ddr4_s_axi_bresp
  // .c0_ddr4_s_axi_bvalid       (s_axi_bvalid      ), // output wire c0_ddr4_s_axi_bvalid
  // .c0_ddr4_s_axi_arid         (s_axi_arid        ), // input wire [3 : 0] c0_ddr4_s_axi_arid
  // .c0_ddr4_s_axi_araddr       (s_axi_araddr      ), // input wire [30 : 0] c0_ddr4_s_axi_araddr
  // .c0_ddr4_s_axi_arlen        (s_axi_arlen       ), // input wire [7 : 0] c0_ddr4_s_axi_arlen
  // .c0_ddr4_s_axi_arsize       (s_axi_arsize      ), // input wire [2 : 0] c0_ddr4_s_axi_arsize
  // .c0_ddr4_s_axi_arburst      (s_axi_arburst     ), // input wire [1 : 0] c0_ddr4_s_axi_arburst
  // .c0_ddr4_s_axi_arlock       (s_axi_arlock      ), // input wire [0 : 0] c0_ddr4_s_axi_arlock
  // .c0_ddr4_s_axi_arcache      (s_axi_arcache     ), // input wire [3 : 0] c0_ddr4_s_axi_arcache
  // .c0_ddr4_s_axi_arprot       (s_axi_arprot      ), // input wire [2 : 0] c0_ddr4_s_axi_arprot
  // .c0_ddr4_s_axi_arqos        (s_axi_arqos       ), // input wire [3 : 0] c0_ddr4_s_axi_arqos
  // .c0_ddr4_s_axi_arvalid      (s_axi_arvalid     ), // input wire c0_ddr4_s_axi_arvalid
  // .c0_ddr4_s_axi_arready      (s_axi_arready     ), // output wire c0_ddr4_s_axi_arready
  // .c0_ddr4_s_axi_rready       (s_axi_rready      ), // input wire c0_ddr4_s_axi_rready
  // .c0_ddr4_s_axi_rlast        (s_axi_rlast       ), // output wire c0_ddr4_s_axi_rlast
  // .c0_ddr4_s_axi_rvalid       (s_axi_rvalid      ), // output wire c0_ddr4_s_axi_rvalid
  // .c0_ddr4_s_axi_rresp        (s_axi_rresp       ), // output wire [1 : 0] c0_ddr4_s_axi_rresp
  // .c0_ddr4_s_axi_rid          (s_axi_rid         ), // output wire [3 : 0] c0_ddr4_s_axi_rid
  // .c0_ddr4_s_axi_rdata        (s_axi_rdata       ), // output wire [63 : 0] c0_ddr4_s_axi_rdata

  .c0_ddr4_adr                (c0_ddr4_adr               ), // output wire [16 : 0] c0_ddr4_adr
  .c0_ddr4_ba                 (c0_ddr4_ba                ), // output wire [1 : 0] c0_ddr4_ba
  .c0_ddr4_cke                (c0_ddr4_cke               ), // output wire [0 : 0] c0_ddr4_cke
  .c0_ddr4_cs_n               (c0_ddr4_cs_n              ), // output wire [0 : 0] c0_ddr4_cs_n
  .c0_ddr4_dm_dbi_n           (c0_ddr4_dm_dbi_n          ), // inout wire [8 : 0] c0_ddr4_dm_dbi_n
  .c0_ddr4_dq                 (c0_ddr4_dq                ), // inout wire [71 : 0] c0_ddr4_dq
  .c0_ddr4_dqs_c              (c0_ddr4_dqs_c             ), // inout wire [8 : 0] c0_ddr4_dqs_c
  .c0_ddr4_dqs_t              (c0_ddr4_dqs_t             ), // inout wire [8 : 0] c0_ddr4_dqs_t
  .c0_ddr4_odt                (c0_ddr4_odt               ), // output wire [0 : 0] c0_ddr4_odt
  .c0_ddr4_bg                 (c0_ddr4_bg                ), // output wire [0 : 0] c0_ddr4_bg
  .c0_ddr4_act_n              (c0_ddr4_act_n             ), // output wire c0_ddr4_act_n
  .c0_ddr4_ck_c               (c0_ddr4_ck_c              ), // output wire [0 : 0] c0_ddr4_ck_c
  .c0_ddr4_ck_t               (c0_ddr4_ck_t              ), // output wire [0 : 0] c0_ddr4_ck_t

  .c0_init_calib_complete     (c0_init_calib_complete    ), // output wire c0_init_calib_complete
  .dbg_clk                    (/*Not connected*/         ), // output wire dbg_clk
  .dbg_bus                    (/*Not connected*/         )  // output wire [511 : 0] dbg_bus
);

always @(posedge ui_clk_s) begin : buf_rst 
  ui_rst_n_s <= ~ui_rst_s;
end

endmodule