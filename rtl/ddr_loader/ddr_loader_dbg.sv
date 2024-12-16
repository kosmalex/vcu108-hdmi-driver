`include "../utilities.svh"

module ddr_loader_dbg (
  input  logic             clk_i      ,
  input  logic             rst_n_i    ,
  input  logic             pixel_clk_i
);

`GEN_AXI_WIRE_WO(loader, 32,32, 4);

blk_mem_gen_0 blk_mem_gen_00 (
  .rsta_busy(),          // output wire rsta_busy
  .rstb_busy(),          // output wire rstb_busy
  .s_aclk(clk_i),                // input wire s_aclk
  .s_aresetn(rst_n_i),          // input wire s_aresetn

  `GEN_AXI_CON_BRAM(s, loader) //This may need to become WRITE ONLY
);

ddr_loader ddr_loader(.*);


endmodule