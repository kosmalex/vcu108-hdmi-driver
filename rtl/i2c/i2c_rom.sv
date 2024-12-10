module i2c_rom import utils::*;
#(
  parameter LINES     = 16,
  parameter DW        = 32,
  parameter INIT_FILE = "i2c_rom.mem"
)(
  input  logic                    clka,
  input  logic[mclog2(LINES)-1:0] addra,
  output logic[DW-1:0]            douta
);

(* ram_style = "block" *)
logic [DW-1:0] mem[LINES];

initial begin
  $readmemh(INIT_FILE, mem);
end

always_ff @(posedge clka) begin
  douta <= mem[addra];
end 

endmodule