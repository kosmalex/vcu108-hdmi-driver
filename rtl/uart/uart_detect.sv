module detector #(
  parameter TARGET = 32'hff
)(
  input logic clk_i,
  input logic rst_n_i,

  output logic tx,
  output logic rx,
  output logic interrupt_o
);

enum logic[1:0] {IDLE, READ, DETECT} st_s;

logic       rd_valid_s;
logic[3:0]  rd_data_s;
logic[31:0] rd_addr_s;
logic       rd_ready_s;
logic       rd_err_s;

uart uart_0 (
  .wr_valid_i('d0),
  .wr_data_i ('d0),
  .wr_addr_i ('d0),
  .wr_ready_o(/*Not connected*/),
  .wr_err_o  (/*Not connected*/),

  .rd_valid_i(rd_valid_s),
  .rd_data_o (rd_data_s ),
  .rd_addr_i (rd_addr_s ),
  .rd_ready_o(rd_ready_s),
  .rd_err_o  (rd_err_s  ),

  .tx        (tx        ),
  .rx        (rx        )
);

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    st_s <= IDLE;
  end else begin
    case(st_s)
      IDLE: begin
        if (!interrupt_o) begin
          rd_valid_s <= 1'b1;
          st_s       <= READ;
        end
      end

      READ: begin
        rd_valid_s <= 1'b0;
        if (rd_ready_s) begin
          interrupt_o <= (rd_data_s == TARGET);
          st_s        <= IDLE;
        end
      end

      default: st_s <= IDLE;
    endcase
  end
end

endmodule