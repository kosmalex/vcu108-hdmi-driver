module native2axi #(
  parameter W = 32,
  parameter A = 4
)(
  input  logic        clk_i,
  input  logic        rst_n_i,
  input  logic        wr_valid_i,
  input  logic[W-1:0] wr_data_i ,
  input  logic[A-1:0] wr_addr_i ,
  output logic        wr_ready_o,
  output logic        wr_err_o,

  output logic        rd_valid_i,
  output logic[W-1:0] rd_data_o ,
  input  logic[A-1:0] rd_addr_i ,
  input  logic        rd_ready_o,
  output logic        rd_err_o,

  output logic[A-1:0] s_axi_awaddr,
  output logic        s_axi_awvalid,
  input  logic        s_axi_awready,

  output logic[W-1:0] s_axi_wdata,
  output logic[A-1:0] s_axi_wstrb,
  output logic        s_axi_wvalid,
  input  logic        s_axi_wready,
  
  input  logic[1:0]   s_axi_bresp,
  input  logic        s_axi_bvalid,
  output logic        s_axi_bready,

  output logic[A-1:0] s_axi_araddr,
  output logic        s_axi_arvalid,
  input  logic        s_axi_arready,
  
  input  logic[W-1:0] s_axi_rdata,
  input  logic[1:0]   s_axi_rresp,
  input  logic        s_axi_rvalid,
  output logic        s_axi_rready
);

enum logic[2:0] {IDLE, WR_ADDR, WR_DATA, WR_RESP, RD_ADDR, RD_DATA} st_s;

always_ff @(posedge clk_i) begin
  if(!rst_n_i) begin
    { wr_ready_o   , wr_err_o     , 
      rd_valid_i   ,  s_axi_awaddr,
      rd_data_o    , rd_err_o     , 
      s_axi_awvalid, s_axi_wdata  , 
      s_axi_wstrb  , s_axi_wvalid , 
      s_axi_araddr , s_axi_arvalid } <= 'd0;
    
    s_axi_bready <= 1'b1;
    s_axi_rready <= 1'b1;

    st_s <= IDLE;
  end else begin
    case(st_s)
      IDLE: begin
        if (wr_valid_i) begin
          s_axi_awaddr  <= wr_addr_i;
          s_axi_awvalid <= wr_valid_i;

          s_axi_wstrb   <= 4'hf;
          s_axi_wvalid  <= wr_valid_i;
          s_axi_wdata   <= wr_data_i;

          s_axi_bready  <= 1'b1;

          st_s          <= WR_ADDR;
        end

        if (rd_valid_i) begin
          s_axi_araddr  <= rd_addr_i;
          s_axi_arvalid <= 1'b1;
          s_axi_rready  <= 1'b1;

          rd_ready_o    <= 1'b0;

          st_s          <= RD_ADDR;
        end
      end

      WR_ADDR: begin
        if (s_axi_awready && s_axi_wready && s_axi_bvalid) begin
          s_axi_awvalid <= 1'b0;
          s_axi_wvalid  <= 1'b0;
          s_axi_bready  <= 1'b0;
          wr_err_o      <= (s_axi_bresp != 2'b0);
          st_s          <= IDLE;
        end else if (s_axi_awready && s_axi_wready) begin
          s_axi_awvalid <= 1'b0;
          s_axi_wvalid  <= 1'b0;
          st_s <= WR_RESP;
        end else if (s_axi_awready) begin
          s_axi_awvalid <= 1'b0;
          st_s <= WR_DATA;
        end
      end

      WR_DATA: begin
        if (s_axi_wready && s_axi_bvalid) begin
          s_axi_wvalid <= 1'b0;
          s_axi_bready <= 1'b0;
          wr_err_o     <= (s_axi_bresp != 2'b0);
          st_s         <= IDLE;
        end else if (s_axi_wready) begin
          s_axi_wvalid <= 1'b0;
          st_s         <= WR_RESP;
        end
      end
      
      WR_RESP: begin
        if (s_axi_bvalid) begin
          s_axi_bready <= 1'b0;
          wr_err_o     <= (s_axi_bresp != 2'b0);
          st_s         <= IDLE;
        end
      end

      RD_ADDR: begin
        if (s_axi_arready && s_axi_rvalid) begin
          rd_data_o     <= s_axi_rdata;
          rd_ready_o    <= 1'b1;
          s_axi_arvalid <= 1'b0;

          st_s          <= IDLE;
        end else if (s_axi_arready) begin
          s_axi_arvalid <= 1'b0;
          st_s          <= RD_DATA;
        end 
      end

      RD_DATA: begin
        if (s_axi_rvalid) begin
          rd_data_o  <= s_axi_rdata;
          rd_ready_o <= 1'b1;

          st_s       <= IDLE;
        end
      end

      default: st_s <= IDLE;
    endcase
  end
end

assign wr_ready_o = (st_s == IDLE);

endmodule