`include "../utilities.svh"

module hdmi_driver_dbg (
  input  logic             clk_i      ,
  input  logic             rst_n_i    ,
  input  logic             pixel_clk_i,

  // HDMI
  output logic             vs_o       , //Vertical sync out
  output logic             hs_o       , //Horizontal sync out
  output logic             ad_o       ,
  output logic             pixel_clk_o,
  output logic[15:0]       hdmi_d_o   ,

  // I2C or IIC
  output logic             scl_o      ,
  inout  logic             sda_io     ,
  output logic             i2c_done_o ,
  output logic             i2c_mux_o  ,

  output logic             axictrl_done_o
);

`GEN_AXI_WIRE_RO(hdmi, 32,32, 4);

blk_mem_gen_0 blk_mem_gen_00 (
  .rsta_busy(),          // output wire rsta_busy
  .rstb_busy(),          // output wire rstb_busy
  .s_aclk(clk_i),                // input wire s_aclk
  .s_aresetn(rst_n_i),          // input wire s_aresetn

  `GEN_AXI_CON_BRAM(s, hdmi)
);

hdmi_driver hdmi_driver (
  
  .*
);

endmodule