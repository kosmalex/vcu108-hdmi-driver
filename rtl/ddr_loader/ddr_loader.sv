`include "../utilities.svh"

module ddr_loader #(
  parameter INIT_FILE = "ddr_loader.mem"
)(
  input  logic clk_i  ,
  input  logic rst_n_i,

  `GEN_AXI_MST_IF_WO (loader, 32, 32, 4),

  output logic done_o
);

logic         cdma_introut_s;
logic         virgin_s;
logic         start_ctrl_s;

logic[7 : 0]  s_axi_CTRL_AWADDR ;
logic         s_axi_CTRL_AWVALID;
logic         s_axi_CTRL_AWREADY;
logic[31 : 0] s_axi_CTRL_WDATA  ;
logic[3 : 0]  s_axi_CTRL_WSTRB  ;
logic         s_axi_CTRL_WVALID ;
logic         s_axi_CTRL_WREADY ;
logic[1 : 0]  s_axi_CTRL_BRESP  ;
logic         s_axi_CTRL_BVALID ;
logic         s_axi_CTRL_BREADY ;
logic[7 : 0]  s_axi_CTRL_ARADDR ;
logic         s_axi_CTRL_ARVALID;
logic         s_axi_CTRL_ARREADY;
logic[31 : 0] s_axi_CTRL_RDATA  ;
logic[1 : 0]  s_axi_CTRL_RRESP  ;
logic         s_axi_CTRL_RVALID ;
logic         s_axi_CTRL_RREADY ;

`GEN_AXI_WIRE_RO(m, 32, 32, 4);

axi4lite_ctrl
#(
  .N         (4        ),
  .ADDRW     (8        ),
  .DATAW     (24       ),
  .INIT_FILE ("loader_dma.mem")
)
axi4lite_ctrl_0 (
  .done_o (),
  .start_i(virgin_s),
  .*
);

axi_cdma_hdmi axi_cdma_hdmi_0 (
  .cdma_introut      (done_o),        // output wire cdma_introut
  .cdma_tvect_out    (),       // output wire [31 : 0] cdma_tvect_out

  .s_axi_lite_aclk   (clk_i),               // input wire s_axi_lite_aclk
  .s_axi_lite_aresetn(rst_n_i),             // input wire s_axi_lite_aresetn
  
  .s_axi_lite_awready(s_axi_CTRL_AWREADY ), // output wire s_axi_lite_awready
  .s_axi_lite_awvalid(s_axi_CTRL_AWVALID ), // input wire s_axi_lite_awvalid
  .s_axi_lite_awaddr (s_axi_CTRL_AWADDR[5:0]  ), // input wire [5 : 0] s_axi_lite_awaddr
  .s_axi_lite_wready (s_axi_CTRL_WREADY  ), // output wire s_axi_lite_wready
  .s_axi_lite_wvalid (s_axi_CTRL_WVALID  ), // input wire s_axi_lite_wvalid
  .s_axi_lite_wdata  (s_axi_CTRL_WDATA   ), // input wire [31 : 0] s_axi_lite_wdata
  .s_axi_lite_bready (s_axi_CTRL_BREADY  ), // input wire s_axi_lite_bready
  .s_axi_lite_bvalid (s_axi_CTRL_BVALID  ), // output wire s_axi_lite_bvalid
  .s_axi_lite_bresp  (s_axi_CTRL_BRESP   ), // output wire [1 : 0] s_axi_lite_bresp
  .s_axi_lite_arready(s_axi_CTRL_ARREADY ), // output wire s_axi_lite_arready
  .s_axi_lite_arvalid(s_axi_CTRL_ARVALID ), // input wire s_axi_lite_arvalid
  .s_axi_lite_araddr (s_axi_CTRL_ARADDR[5:0]  ), // input wire [5 : 0] s_axi_lite_araddr
  .s_axi_lite_rready (s_axi_CTRL_RREADY  ), // input wire s_axi_lite_rready
  .s_axi_lite_rvalid (s_axi_CTRL_RVALID  ), // output wire s_axi_lite_rvalid
  .s_axi_lite_rdata  (s_axi_CTRL_RDATA   ), // output wire [31 : 0] s_axi_lite_rdata
  .s_axi_lite_rresp  (s_axi_CTRL_RRESP   ), // output wire [1 : 0] s_axi_lite_rresp
  
  .m_axi_aclk        (clk_i),               // input wire m_axi_aclk
  `GEN_AXI_CON_WO_DMA(m, loader),
  `GEN_AXI_CON_RO_DMA(m, m)
);

ddr_loader_mem ddr_loader_mem_0 (
  .s_aclk                (clk_i),                // input wire s_aclk
  .s_aresetn             (rst_n_i),          // input wire s_aresetn
  `GEN_AXI_CON_BRAM_SFRO (s, m)
);

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    virgin_s <= 1'b1;
  end else if (virgin_s) begin
    virgin_s <= 1'b0;
  end
end

assign start_ctrl_s = virgin_s;

assign loader_axi_awlock = 'd0;
assign loader_axi_awid   = 'd0;
assign loader_axi_awqos  = 'd0;

assign m_axi_awid        = 'd0;
assign m_axi_awlock      = 'd0;
assign m_axi_awqos       = 'd0;
assign m_axi_arid        = 'd0;
assign m_axi_arlock      = 'd0;
assign m_axi_arqos       = 'd0;
endmodule