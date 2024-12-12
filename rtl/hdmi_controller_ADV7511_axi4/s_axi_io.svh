input  logic [31 : 0] hdmi_axi_awaddr  ,
input  logic [7 : 0]  hdmi_axi_awlen   ,
input  logic [2 : 0]  hdmi_axi_awsize  ,
input  logic [1 : 0]  hdmi_axi_awburst ,
input  logic [0 : 0]  hdmi_axi_awlock  ,
input  logic [3 : 0]  hdmi_axi_awcache ,
input  logic [2 : 0]  hdmi_axi_awprot  ,
input  logic [3 : 0]  hdmi_axi_awqos   ,
input  logic [3 : 0]  hdmi_axi_awregion,
input  logic          hdmi_axi_awvalid ,
output logic          hdmi_axi_awready ,
input  logic [31 : 0] hdmi_axi_wdata   ,
input  logic [3 : 0]  hdmi_axi_wstrb   ,
input  logic          hdmi_axi_wlast   ,
input  logic          hdmi_axi_wvalid  ,
output logic          hdmi_axi_wready  ,
output logic [1 : 0]  hdmi_axi_bresp   ,
output logic          hdmi_axi_bvalid  ,
input  logic          hdmi_axi_bready





























