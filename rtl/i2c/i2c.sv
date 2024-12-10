module i2c import utils::*;
#(
  DIVIDER     = 50,
  START_HOLD  = 10,
  STOP_HOLD   = 10,
  FREE_HOLD   = 10,
  DATA_HOLD   = 5,
  NBYTES      = 3
)(
  input  logic                      clk_i,
  input  logic                      rst_n_i,

  input  logic                      send_i,
  input  logic [mclog2(NBYTES)-1:0] nbytes_i,
  input  logic [(NBYTES*8)-1:0]     data_i,
  output logic [((NBYTES-1)*8)-1:0] data_o,
  output logic                      done_o,
  output logic                      ready_o,

  output logic                      scl_o,
  inout  logic                      sda_io,

  output logic [NBYTES-1:0]         status_o
);

typedef enum logic[3:0] {IDLE, START, START_INIT, ADDR_SEND, ADDR_ACK, SEND, READ, ACK, STOP_INIT, STOP, FREE} state_t;

state_t                        st_s;
state_t                        st_buffer_s;

logic                          scl_s;
logic                          hold_scl_s;

logic                          start_hold_count_s;
logic                          start_hold_done_s;

logic                          stop_hold_count_s;
logic                          stop_hold_done_s;

logic                          data_hold_count_s;
logic                          data_hold_done_s;

logic                          free_hold_count_s;
logic                          free_hold_done_s;

logic                          scl_negedge_reg_s;
logic                          scl_negedge_s;
logic                          scl_posedge_s;

logic [3:0]                    bits_sent_counter_reg_s;
logic [8:0]                    data_byte_s;

logic [7:0]                    slv_addr_s;
logic [7:0]                    slv_data_s;
logic [((NBYTES-1)*8)-1:0]     rcvd_data_s;

logic                          init_send_data_s;

logic                          is_read_s;

logic                          sda_in_s;
logic                          sda_out_s;
logic                          is_out_s;

// SCL period generator
clk_divider #(
  .DIVIDER (DIVIDER)
)
clk_divider_0 (
  .clk_i   (clk_i),
  .rst_n_i (rst_n_i),
  .reset_i (st_s == IDLE),
  .hold_i  (hold_scl_s),
  .clk_o   (scl_s)
);

// Timers for different I2C specific constraints
timer #(START_HOLD) start_hold (.*, .count_i(start_hold_count_s), .done_o(start_hold_done_s));
timer #(STOP_HOLD ) stop_hold  (.*, .count_i(stop_hold_count_s) , .done_o(stop_hold_done_s));
timer #(DATA_HOLD ) data_hold  (.*, .count_i(data_hold_count_s | scl_negedge_s) , .done_o(data_hold_done_s));
timer #(FREE_HOLD ) free_hold  (.*, .count_i(free_hold_count_s) , .done_o(free_hold_done_s));

// Information about a single I2C transaction.
logic [mclog2(NBYTES)-1:0] nbytes_s;
logic [mclog2(NBYTES)-1:0] nbytes_cntr_s;
logic [(NBYTES*8)-1:0]     data_s;
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    nbytes_s      <= 'd0;
    nbytes_cntr_s <= 'd0;
    data_s        <= 'd0;
  end else begin
    if ( send_i && (st_s == IDLE) ) begin
      nbytes_s      <= nbytes_i;
      nbytes_cntr_s <= nbytes_i;
      data_s        <= data_i;
    end else if ( 
      ( (st_s == ACK) || (st_s == ADDR_ACK) ) && scl_negedge_s
    ) begin
      nbytes_cntr_s <= nbytes_cntr_s - 'd1;
    end
  end
end

// Next three ffs are the single address and data bytes to be sent, as well
// as a counter for each 8-bit transaction
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    data_byte_s <= 'd0;
  end else begin
    if (init_send_data_s) begin
      for (int i = 0; i < 8; i++) begin
        data_byte_s[7-i] <= slv_data_s[i];
      end
    end else if (data_hold_done_s) begin
      data_byte_s <= data_byte_s >> 'd1;
    end
  end
end

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    bits_sent_counter_reg_s <= 'd8;
  end else if (scl_posedge_s) begin
    if (st_s == SEND) begin
      bits_sent_counter_reg_s <= bits_sent_counter_reg_s - 'd1;
    end else if (st_s == ADDR_SEND) begin
      bits_sent_counter_reg_s <= bits_sent_counter_reg_s - 'd1;
    end else if (st_s == READ) begin
      bits_sent_counter_reg_s <= bits_sent_counter_reg_s - 'd1;
    end else if (st_s == ACK) begin
      bits_sent_counter_reg_s <= 'd8;
    end else if (st_s == ADDR_ACK) begin
      bits_sent_counter_reg_s <= 'd8;
    end
  end
end

// This is edge detection logic for SCL
always_ff @(posedge clk_i) begin
  scl_negedge_reg_s <= scl_o;
end
assign scl_negedge_s =  scl_negedge_reg_s & ~scl_o;
assign scl_posedge_s = ~scl_negedge_reg_s &  scl_o;

// Basically when should we start counting for data hold
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    data_hold_count_s <= 1'b0;
  end else begin
    if (scl_negedge_s) begin
      data_hold_count_s <= 1'b1;
    end else if (data_hold_done_s) begin
      data_hold_count_s <= 1'b0;
    end
  end
end

// Receive register
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    rcvd_data_s <= 72'd0;
  end else begin
    if (scl_posedge_s && (st_s == READ)) begin
      rcvd_data_s    <= rcvd_data_s << 'd1;
      rcvd_data_s[0] <= sda_in_s;
    end
  end
end

// Buffer transaction type READ or WRITE
always_ff @(posedge clk_i) begin
  if (!rst_n_i || (st_s == FREE)) begin
    is_read_s <= 1'b0; // Defaults to WRITE
  end else if (
    (st_s == ADDR_SEND)              && 
    (bits_sent_counter_reg_s == 'd0) &&
    data_hold_done_s
  ) begin
    is_read_s <= data_byte_s[0];
  end
end

// Main FSM for each state of the transaction.
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    st_s <= IDLE;
  end else begin
    case (st_s)
      IDLE: begin
        if (send_i) begin
          st_s <= START;
        end
      end

      START: begin
        if (start_hold_done_s) begin
          st_s <= START_INIT;
        end
      end

      START_INIT: begin
        if (data_hold_done_s) begin
          st_s <= ADDR_SEND;
        end
      end

      ADDR_SEND: begin
        if (bits_sent_counter_reg_s == 'd0) begin
          st_s <= data_hold_done_s ? ADDR_ACK : ADDR_SEND;
        end
      end

      ADDR_ACK: begin
        if (scl_posedge_s) begin
          status_o[nbytes_s - nbytes_cntr_s] <= !sda_in_s;
        end

        if (data_hold_done_s) begin
          st_s <= is_read_s ? READ : SEND;
        end
      end
      
      SEND: begin
        if (bits_sent_counter_reg_s == 'd0) begin
          st_s <= data_hold_done_s ? ACK : SEND;
        end
      end

      READ: begin
        if (bits_sent_counter_reg_s == 'd0) begin
          st_s <= data_hold_done_s ? ACK : READ;
        end
      end
      
      ACK: begin
        if (scl_posedge_s) begin
          status_o[nbytes_s - nbytes_cntr_s] <= !sda_in_s;
        end

        if (nbytes_cntr_s > 'd0) begin
          if (is_read_s) begin
            st_s <= data_hold_done_s ? READ : ACK;
          end else begin
            st_s <= data_hold_done_s ? SEND : ACK;
          end
        end else if (data_hold_done_s) begin
          st_s <= STOP_INIT;
        end
      end

      STOP_INIT: begin
        if (scl_posedge_s) begin
          st_s <= STOP;
        end
      end

      STOP: begin
        if (stop_hold_done_s) begin
          st_s <= FREE;
        end
      end

      FREE: begin
        if (free_hold_done_s) begin
          st_s <= IDLE;
        end
      end

      default: begin
        st_s <= IDLE;
      end
    endcase
  end
end

// For an FPGA GPIO, this is how you declare a tri-state buffer.
// This cannot be instantiated internally but only for external I/O.
assign sda_io   = is_out_s ? sda_out_s : 1'bz;
assign sda_in_s = sda_io;

always_comb begin
  is_out_s = 1'b1;

  if (st_s == READ) begin
    is_out_s = 1'b0;
  end else if (st_s == ADDR_ACK) begin
    is_out_s = 1'b0;
  end else if (st_s == ACK) begin
    is_out_s = is_read_s;
  end
end

// Edge detection for FREE state
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    st_buffer_s <= IDLE;
  end else begin
    st_buffer_s <= st_s;
  end
end

// First byte is slave address following bytes are data bytes.
assign slv_data_s         = data_s[(nbytes_s - nbytes_cntr_s)*8+:8];

assign start_hold_count_s = (st_s == START);
assign stop_hold_count_s  = (st_s == STOP);
assign free_hold_count_s  = (st_s == FREE);
assign hold_scl_s         = (st_s == IDLE) || (st_s == START) || (st_s == STOP) || (st_s == FREE);

assign scl_o              = hold_scl_s ? 'd1 : scl_s;

assign done_o             = (st_s == FREE) && (st_buffer_s != FREE);
assign ready_o            = (st_s == IDLE);

assign data_o             = rcvd_data_s;

assign init_send_data_s   = ( (st_s == ACK     ) && data_hold_done_s ) ||
                            ( (st_s == ADDR_ACK) && data_hold_done_s ) ||
                            ( st_s == START_INIT                     )  ;

/* Due to this always comb data_byte_s had to be
   1-bit longer to prevent sda from changing while
   scl is high.
*/
always_comb begin
  sda_out_s = 1'b1;

  if (st_s == START) begin
    sda_out_s = 1'b0;
  end else if (st_s == START_INIT) begin
    sda_out_s = 1'b0;
  end else if (st_s == ADDR_SEND) begin
    sda_out_s = data_byte_s[0];
  end else if (st_s == ADDR_ACK) begin
    sda_out_s = data_byte_s[0];
  end else if ((st_s == ACK) && !is_read_s) begin
    sda_out_s = data_byte_s[0];
  end else if (st_s == SEND) begin
    sda_out_s = data_byte_s[0];
  end else if (st_s == STOP) begin
    sda_out_s = 1'b0;
  end else if (st_s == STOP_INIT) begin
    sda_out_s = 1'b0;
  end else if ((st_s == STOP) && stop_hold_done_s) begin
    sda_out_s = 1'b1;
  end else if ((st_s == ACK) && is_read_s) begin
    sda_out_s = 1'b0;
  end
end
endmodule