`include "utilities.svh"

module tb_hdmi_drv_dbg_vcu108;

logic         clk_i       = 1;
logic         rst_n_i     = 0;
logic         pixel_clk_i = 1;

always begin
  #5ns clk_i = ~clk_i;
end

always begin
  #20ns pixel_clk_i = ~pixel_clk_i;
end

ddr_loader_dbg dut (.*);

initial begin
  RESET;

end

task RESET();
  repeat(30) @(posedge clk_i);
  rst_n_i <= 1;
  @(posedge clk_i);
endtask
endmodule