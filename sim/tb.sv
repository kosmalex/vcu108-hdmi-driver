`timescale 1ps/1ps

module tb;
// Clocks
parameter SYS_CLK = 200;
parameter PXL_CLK = 13500;

// HDMI generics
parameter ACTIVE_H_PIXELS = 1280;
parameter H_FRONT_PORCH   = 110 ;
parameter H_SYNC_WIDTH    = 40  ;
parameter H_BACK_PORCH    = 220 ;
parameter ACTIVE_LINES    = 720 ;
parameter V_FRONT_PORCH   = 5   ;
parameter V_SYNC_WIDTH    = 5   ;
parameter V_BACK_PORCH    = 20  ;
parameter FPS             = 60  ;

// I2C generics
parameter DIVIDER         = 50;
parameter START_HOLD      = 10;
parameter STOP_HOLD       = 10;
parameter FREE_HOLD       = 10;
parameter DATA_HOLD       = 5 ;
parameter NBYTES          = 3 ;
parameter NTRANS          = 10;

logic clk_i       = 0;
logic rst_n_i     = 1;
logic pixel_clk_i = 0;

// HDMI
logic vs_o; //vertical sync out
logic hs_o; //horizontal sync out
logic ad_o;
// I2C or IIC
logic scl_o;
wire  sda_io;

always begin
  #5ns clk_i       = ~clk_i;
  #5ns pixel_clk_i = ~pixel_clk_i;
end

hdmi_controller_ADV7511
#(
  .ACTIVE_H_PIXELS(ACTIVE_H_PIXELS),   
  .H_FRONT_PORCH  (H_FRONT_PORCH  ),  
  .H_SYNC_WIDTH   (H_SYNC_WIDTH   ), 
  .H_BACK_PORCH   (H_BACK_PORCH   ),  
  .ACTIVE_LINES   (ACTIVE_LINES   ),  
  .V_FRONT_PORCH  (V_FRONT_PORCH  ),
  .V_SYNC_WIDTH   (V_SYNC_WIDTH   ),
  .V_BACK_PORCH   (V_BACK_PORCH   ), 
  .FPS            (FPS            ),
  .DIVIDER        (DIVIDER        ),
  .START_HOLD     (START_HOLD     ),
  .STOP_HOLD      (STOP_HOLD      ),
  .FREE_HOLD      (FREE_HOLD      ),
  .DATA_HOLD      (DATA_HOLD      ),
  .NBYTES         (NBYTES         ),
  .NTRANS         (NTRANS         )
)
dut (.*);


initial begin
  RESET;

end

task RESET();
  rst_n_i <= 0;
  repeat(3) @(posedge clk_i);
  rst_n_i <= 1;
  @(posedge clk_i);
endtask

endmodule