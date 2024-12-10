`timescale 1ns/1ns

module tb_nexys7_i2c_uart;

parameter SYS_CLK = 10;

parameter DIVIDER    = 126;
parameter START_HOLD = 35;
parameter STOP_HOLD  = 35;
parameter FREE_HOLD  = 75;
parameter DATA_HOLD  = 30;
parameter NBYTES     = 2;
parameter NTRANS     = 2;
parameter INIT_FILE  = "i2c_uart.mem";

logic clk_i   = 0;
logic rst_n_i = 1;
logic start_1cc_i = 1;

logic[NBYTES-1:0] status_o[NTRANS];

always begin
  #SYS_CLK clk_i = ~clk_i;
end

logic scl_o;
wire  sda_io;
logic sda_r_io;
logic is_read_s = 1;

logic led_en_i;
logic led_en_o;

logic tx;
logic rx;

logic done_o;

i2c_uart_subsystem #(
  .DIVIDER    (DIVIDER   ),
  .START_HOLD (START_HOLD),
  .STOP_HOLD  (STOP_HOLD ),
  .FREE_HOLD  (FREE_HOLD ),
  .DATA_HOLD  (DATA_HOLD ),
  .NBYTES     (NBYTES    ),
  .NTRANS     (NTRANS    ),
  .INIT_FILE  (INIT_FILE )
) dut (.*);

initial begin
  RESET;

end

task RESET();
  repeat(10) @(posedge clk_i);
  rst_n_i <= 0;
  repeat(5) @(posedge clk_i);
  rst_n_i <= 1;
  @(posedge clk_i);
endtask

endmodule