# SYS_CLK_1
#set_property -dict {PACKAGE_PIN G31 IOSTANDARD DIFF_SSTL12} [ get_ports "c0_sys_clk_p" ]
#set_property -dict {PACKAGE_PIN F31 IOSTANDARD DIFF_SSTL12} [ get_ports "c0_sys_clk_n"]

# SYS_CLK_2
set_property -dict {PACKAGE_PIN G22 IOSTANDARD DIFF_SSTL12} [ get_ports "sys_clk_i" ]
set_property -dict {PACKAGE_PIN G21 IOSTANDARD DIFF_SSTL12} [ get_ports "sys_clk_n_i"]

# set_property -dict {PACKAGE_PIN AW31 IOSTANDARD DIFF_SSTL12} [ get_ports "c0_sys_clk_p" ]
# set_property -dict {PACKAGE_PIN AW32 IOSTANDARD DIFF_SSTL12} [ get_ports "c0_sys_clk_n" ]

set_property -dict {PACKAGE_PIN E36 IOSTANDARD LVCMOS12}    [get_ports "rst_i"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_T1U_N12_49

# set_property -dict {PACKAGE_PIN AT32 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_0_LS"] ;# Bank  44 VCCO - VCC1V2_FPGA - IO_L19N_T3L_N1_DBC_AD9N_44
# set_property -dict {PACKAGE_PIN AV34 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_1_LS"] ;# Bank  44 VCCO - VCC1V2_FPGA - IO_T2U_N12_44
# set_property -dict {PACKAGE_PIN AY30 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_2_LS"] ;# Bank  44 VCCO - VCC1V2_FPGA - IO_T1U_N12_44
set_property -dict {PACKAGE_PIN BB32 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_3_LS"] ;# Bank  44 VCCO - VCC1V2_FPGA - IO_L7N_T1L_N1_QBC_AD13N_44
set_property -dict {PACKAGE_PIN BF32 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_4_LS"] ;# Bank  44 VCCO - VCC1V2_FPGA - IO_L1N_T0L_N1_DBC_44
set_property -dict {PACKAGE_PIN AV36 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_5_LS"] ;# Bank  46 VCCO - VCC1V2_FPGA - IO_L19N_T3L_N1_DBC_AD9N_46
set_property -dict {PACKAGE_PIN AY35 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_6_LS"] ;# Bank  46 VCCO - VCC1V2_FPGA - IO_T2U_N12_46
set_property -dict {PACKAGE_PIN BA37 IOSTANDARD LVCMOS12} [get_ports "GPIO_LED_7_LS"] ;# Bank  46 VCCO - VCC1V2_FPGA - IO_L13N_T2L_N1_GC_QBC_46

# set_property PACKAGE_PIN BC40     [get_ports "GPIO_DIP_SW0"] ;# Bank  46 VCCO - VCC1V2_FPGA - IO_T1U_N12_46
# set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_DIP_SW0"] ;# Bank  46 VCCO - VCC1V2_FPGA - IO_T1U_N12_46
# set_property PACKAGE_PIN C37      [get_ports "GPIO_DIP_SW2"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_L19N_T3L_N1_DBC_AD9N_49
# set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_DIP_SW2"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_L19N_T3L_N1_DBC_AD9N_49
# set_property PACKAGE_PIN C38      [get_ports "GPIO_DIP_SW3"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_T2U_N12_49
# set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_DIP_SW3"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_T2U_N12_49
# set_property PACKAGE_PIN L19      [get_ports "GPIO_DIP_SW1"] ;# Bank  71 VCCO - VCC1V2_FPGA - IO_T1U_N12_71
# set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_DIP_SW1"] ;# Bank  71 VCCO - VCC1V2_FPGA - IO_T1U_N12_71

set_property PACKAGE_PIN AW27     [get_ports "GPIO_SW_C"] ;# Bank  45 VCCO - VCC1V2_FPGA - IO_L13N_T2L_N1_GC_QBC_45
set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_SW_C"] ;# Bank  45 VCCO - VCC1V2_FPGA - IO_L13N_T2L_N1_GC_QBC_45
set_property PACKAGE_PIN E34      [get_ports "GPIO_SW_N"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_L7N_T1L_N1_QBC_AD13N_49
set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_SW_N"] ;# Bank  49 VCCO - VCC1V2_FPGA - IO_L7N_T1L_N1_QBC_AD13N_49
set_property PACKAGE_PIN A10      [get_ports "GPIO_SW_E"] ;# Bank  69 VCCO - VCC1V2_FPGA - IO_T1U_N12_69
set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_SW_E"] ;# Bank  69 VCCO - VCC1V2_FPGA - IO_T1U_N12_69
set_property PACKAGE_PIN D9       [get_ports "GPIO_SW_S"] ;# Bank  69 VCCO - VCC1V2_FPGA - IO_L6N_T0U_N11_AD6N_69
set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_SW_S"] ;# Bank  69 VCCO - VCC1V2_FPGA - IO_L6N_T0U_N11_AD6N_69
set_property PACKAGE_PIN M22      [get_ports "GPIO_SW_W"] ;# Bank  70 VCCO - VCC1V2_FPGA - IO_L4N_T0U_N7_DBC_AD7N_70
set_property IOSTANDARD  LVCMOS12 [get_ports "GPIO_SW_W"] ;# Bank  70 VCCO - VCC1V2_FPGA - IO_L4N_T0U_N7_DBC_AD7N_70


set_property PACKAGE_PIN AM23     [get_ports "iic_mux_o"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L22P_T3U_N6_DBC_AD0P_84
set_property IOSTANDARD  LVCMOS18 [get_ports "iic_mux_o"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L22P_T3U_N6_DBC_AD0P_84
set_property PACKAGE_PIN AN21     [get_ports "iic_scl_o"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L21P_T3L_N4_AD8P_84
set_property IOSTANDARD  LVCMOS18 [get_ports "iic_scl_o"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L21P_T3L_N4_AD8P_84
set_property PACKAGE_PIN AP21     [get_ports "iic_sda_io"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L21N_T3L_N5_AD8N_84
set_property IOSTANDARD  LVCMOS18 [get_ports "iic_sda_io"] ;# Bank  84 VCCO - VCC1V8_FPGA - IO_L21N_T3L_N5_AD8N_84


#set_property PACKAGE_PIN AJ35     [get_ports "HDMI_R_SPDIF"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L20P_T3L_N2_AD1P_47
#set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_SPDIF"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L20P_T3L_N2_AD1P_47
#set_property PACKAGE_PIN AJ36     [get_ports "HDMI_SPDIF_OUT_LS"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L20N_T3L_N3_AD1N_47
#set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_SPDIF_OUT_LS"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L20N_T3L_N3_AD1N_47
#set_property PACKAGE_PIN AJ33     [get_ports "HDMI_INT"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L19P_T3L_N0_DBC_AD9P_47
#set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_INT"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L19P_T3L_N0_DBC_AD9P_47

set_property PACKAGE_PIN AK33     [get_ports "HDMI_R_CLK"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L19N_T3L_N1_DBC_AD9N_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_CLK"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L19N_T3L_N1_DBC_AD9N_47
set_property PACKAGE_PIN AK29     [get_ports "HDMI_R_HSYNC"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L18P_T2U_N10_AD2P_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_HSYNC"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L18P_T2U_N10_AD2P_47
set_property PACKAGE_PIN AK30     [get_ports "HDMI_R_VSYNC"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L18N_T2U_N11_AD2N_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_VSYNC"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L18N_T2U_N11_AD2N_47
set_property PACKAGE_PIN AH34     [get_ports "HDMI_R_DE"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L21N_T3L_N5_AD8N_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_DE"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L21N_T3L_N5_AD8N_47
set_property PACKAGE_PIN R36      [get_ports "HDMI_R_D[0]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_T2U_N12_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[0]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_T2U_N12_48
set_property PACKAGE_PIN R34      [get_ports "HDMI_R_D[1]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L13P_T2L_N0_GC_QBC_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[1]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L13P_T2L_N0_GC_QBC_48
set_property PACKAGE_PIN P34      [get_ports "HDMI_R_D[2]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L13N_T2L_N1_GC_QBC_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[2]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L13N_T2L_N1_GC_QBC_48
set_property PACKAGE_PIN V30      [get_ports "HDMI_R_D[3]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_T1U_N12_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[3]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_T1U_N12_48
set_property PACKAGE_PIN V33      [get_ports "HDMI_R_D[4]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L5P_T0U_N8_AD14P_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[4]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L5P_T0U_N8_AD14P_48
set_property PACKAGE_PIN V34      [get_ports "HDMI_R_D[5]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L5N_T0U_N9_AD14N_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[5]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L5N_T0U_N9_AD14N_48
set_property PACKAGE_PIN U35      [get_ports "HDMI_R_D[6]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L4P_T0U_N6_DBC_AD7P_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[6]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L4P_T0U_N6_DBC_AD7P_48
set_property PACKAGE_PIN T36      [get_ports "HDMI_R_D[7]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L4N_T0U_N7_DBC_AD7N_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[7]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L4N_T0U_N7_DBC_AD7N_48
set_property PACKAGE_PIN Y34      [get_ports "HDMI_R_D[8]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L3P_T0L_N4_AD15P_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[8]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L3P_T0L_N4_AD15P_48
set_property PACKAGE_PIN W34      [get_ports "HDMI_R_D[9]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L3N_T0L_N5_AD15N_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[9]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L3N_T0L_N5_AD15N_48
set_property PACKAGE_PIN V32      [get_ports "HDMI_R_D[10]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L2P_T0L_N2_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[10]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L2P_T0L_N2_48
set_property PACKAGE_PIN U33      [get_ports "HDMI_R_D[11]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L2N_T0L_N3_48
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[11]"] ;# Bank  48 VCCO - VADJ_1V8_FPGA - IO_L2N_T0L_N3_48
set_property PACKAGE_PIN AH33     [get_ports "HDMI_R_D[12]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L21P_T3L_N4_AD8P_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[12]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L21P_T3L_N4_AD8P_47
set_property PACKAGE_PIN AH30     [get_ports "HDMI_R_D[13]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T3U_N12_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[13]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T3U_N12_47
set_property PACKAGE_PIN AM33     [get_ports "HDMI_R_D[14]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L12P_T1U_N10_GC_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[14]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L12P_T1U_N10_GC_47
set_property PACKAGE_PIN AM31     [get_ports "HDMI_R_D[15]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T2U_N12_47
set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[15]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T2U_N12_47
# set_property PACKAGE_PIN AM34     [get_ports "HDMI_R_D[16]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L12N_T1U_N11_GC_47
# set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[16]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_L12N_T1U_N11_GC_47
# set_property PACKAGE_PIN AK35     [get_ports "HDMI_R_D[17]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T1U_N12_47
# set_property IOSTANDARD  LVCMOS18 [get_ports "HDMI_R_D[17]"] ;# Bank  47 VCCO - VADJ_1V8_FPGA - IO_T1U_N12_47

# set_property PACKAGE_PIN E33      [get_ports "c0_ddr4_act_n"] ;
# set_property PACKAGE_PIN C30      [get_ports "c0_ddr4_adr[0]"] ;
# set_property PACKAGE_PIN A31      [get_ports "c0_ddr4_adr[10]"] ;
# set_property PACKAGE_PIN A33      [get_ports "c0_ddr4_adr[11]"] ;
# set_property PACKAGE_PIN F29      [get_ports "c0_ddr4_adr[12]"] ;
# set_property PACKAGE_PIN B32      [get_ports "c0_ddr4_adr[13]"] ;
# set_property PACKAGE_PIN D29      [get_ports "c0_ddr4_adr[14]"] ;
# set_property PACKAGE_PIN B31      [get_ports "c0_ddr4_adr[15]"] ;
# set_property PACKAGE_PIN B33      [get_ports "c0_ddr4_adr[16]"] ;
# set_property PACKAGE_PIN D32      [get_ports "c0_ddr4_adr[1]"] ;
# set_property PACKAGE_PIN B30      [get_ports "c0_ddr4_adr[2]"] ;
# set_property PACKAGE_PIN C33      [get_ports "c0_ddr4_adr[3]"] ;
# set_property PACKAGE_PIN E32      [get_ports "c0_ddr4_adr[4]"] ;
# set_property PACKAGE_PIN A29      [get_ports "c0_ddr4_adr[5]"] ;
# set_property PACKAGE_PIN C29      [get_ports "c0_ddr4_adr[6]"] ;
# set_property PACKAGE_PIN E29      [get_ports "c0_ddr4_adr[7]"] ;
# set_property PACKAGE_PIN A30      [get_ports "c0_ddr4_adr[8]"] ;
# set_property PACKAGE_PIN C32      [get_ports "c0_ddr4_adr[9]"] ;
# set_property PACKAGE_PIN G30      [get_ports "c0_ddr4_ba[0]"] ;
# set_property PACKAGE_PIN F30      [get_ports "c0_ddr4_ba[1]"] ;
# set_property PACKAGE_PIN F33      [get_ports "c0_ddr4_bg[0]"] ;
# set_property PACKAGE_PIN D31      [get_ports "c0_ddr4_ck_c[0]"] ;
# set_property PACKAGE_PIN E31      [get_ports "c0_ddr4_ck_t[0]"] ;
# set_property PACKAGE_PIN K29      [get_ports "c0_ddr4_cke[0]"] ;
# set_property PACKAGE_PIN D30      [get_ports "c0_ddr4_cs_n[0]"] ;
# set_property PACKAGE_PIN J39      [get_ports "c0_ddr4_dm_dbi_n[0]"] ;
# set_property PACKAGE_PIN F34      [get_ports "c0_ddr4_dm_dbi_n[1]"] ;
# set_property PACKAGE_PIN E39      [get_ports "c0_ddr4_dm_dbi_n[2]"] ;
# set_property PACKAGE_PIN D37      [get_ports "c0_ddr4_dm_dbi_n[3]"] ;
# set_property PACKAGE_PIN T26      [get_ports "c0_ddr4_dm_dbi_n[4]"] ;
# set_property PACKAGE_PIN M27      [get_ports "c0_ddr4_dm_dbi_n[5]"] ;
# set_property PACKAGE_PIN G26      [get_ports "c0_ddr4_dm_dbi_n[6]"] ;
# set_property PACKAGE_PIN D27      [get_ports "c0_ddr4_dm_dbi_n[7]"] ;
# #set_property PACKAGE_PIN R28      [get_ports "c0_ddr4_dm_dbi_n[8]"] ;
# #set_property PACKAGE_PIN K31      [get_ports "c0_ddr4_dm_dbi_n[9]"] ;
# set_property PACKAGE_PIN J37      [get_ports "c0_ddr4_dq[0]"] ;
# set_property PACKAGE_PIN F35      [get_ports "c0_ddr4_dq[10]"] ;
# set_property PACKAGE_PIN J35      [get_ports "c0_ddr4_dq[11]"] ;
# set_property PACKAGE_PIN G37      [get_ports "c0_ddr4_dq[12]"] ;
# set_property PACKAGE_PIN H35      [get_ports "c0_ddr4_dq[13]"] ;
# set_property PACKAGE_PIN G36      [get_ports "c0_ddr4_dq[14]"] ;
# set_property PACKAGE_PIN H37      [get_ports "c0_ddr4_dq[15]"] ;
# set_property PACKAGE_PIN C39      [get_ports "c0_ddr4_dq[16]"] ;
# set_property PACKAGE_PIN A38      [get_ports "c0_ddr4_dq[17]"] ;
# set_property PACKAGE_PIN B40      [get_ports "c0_ddr4_dq[18]"] ;
# set_property PACKAGE_PIN D40      [get_ports "c0_ddr4_dq[19]"] ;
# set_property PACKAGE_PIN H40      [get_ports "c0_ddr4_dq[1]"] ;
# set_property PACKAGE_PIN E38      [get_ports "c0_ddr4_dq[20]"] ;
# set_property PACKAGE_PIN B38      [get_ports "c0_ddr4_dq[21]"] ;
# set_property PACKAGE_PIN E37      [get_ports "c0_ddr4_dq[22]"] ;
# set_property PACKAGE_PIN C40      [get_ports "c0_ddr4_dq[23]"] ;
# set_property PACKAGE_PIN C34      [get_ports "c0_ddr4_dq[24]"] ;
# set_property PACKAGE_PIN A34      [get_ports "c0_ddr4_dq[25]"] ;
# set_property PACKAGE_PIN D34      [get_ports "c0_ddr4_dq[26]"] ;
# set_property PACKAGE_PIN A35      [get_ports "c0_ddr4_dq[27]"] ;
# set_property PACKAGE_PIN A36      [get_ports "c0_ddr4_dq[28]"] ;
# set_property PACKAGE_PIN C35      [get_ports "c0_ddr4_dq[29]"] ;
# set_property PACKAGE_PIN F38      [get_ports "c0_ddr4_dq[2]"] ;
# set_property PACKAGE_PIN B35      [get_ports "c0_ddr4_dq[30]"] ;
# set_property PACKAGE_PIN D35      [get_ports "c0_ddr4_dq[31]"] ;
# set_property PACKAGE_PIN N27      [get_ports "c0_ddr4_dq[32]"] ;
# set_property PACKAGE_PIN R27      [get_ports "c0_ddr4_dq[33]"] ;
# set_property PACKAGE_PIN N24      [get_ports "c0_ddr4_dq[34]"] ;
# set_property PACKAGE_PIN R24      [get_ports "c0_ddr4_dq[35]"] ;
# set_property PACKAGE_PIN P24      [get_ports "c0_ddr4_dq[36]"] ;
# set_property PACKAGE_PIN P26      [get_ports "c0_ddr4_dq[37]"] ;
# set_property PACKAGE_PIN P27      [get_ports "c0_ddr4_dq[38]"] ;
# set_property PACKAGE_PIN T24      [get_ports "c0_ddr4_dq[39]"] ;
# set_property PACKAGE_PIN H39      [get_ports "c0_ddr4_dq[3]"] ;
# set_property PACKAGE_PIN K27      [get_ports "c0_ddr4_dq[40]"] ;
# set_property PACKAGE_PIN L26      [get_ports "c0_ddr4_dq[41]"] ;
# set_property PACKAGE_PIN J27      [get_ports "c0_ddr4_dq[42]"] ;
# set_property PACKAGE_PIN K28      [get_ports "c0_ddr4_dq[43]"] ;
# set_property PACKAGE_PIN K26      [get_ports "c0_ddr4_dq[44]"] ;
# set_property PACKAGE_PIN M25      [get_ports "c0_ddr4_dq[45]"] ;
# set_property PACKAGE_PIN J26      [get_ports "c0_ddr4_dq[46]"] ;
# set_property PACKAGE_PIN L28      [get_ports "c0_ddr4_dq[47]"] ;
# set_property PACKAGE_PIN E27      [get_ports "c0_ddr4_dq[48]"] ;
# set_property PACKAGE_PIN E28      [get_ports "c0_ddr4_dq[49]"] ;
# set_property PACKAGE_PIN K37      [get_ports "c0_ddr4_dq[4]"] ;
# set_property PACKAGE_PIN E26      [get_ports "c0_ddr4_dq[50]"] ;
# set_property PACKAGE_PIN H27      [get_ports "c0_ddr4_dq[51]"] ;
# set_property PACKAGE_PIN F25      [get_ports "c0_ddr4_dq[52]"] ;
# set_property PACKAGE_PIN F28      [get_ports "c0_ddr4_dq[53]"] ;
# set_property PACKAGE_PIN G25      [get_ports "c0_ddr4_dq[54]"] ;
# set_property PACKAGE_PIN G27      [get_ports "c0_ddr4_dq[55]"] ;
# set_property PACKAGE_PIN B28      [get_ports "c0_ddr4_dq[56]"] ;
# set_property PACKAGE_PIN A28      [get_ports "c0_ddr4_dq[57]"] ;
# set_property PACKAGE_PIN B25      [get_ports "c0_ddr4_dq[58]"] ;
# set_property PACKAGE_PIN B27      [get_ports "c0_ddr4_dq[59]"] ;
# set_property PACKAGE_PIN G40      [get_ports "c0_ddr4_dq[5]"] ;
# set_property PACKAGE_PIN D25      [get_ports "c0_ddr4_dq[60]"] ;
# set_property PACKAGE_PIN C27      [get_ports "c0_ddr4_dq[61]"] ;
# set_property PACKAGE_PIN C25      [get_ports "c0_ddr4_dq[62]"] ;
# set_property PACKAGE_PIN D26      [get_ports "c0_ddr4_dq[63]"] ;
# # set_property PACKAGE_PIN N29      [get_ports "c0_ddr4_dq[64]"] ;
# # set_property PACKAGE_PIN M31      [get_ports "c0_ddr4_dq[65]"] ;
# # set_property PACKAGE_PIN P29      [get_ports "c0_ddr4_dq[66]"] ;
# # set_property PACKAGE_PIN L29      [get_ports "c0_ddr4_dq[67]"] ;
# # set_property PACKAGE_PIN P30      [get_ports "c0_ddr4_dq[68]"] ;
# # set_property PACKAGE_PIN N28      [get_ports "c0_ddr4_dq[69]"] ;
# set_property PACKAGE_PIN F39      [get_ports "c0_ddr4_dq[6]"] ;
# # set_property PACKAGE_PIN L31      [get_ports "c0_ddr4_dq[70]"] ;
# # set_property PACKAGE_PIN L30      [get_ports "c0_ddr4_dq[71]"] ;
# # set_property PACKAGE_PIN H30      [get_ports "c0_ddr4_dq[72]"] ;
# # set_property PACKAGE_PIN J32      [get_ports "c0_ddr4_dq[73]"] ;
# # set_property PACKAGE_PIN H29      [get_ports "c0_ddr4_dq[74]"] ;
# # set_property PACKAGE_PIN H32      [get_ports "c0_ddr4_dq[75]"] ;
# # set_property PACKAGE_PIN J29      [get_ports "c0_ddr4_dq[76]"] ;
# # set_property PACKAGE_PIN K32      [get_ports "c0_ddr4_dq[77]"] ;
# # set_property PACKAGE_PIN J30      [get_ports "c0_ddr4_dq[78]"] ;
# # set_property PACKAGE_PIN G32      [get_ports "c0_ddr4_dq[79]"] ;
# set_property PACKAGE_PIN F40      [get_ports "c0_ddr4_dq[7]"] ;
# set_property PACKAGE_PIN F36      [get_ports "c0_ddr4_dq[8]"] ;
# set_property PACKAGE_PIN J36      [get_ports "c0_ddr4_dq[9]"] ;
# set_property PACKAGE_PIN G38      [get_ports "c0_ddr4_dqs_c[0]"] ;
# set_property PACKAGE_PIN G35      [get_ports "c0_ddr4_dqs_c[1]"] ;
# set_property PACKAGE_PIN A40      [get_ports "c0_ddr4_dqs_c[2]"] ;
# set_property PACKAGE_PIN B37      [get_ports "c0_ddr4_dqs_c[3]"] ;
# set_property PACKAGE_PIN N25      [get_ports "c0_ddr4_dqs_c[4]"] ;
# set_property PACKAGE_PIN L25      [get_ports "c0_ddr4_dqs_c[5]"] ;
# set_property PACKAGE_PIN G28      [get_ports "c0_ddr4_dqs_c[6]"] ;
# set_property PACKAGE_PIN A26      [get_ports "c0_ddr4_dqs_c[7]"] ;
# #set_property PACKAGE_PIN M30      [get_ports "c0_ddr4_dqs_c[8]"] ;
# #set_property PACKAGE_PIN G33      [get_ports "c0_ddr4_dqs_c[9]"] ;
# set_property PACKAGE_PIN H38      [get_ports "c0_ddr4_dqs_t[0]"] ;
# set_property PACKAGE_PIN H34      [get_ports "c0_ddr4_dqs_t[1]"] ;
# set_property PACKAGE_PIN A39      [get_ports "c0_ddr4_dqs_t[2]"] ;
# set_property PACKAGE_PIN B36      [get_ports "c0_ddr4_dqs_t[3]"] ;
# set_property PACKAGE_PIN P25      [get_ports "c0_ddr4_dqs_t[4]"] ;
# set_property PACKAGE_PIN L24      [get_ports "c0_ddr4_dqs_t[5]"] ;
# set_property PACKAGE_PIN H28      [get_ports "c0_ddr4_dqs_t[6]"] ;
# set_property PACKAGE_PIN B26      [get_ports "c0_ddr4_dqs_t[7]"] ;
# #set_property PACKAGE_PIN N30      [get_ports "c0_ddr4_dqs_t[8]"] ;
# #set_property PACKAGE_PIN H33      [get_ports "c0_ddr4_dqs_t[9]"] ;
# set_property PACKAGE_PIN J31      [get_ports "c0_ddr4_odt[0]"] ;
# set_property PACKAGE_PIN M28      [get_ports "c0_ddr4_reset_n"] ;