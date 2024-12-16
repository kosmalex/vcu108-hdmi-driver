`timescale 1ns/1ps

`include "utilities.svh"

module tb_soc_vcu108;

logic         sys_clk_i       = 1;
logic         sys_clk_n_i       = 0;
logic         rst_i     = 1;
logic         pixel_clk_i = 1;

  //DDR
logic[16:0] c0_ddr4_adr;
logic[1:0]  c0_ddr4_ba;
logic       c0_ddr4_cke;
logic       c0_ddr4_cs_n;
logic[8:0]  c0_ddr4_dm_dbi_n;
logic[71:0] c0_ddr4_dq;
logic[8:0]  c0_ddr4_dqs_c;
logic[8:0]  c0_ddr4_dqs_t;
logic       c0_ddr4_odt;
logic       c0_ddr4_bg;
logic       c0_ddr4_act_n;
logic       c0_ddr4_ck_c;
logic       c0_ddr4_ck_t;

// HDMI
logic       HDMI_R_CLK; //pixel_clk
logic       HDMI_R_HSYNC;
logic       HDMI_R_VSYNC;
logic       HDMI_R_DE; //active video
logic[15:0] HDMI_R_D;

// I2C or IIC
wire  iic_sda_io;
logic iic_scl_o;
logic iic_mux_o;

// LEDs
logic GPIO_LED_0_LS;
logic GPIO_LED_1_LS;

logic GPIO_SW_E;
logic GPIO_SW_W;

always begin
  #1.67ns sys_clk_i = ~sys_clk_i;
end

always begin
  #1.67ns sys_clk_n_i = ~sys_clk_i;
end


always begin
  #20ns pixel_clk_i = ~pixel_clk_i;
end

SoC_vcu108_dbg dut (.*);

initial begin
  RESET;

end

task RESET();
  repeat(30) @(posedge dut.clk_s);
  rst_i <= 0;
  @(posedge dut.clk_s);
endtask
endmodule