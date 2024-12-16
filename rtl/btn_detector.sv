module btn_detector #(
  parameter NCLKS = 1000 // Number of CCs to stay IDLE
)(
  input  logic clk_i,
  input  logic rst_n_i,
  input  logic btn_i,
  output logic pressed_o
);

enum logic {BTN[2]} st_s;

logic w8_press_count_s;
logic w8_press_done_s;

timer #(NCLKS) w8_press (.*, .count_i(w8_press_count_s), .done_o(w8_press_done_s));

logic btn_buffer_s;
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    btn_buffer_s <= 0;
  end else begin
    btn_buffer_s <= btn_i;
  end
end

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    pressed_o <= 'd0;
  end else if(
    (st_s == BTN0) && !btn_buffer_s && btn_i
  ) begin
    pressed_o <= 'd1;
  end else begin
    pressed_o <= 'd0;
  end
end

always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    st_s <= BTN0;
  end else begin
    case(st_s)
      BTN0: begin
        if (!btn_buffer_s && btn_i) begin
          st_s <= BTN1;
        end
      end

      BTN1: begin
        if (w8_press_done_s) begin
          st_s <= BTN0;
        end
      end
      
      default: st_s <= BTN0;
    endcase
  end
end

assign w8_press_count_s = (st_s == BTN1);

endmodule