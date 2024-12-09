`timescale 1ps/1ps

module tb_nexys7;
// Clocks
parameter SYS_CLK = 5000;
parameter PXL_CLK = 25175;

// HDMI generics
parameter ACTIVE_H_PIXELS = 640;//1280;
parameter H_FRONT_PORCH   = 16 ;//110 ;
parameter H_SYNC_WIDTH    = 96 ;//40  ;
parameter H_BACK_PORCH    = 48 ;//220 ;
parameter ACTIVE_LINES    = 480;//720 ;
parameter V_FRONT_PORCH   = 11 ;//5   ;
parameter V_SYNC_WIDTH    = 2  ;//5   ;
parameter V_BACK_PORCH    = 31 ;//20  ;
parameter FPS             = 30 ;//60  ;
parameter FRAME_X_SCALE   = 0  ;//0   ; // These are 2^{frame_scale}
parameter FRAME_Y_SCALE   = 0  ;//0   ; // These are 2^{frame_scale}


// I2C generics
parameter DIVIDER         = 50;
parameter START_HOLD      = 10;
parameter STOP_HOLD       = 10;
parameter FREE_HOLD       = 10;
parameter DATA_HOLD       = 5 ;
parameter NBYTES          = 3 ;
parameter NTRANS          = 41;

localparam FB_X         = ACTIVE_H_PIXELS >> FRAME_X_SCALE;
localparam FB_Y         = ACTIVE_LINES    >> FRAME_X_SCALE;
localparam FB_ADDR_BITS = $clog2(FB_X*FB_Y);

logic clk_i       = 0;
logic rst_n_i     = 1;
logic pixel_clk_i = 0;

logic[FB_ADDR_BITS-1:0] pxl_addr_i;
logic[23:0]             pxl_data_i;
logic                   pxl_en_i  ;

// HDMI
logic       vs_o; //vertical sync out
logic       hs_o; //horizontal sync out
logic       ad_o;
logic[15:0] hdmi_d_o;
logic[3:0]  red_o;
logic[3:0]  green_o;
logic[3:0]  blue_o;


// I2C or IIC
logic scl_o;
wire  sda_io;
logic i2c_done_o;

always begin
  #SYS_CLK clk_i = ~clk_i;
end

always begin
  #PXL_CLK pixel_clk_i = ~pixel_clk_i;
end

// hdmi_controller_ADV7511
// #(
//   .ACTIVE_H_PIXELS(ACTIVE_H_PIXELS),   
//   .H_FRONT_PORCH  (H_FRONT_PORCH  ),  
//   .H_SYNC_WIDTH   (H_SYNC_WIDTH   ), 
//   .H_BACK_PORCH   (H_BACK_PORCH   ),  
//   .ACTIVE_LINES   (ACTIVE_LINES   ),  
//   .V_FRONT_PORCH  (V_FRONT_PORCH  ),
//   .V_SYNC_WIDTH   (V_SYNC_WIDTH   ),
//   .V_BACK_PORCH   (V_BACK_PORCH   ), 
//   .FPS            (FPS            ),
//   .FRAME_X_SCALE  (FRAME_X_SCALE  ),
//   .FRAME_Y_SCALE  (FRAME_Y_SCALE  ),

//   .DIVIDER        (DIVIDER        ),
//   .START_HOLD     (START_HOLD     ),
//   .STOP_HOLD      (STOP_HOLD      ),
//   .FREE_HOLD      (FREE_HOLD      ),
//   .DATA_HOLD      (DATA_HOLD      ),
//   .NBYTES         (NBYTES         ),
//   .NTRANS         (NTRANS         )
// )
// dut (.*);

hdmi_wrapper_nexys7 dut(.*);

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