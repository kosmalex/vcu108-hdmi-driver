module i2c_controller import utils::*;
#(
  DIVIDER     = 126, // 400 kHz @ 100Mhz clk_i
  START_HOLD  = 35,
  STOP_HOLD   = 35,
  FREE_HOLD   = 75,
  DATA_HOLD   = 30,
  NBYTES      = 3,
  NTRANS      = 41,
  INIT_FILE   = "i2c_rom.mem"
)(
  input  logic clk_i      ,
  input  logic rst_n_i    ,
  input  logic start_1cc_i,

  output logic scl_o      ,
  inout  logic sda_io     ,

  output logic done_o
);

enum logic[2:0] { IDLE, INIT, SEND, INCR, DONE} st_s;

logic                  i2c_send_s;
logic[cl2(NBYTES)-1:0] i2c_nbytes_s;
logic                  i2c_done_s;
logic                  i2c_ready_s;
logic[cl2(NTRANS)-1:0] i2c_trans_cnt_s;

logic[cl2(NTRANS)-1:0] rom_addr_s;
logic[NBYTES*8-1:0]    rom_data_s;

logic[NBYTES-1:0]      status_s;

`ifdef SIMULATION
  assign status_s = {NBYTES{1'b1}};
`endif

rom #(
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

  `ifdef SIMULATION
    .status_o (),
  `else
    .status_o (status_s    ),
  `endif

  .data_o   (/*Unconnected*/)
);

// FSMD
always_ff @(posedge clk_i) begin : i2c_fsmd
  if (!rst_n_i) begin
    i2c_trans_cnt_s <= NTRANS;
    i2c_nbytes_s    <= NBYTES;
    rom_addr_s      <= 'd0;
    done_o          <= 1'b0;
    st_s            <= IDLE;
  end else begin
    case(st_s)
      IDLE: begin
        if (start_1cc_i) begin
          i2c_trans_cnt_s <= NTRANS;
          i2c_nbytes_s    <= NBYTES; //First I2C transaction needs to send 2 bytes
          rom_addr_s      <= 'd0;
          done_o          <= 1'b0;
          st_s            <= INIT;
        end
      end

      INIT: begin
        st_s <= SEND;
      end

      SEND: begin
        if (i2c_done_s && (&status_s) ) begin
          i2c_nbytes_s    <= NBYTES;
          i2c_trans_cnt_s <= i2c_trans_cnt_s - 1'b1;
          rom_addr_s      <= rom_addr_s + 1'b1;
        end

        if (i2c_ready_s) begin
          st_s <= (&status_s) ? INCR : INIT;
        end
      end

      INCR: begin
        if (i2c_trans_cnt_s > 0) begin
          st_s <= INIT;
        end else begin
          done_o <= 1'b1;
          st_s   <= DONE;
        end
      end

      DONE: begin end

      default: st_s <= IDLE;
    endcase
  end
end

assign i2c_send_s = (st_s == INIT);

endmodule