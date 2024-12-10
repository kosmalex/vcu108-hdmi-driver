module uart (
  input  logic       clk_i  ,
  input  logic       rst_n_i,

  input  logic       wr_valid_i,
  input  logic[31:0] wr_data_i ,
  input  logic[3:0]  wr_addr_i ,
  output logic       wr_ready_o,
  output logic       wr_err_o,


  output logic       rd_valid_o,
  output logic[31:0] rd_data_o ,
  input  logic[3:0]  rd_addr_i ,
  input  logic       rd_ready_i,
  output logic       rd_err_o,

  output logic       tx,
  input  logic       rx
);

logic[3:0]  s_axi_awaddr;
logic       s_axi_awvalid;
logic       s_axi_awready;

logic[31:0] s_axi_wdata;
logic[3:0]  s_axi_wstrb;
logic       s_axi_wvalid;
logic       s_axi_wready;
  
logic[1:0]  s_axi_bresp;
logic       s_axi_bvalid;
logic       s_axi_bready;

logic[3:0]  s_axi_araddr;
logic       s_axi_arvalid;
logic       s_axi_arready;
  
logic[31:0] s_axi_rdata;
logic[1:0]  s_axi_rresp;
logic       s_axi_rvalid;
logic       s_axi_rready;

native2axi native2axi_0(.*);

axi_uartlite_0 axi_uartlite_00(
  .s_axi_awaddr  (s_axi_awaddr     ), // input wire [3 : 0] s_axi_awaddr
  .s_axi_awvalid (s_axi_awvalid    ), // input wire s_axi_awvalid
  .s_axi_awready (s_axi_awready    ), // output wire s_axi_awready
  .s_axi_wdata   (s_axi_wdata      ), // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb   (s_axi_wstrb      ), // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid  (s_axi_wvalid     ), // input wire s_axi_wvalid
  .s_axi_wready  (s_axi_wready     ), // output wire s_axi_wready
  .s_axi_bresp   (s_axi_bresp      ), // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid  (s_axi_bvalid     ), // output wire s_axi_bvalid
  .s_axi_bready  (s_axi_bready     ), // input wire s_axi_bready
  .s_axi_araddr  (s_axi_araddr     ), // input wire [3 : 0] s_axi_araddr
  .s_axi_arvalid (s_axi_arvalid    ), // input wire s_axi_arvalid
  .s_axi_arready (s_axi_arready    ), // output wire s_axi_arready
  .s_axi_rdata   (s_axi_rdata      ), // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp   (s_axi_rresp      ), // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid  (s_axi_rvalid     ), // output wire s_axi_rvalid
  .s_axi_rready  (s_axi_rready     ), // input wire s_axi_rready
  .rx            (rx               ), // input wire rx
  .tx            (tx               ), // input wire tx

  .s_axi_aclk    (clk_i            ), // input wire s_axi_aclk
  .s_axi_aresetn (rst_n_i          ), // input wire s_axi_aresetn
  .interrupt     (/*Not connected*/)  // output wire interrupt
);


endmodule