module i2c_controller #(
  DIVIDER     = 50,
  START_HOLD  = 10,
  STOP_HOLD   = 10,
  FREE_HOLD   = 10,
  DATA_HOLD   = 5,
  NBYTES      = 3,
  NTRANS      = 1,
  INIT_FILE   = "i2c_rom.mem"
)(
  input  logic clk_i,
  input  logic rst_n_i,
  input  logic start_1cc_i,

  output logic scl_o,
  inout  logic sda_io
);

enum logic[2:0] { IDLE, INIT, SEND, INCR } st;

logic                     i2c_send_s;
logic[$clog2(NBYTES)-1:0] i2c_nbytes_s;
logic                     i2c_done_s;
logic                     i2c_ready_s;
logic[$clog2(NTRANS)-1:0] i2c_trans_cnt_s;

logic[$clog2(NTRANS)-1:0] rom_addr_s;
logic[NBYTES*8-1:0]       rom_data_s;

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

  .data_o   (/*Unconnected*/)
);

// FSMD
always_ff @(posedge clk_i) begin : i2c_fsmd
  if (!rst_n_i) begin
    i2c_trans_cnt_s <= NTRANS;
    i2c_nbytes_s    <= NBYTES;
    rom_addr_s      <= 'd0;
    st              <= IDLE;
  end else begin
    case(st)
      IDLE: begin
        if (start_1cc_i) begin
          i2c_trans_cnt_s <= NTRANS;
          i2c_nbytes_s    <= NBYTES;
          rom_addr_s      <= 'd0;
          st              <= INIT;
        end
      end

      INIT: begin
        st <= SEND;
      end

      SEND: begin
        if (i2c_done_s) begin
          i2c_trans_cnt_s <= i2c_trans_cnt_s - 1'b1;
          rom_addr_s      <= rom_addr_s + 1'b1;
        end

        st <= i2c_ready_s ? INCR : SEND;
      end

      INCR: begin
        if (i2c_trans_cnt_s > 0) begin
          st <= INIT;
        end else begin
          st <= IDLE;
        end
      end

      default: st <= IDLE;
    endcase
  end
end

assign i2c_send_s = (st == INIT);

endmodule