`timescale 1ps/1ps

module tb_vcu108;
// Clocks
parameter SYS_CLK = 3333;

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
parameter DIVIDER         = 126;
parameter START_HOLD      = 35 ;
parameter STOP_HOLD       = 35 ;
parameter FREE_HOLD       = 75 ;
parameter DATA_HOLD       = 30 ;
parameter NBYTES          = 3  ;
parameter NTRANS          = 2  ;

localparam FB_X         = ACTIVE_H_PIXELS >> FRAME_X_SCALE;
localparam FB_Y         = ACTIVE_LINES    >> FRAME_X_SCALE;
localparam FB_ADDR_BITS = $clog2(FB_X*FB_Y);

logic       clk_i   = 0;
logic       clk_n_i = 1;
logic       rst_i   = 0;

// HDMI
logic       HDMI_R_CLK;
logic       HDMI_R_HSYNC;
logic       HDMI_R_VSYNC;
logic       HDMI_R_DE;
logic[15:0] HDMI_R_D;

// I2C or IIC
wire  iic_sda_io;
logic iic_scl_o;
logic iic_mux_o;
logic sel = 0;

assign iic_sda_io = sel ? 1'b0 : 1'bz;

// LEDs
logic GPIO_LED_0_LS;
logic GPIO_LED_1_LS;
logic GPIO_LED_2_LS;
logic GPIO_LED_3_LS;
logic GPIO_LED_4_LS;
logic GPIO_LED_5_LS;
logic GPIO_LED_6_LS;
logic GPIO_LED_7_LS;

always begin
  #SYS_CLK clk_i = ~clk_i;
end

always begin
  #SYS_CLK clk_n_i = ~clk_i;
end

always begin
  wait(iic_sda_io == 1'bz) begin
    #1 sel = 1'b1;
  end
  
  wait(iic_sda_io != 1'bz) begin 
            #1 sel = 1'b0;
    end
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

hdmi_wrapper_vcu108 dut(.*);

initial begin
  RESET;

end

task RESET();
  rst_i <= 1;
  repeat(3) @(posedge clk_i);
  rst_i <= 0;
  @(posedge clk_i);
endtask

endmodule