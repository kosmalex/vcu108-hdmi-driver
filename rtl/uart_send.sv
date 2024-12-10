module uart_send #(
  parameter N = 4
)(
  input logic clk_i,
  input logic rst_n_i,

  input  logic rx,
  output logic tx
);

logic      wr_valid_s;
logic[7:0] wr_data_s;
logic[3:0] wr_addr_s;
logic[1:0] rom_addr_s;
logic      wr_ready_s;
logic[31:0] i;

enum logic [2:0] {S[5]} st;

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    wr_valid_s<= 'b0;
    wr_addr_s <= 'd4;
    rom_addr_s <= 'd0;
    st <= S0;
  end else begin
    case(st)
      S0: begin
        i          <= 0;
        wr_valid_s <= 'b1;
        rom_addr_s <= 'd0;
        st <= S1;
      end

      S1: begin
        if (i < N) begin
          if (wr_ready_s) begin
            wr_valid_s <= 'b0;
            st <= S2;
          end
        end else begin
          wr_valid_s <= 'b0;
          st <= S4;
        end
      end

      S2: begin
        if(wr_ready_s) begin
          rom_addr_s <= rom_addr_s + 1;
          i          <= i + 1;
          st         <= S3;
        end
      end

      S3: begin
        wr_valid_s <= (i < N);
        st <= S1;
      end

      S4: begin end

      default: begin
        st <= S0;
      end
    endcase
  end
end

uart uart_0(
  .*,

  .wr_valid_i(wr_valid_s),
  .wr_data_i (wr_data_s ),
  .wr_addr_i (wr_addr_s ),
  .wr_ready_o(wr_ready_s),
  .wr_err_o  (wr_err_s  ),
  
  .rd_valid_o(),
  .rd_data_o (),
  .rd_addr_i ('d0),
  .rd_ready_i(1'b0),
  .rd_err_o  ()
);

i2c_rom #(
  .LINES(4),
  .DW(8),
  .INIT_FILE("i2c_uart.mem")
)
b2s(
  .clka  (clk_i),
  .addra (rom_addr_s),
  .douta (wr_data_s)
);

endmodule