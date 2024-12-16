module rgb2yuv_converter (
  prameter BPCH_I = 8,
  prameter BPCH_O = 8
)(
  input logic[BPCH_I-1:0] r_i,
  input logic[BPCH_I-1:0] g_i,
  input logic[BPCH_I-1:0] b_i,

  output logic[BPCH_O-1:0] y_o,
  output logic[BPCH_O-1:0] u_o,
  output logic[BPCH_O-1:0] v_o,
);

logic[15:0] y_coe_s[3] = '{
  16'h0042, //0.257
  16'h0081, //0.504
  16'h0019, //0.098
};

logic[15:0] u_coe_s[3] = '{
  16'hffda, //-0.148
  16'hffb6, //-0.291
  16'h0070, //0.439
};

logic[15:0] v_coe_s[3] = '{
  16'h0070, //0.439
  16'hffa2, //-0.368
  16'hffee, //-0.071
};

logic[26:0] y_s = y_coe_s[0] * r_i + y_coe_s[1] * g_i + y_coe_s[2] * b_i;
logic[26:0] u_s = y_coe_s[0] * r_i + y_coe_s[1] * g_i + y_coe_s[2] * b_i;
logic[26:0] v_s = y_coe_s[0] * r_i + y_coe_s[1] * g_i + y_coe_s[2] * b_i;

endmodule

def Y(R, G, B):
  Y =  0.257 * R + 0.504 * G + 0.098 * B +  16
  return int(round(Y, 0))

def U(R, G, B):
  U = -0.148 * R -0.291 * G + 0.439 * B + 128
  return int(round(U, 0))

def V(R, G, B):
  V =  0.439 * R -0.368 * G -0.071 * B + 128