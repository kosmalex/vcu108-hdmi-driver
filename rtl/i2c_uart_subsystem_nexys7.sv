module i2c_uart_subsystem import utils::*;
#(
  DIVIDER     = 126,
  START_HOLD  = 35,
  STOP_HOLD   = 35,
  FREE_HOLD   = 75,
  DATA_HOLD   = 30,
  NBYTES      = 2,
  NTRANS      = 4,
  INIT_FILE   = "i2c_uart.mem"
)(
  input  logic clk_i,
  input  logic rst_n_i,
  input  logic start_1cc_i,

  input  logic led_en_i,
  output logic led_en_o,

  output logic[7:0] LED,
//  output logic[NBYTES-1:0] status_o[NTRANS],

  output logic scl_o,
  inout  logic sda_io,

  output logic tx,
  input  logic rx,

  output logic done_o
);

 logic[NBYTES-1:0] status_o[NTRANS];

enum logic[2:0] { IDLE, INIT, COM, TX_INIT, WAIT, TX, INCR, DONE} st_s;

logic                     i2c_send_s;
logic[mclog2(NBYTES)-1:0] i2c_nbytes_s;
logic                     i2c_done_s;
logic                     i2c_ready_s;
logic[((NBYTES-1)*8)-1:0] i2c_data_s;
logic[mclog2(NTRANS)-1:0] i2c_trans_cnt_s;
logic                     i2c_ttype_s;

logic[mclog2(NTRANS)-1:0] rom_addr_s;
logic[NBYTES*8-1:0]       rom_data_s;

logic       wr_valid_s;
logic[31:0] wr_data_s;
logic[3:0]  wr_addr_s;
logic       wr_ready_s;

logic[NBYTES-1:0]  status_s;

i2c_rom #(
  .LINES     (NTRANS   ),
  .DW        (NBYTES*8 ),
  .INIT_FILE (INIT_FILE)
)
i2c_rom_0 ( // Either custom or vivado generated
  .clka  (clk_i),
  .addra (rom_addr_s),
  .douta (rom_data_s)
);

i2c
#(
  .DIVIDER    (DIVIDER   ),
  .START_HOLD (START_HOLD),
  .STOP_HOLD  (STOP_HOLD ),
  .FREE_HOLD  (FREE_HOLD ),
  .DATA_HOLD  (DATA_HOLD ),
  .NBYTES     (NBYTES    )
)
i2c_0 (
  .*,

  .send_i   (i2c_send_s  ),
  .nbytes_i (i2c_nbytes_s),
  .data_i   (rom_data_s  ),
  .done_o   (i2c_done_s  ),
  .ready_o  (i2c_ready_s ),
  .data_o   (i2c_data_s  ),
  .status_o (status_s    )
);

uart uart_0 (
  .*,

  .wr_valid_i (wr_valid_s),
  .wr_data_i  (wr_data_s ),
  .wr_addr_i  (wr_addr_s ),
  .wr_ready_o (wr_ready_s),
  .wr_err_o   (),

  .rd_valid_o (/*Not connected*/),
  .rd_data_o  (/*Not connected*/),
  .rd_addr_i  ('d0              ),
  .rd_ready_i (1'b0             ),
  .rd_err_o   (/*Not connected*/)
);

logic w8_hold_count_s;
logic w8_hold_done_s;
timer #(10000000) w8_hold (.*, .count_i(w8_hold_count_s), .done_o(w8_hold_done_s));

assign w8_hold_count_s = (st_s == WAIT);

// FSMD
always_ff @(posedge clk_i) begin : i2c_fsmd
  if (!rst_n_i) begin
    status_o        <= '{default:2'b0};
    i2c_trans_cnt_s <= NTRANS;
    i2c_nbytes_s    <= 'd2;
    i2c_ttype_s     <= 1'b0;
    wr_addr_s       <= 'd0;
    wr_data_s       <= 'd0;
    wr_valid_s      <= 1'b0;
    rom_addr_s      <= 'd0;
    done_o          <= 1'b0;
    st_s            <= IDLE;
  end else begin
    case(st_s)
      IDLE: begin
        if (start_1cc_i) begin
          i2c_trans_cnt_s <= NTRANS;
          i2c_nbytes_s    <= 'd2; //First I2C transaction needs to send 2 bytes
          rom_addr_s      <= 'd0;
          done_o          <= 1'b0;
          st_s            <= INIT;
        end
      end

      INIT: begin
        st_s <= COM;
      end

      COM: begin
        if (i2c_done_s && (&status_s)) begin
          i2c_trans_cnt_s <= i2c_trans_cnt_s - 1'b1;
          rom_addr_s      <= rom_addr_s + 1'b1;
          i2c_ttype_s     <= rom_data_s[0];
        end

        if (i2c_ready_s) begin
          st_s <= &status_s ? INCR : INIT;
        end
      end

      INCR: begin
        status_o[i2c_trans_cnt_s] <= status_s;
        i2c_nbytes_s              <= i2c_ttype_s ? 'd2 : NBYTES;
        wr_valid_s                <= i2c_ttype_s ? 1'b1 : 1'b0;
        wr_addr_s                 <= 4'h4;
        wr_data_s                 <= {24'b0, i2c_data_s[7:0]};
        st_s                      <= i2c_ttype_s ? TX_INIT  : INIT;
      end

      TX_INIT: begin
        wr_valid_s <= 1'b0;
        st_s       <= TX;
      end

      WAIT: begin
        if (w8_hold_done_s) begin
          st_s <= TX;
        end
      end

      TX: begin
        if (wr_ready_s) begin
          if (i2c_trans_cnt_s > 0) begin
            st_s       <= INIT;
          end else begin
            done_o     <= 1'b1;
            st_s       <= DONE;
          end
        end 
      end

      DONE: begin end

      default: st_s <= IDLE;
    endcase
  end
end

always_ff @(posedge clk_i) begin
  if(!rst_n_i) begin
    LED <= 8'b0;
  end else if (st_s == TX_INIT) begin
    LED <= i2c_data_s[7:0];
  end
end

assign i2c_send_s = (st_s == INIT);
assign led_en_o   = led_en_i;

endmodule