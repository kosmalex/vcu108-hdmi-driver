module axi4lite_ctrl import utils::*;
#(
  parameter N         = 5,
  parameter ADDRW     = 8,
  parameter DATAW     = 24,
  parameter INIT_FILE = "axi4lite_ctrl.mem"
)(
  input  logic clk_i,
  input  logic rst_n_i,

  input  logic start_i,

  output logic done_o,
  
  output logic[7 : 0]  s_axi_CTRL_AWADDR ,
  output logic         s_axi_CTRL_AWVALID,
  input  logic         s_axi_CTRL_AWREADY,
  output logic[31 : 0] s_axi_CTRL_WDATA  ,
  output logic[3 : 0]  s_axi_CTRL_WSTRB  ,
  output logic         s_axi_CTRL_WVALID ,
  input  logic         s_axi_CTRL_WREADY ,
  input  logic[1 : 0]  s_axi_CTRL_BRESP  ,
  input  logic         s_axi_CTRL_BVALID ,
  output logic         s_axi_CTRL_BREADY ,
  output logic[7 : 0]  s_axi_CTRL_ARADDR ,
  output logic         s_axi_CTRL_ARVALID,
  input  logic         s_axi_CTRL_ARREADY,
  input  logic[31 : 0] s_axi_CTRL_RDATA  ,
  input  logic[1 : 0]  s_axi_CTRL_RRESP  ,
  input  logic         s_axi_CTRL_RVALID ,
  output logic         s_axi_CTRL_RREADY
);

localparam DW = ADDRW + DATAW;

enum logic [3:0] {IDLE, REQ, DATA, RESP, DONE, REQ_LAST, DATA_LAST, RESP_LAST} axi_st_s;

logic[cl2(N)-1:0] transaction_cnt_s;
logic[DW-1:0]     transaction_s;

rom #(
  .LINES     (N        ),
  .DW        (DW       ),
  .INIT_FILE (INIT_FILE)
)
transaction_rom (
  .clka  (clk_i            ),
  .addra (transaction_cnt_s),
  .douta (transaction_s    )
);

// Axi master state FSM
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    transaction_cnt_s  <= 'd0;
    
    s_axi_CTRL_AWVALID <= 1'b0;
    s_axi_CTRL_AWADDR  <= 64'd0;
    s_axi_CTRL_WDATA   <= 64'd0;
    s_axi_CTRL_WSTRB   <= 4'hf;
    s_axi_CTRL_WVALID  <= 1'b0;
    s_axi_CTRL_BREADY  <= 1'b1;

    // Tie to constants
    s_axi_CTRL_ARADDR  <= 64'd0;
    s_axi_CTRL_ARVALID <= 1'b0;
    s_axi_CTRL_RREADY  <= 1'b0;

    done_o             <= 1'b0;

    axi_st_s           <= REQ;
  end else begin
    case (axi_st_s)
      // IDLE: begin
      //   if (start_i) begin
      //     done_o   <= 1'b0;
      //     axi_st_s <= REQ;
      //   end
      // end
      
      REQ: begin
        s_axi_CTRL_AWVALID <= 1'b1;
        s_axi_CTRL_WVALID  <= 1'b1;
        s_axi_CTRL_AWADDR  <= transaction_s[DW-1-:ADDRW];
        s_axi_CTRL_WDATA   <= transaction_s[0+:DATAW];

        if (s_axi_CTRL_AWREADY && s_axi_CTRL_WREADY) begin
          s_axi_CTRL_AWVALID <= 1'b0;
          s_axi_CTRL_WVALID  <= 1'b0;
          transaction_cnt_s  <= transaction_cnt_s + 'd1;

          axi_st_s <= RESP;
        end else if (s_axi_CTRL_AWREADY) begin
          s_axi_CTRL_AWVALID <= 1'b0;
          axi_st_s           <= DATA;
        end
      end
      
      DATA: begin
        if (s_axi_CTRL_WREADY) begin
          s_axi_CTRL_WVALID <= 1'b0;
          transaction_cnt_s <= transaction_cnt_s + 'd1;
          axi_st_s          <= RESP;
        end
      end
      
      RESP: begin
        if (s_axi_CTRL_BVALID) begin
          axi_st_s          <= (transaction_cnt_s < N) ? REQ : REQ_LAST;
        end 
      end
      
      // DONE: begin
      //   done_o   <= 1'b1;
      //   axi_st_s <= IDLE;
      // end
      
      REQ_LAST: begin
        transaction_cnt_s <= 'd0;
        
        if (start_i) begin
          s_axi_CTRL_AWVALID <= 1'b1;
          s_axi_CTRL_WVALID  <= 1'b1;
          s_axi_CTRL_AWADDR  <= 32'h4;
          s_axi_CTRL_WDATA   <= 32'h00001000;

          if (s_axi_CTRL_AWREADY && s_axi_CTRL_WREADY) begin
            s_axi_CTRL_AWVALID <= 1'b0;
            s_axi_CTRL_WVALID  <= 1'b0;
            transaction_cnt_s  <= transaction_cnt_s + 'd1;

            axi_st_s <= RESP_LAST;
          end else if (s_axi_CTRL_AWREADY) begin
            s_axi_CTRL_AWVALID <= 1'b0;
            axi_st_s           <= DATA_LAST;
          end
        end
      end
      
      DATA_LAST: begin
        if (s_axi_CTRL_WREADY) begin
          s_axi_CTRL_WVALID <= 1'b0;
          transaction_cnt_s <= transaction_cnt_s + 'd1;
          axi_st_s          <= RESP_LAST;
        end
      end
      
      RESP_LAST: begin
        if (s_axi_CTRL_BVALID) begin
          axi_st_s <= REQ;
        end 
      end

      default: begin
        axi_st_s <= REQ;
      end
    endcase
  end
end
endmodule
