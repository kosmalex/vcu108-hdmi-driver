module video_controller
#(
  parameter ACTIVE_H_PIXELS = 1280,
  parameter H_FRONT_PORCH   = 110 ,
  parameter H_SYNC_WIDTH    = 40  ,
  parameter H_BACK_PORCH    = 220 ,
  parameter ACTIVE_LINES    = 720 ,
  parameter V_FRONT_PORCH   = 5   ,
  parameter V_SYNC_WIDTH    = 5   ,
  parameter V_BACK_PORCH    = 20  ,
  parameter FPS             = 60  ,

  localparam TOTAL_PIXELS = ACTIVE_H_PIXELS 
                            + H_FRONT_PORCH 
                            + H_SYNC_WIDTH  
                            + H_BACK_PORCH, //Horizontal pixel count
  localparam TOTAL_LINES  = ACTIVE_LINES    
                            + V_FRONT_PORCH 
                            + V_SYNC_WIDTH  
                            + V_BACK_PORCH, //Vertical pixel count
  localparam HCNTR_BITS   = $clog2(TOTAL_PIXELS),
  localparam VCNTR_BITS   = $clog2(TOTAL_LINES),
  localparam FC_BITS      = $clog2(FPS)
)(
  input  logic                 clk_i      ,
  input  logic                 pixel_clk_i,
  input  logic                 rst_n_i    ,
  output logic[HCNTR_BITS-1:0] hcount_o   ,
  output logic[VCNTR_BITS-1:0] vcount_o   ,
  output logic                 vs_o       , //vertical sync out
  output logic                 hs_o       , //horizontal sync out
  output logic                 ad_o       ,
  output logic                 nf_o       , //single cycle enable signal
  output logic[FC_BITS-1:0]    fc_o         //frame
);

enum logic { ACTIVE_VIDEO,
             INACTIVE_VIDEO } video_st_s;

logic posedge_pxl_clk_ff_s;
logic posedge_pxl_clk_s;
always_ff @(posedge clk_i) begin
  if (!rst_n_i) begin
    posedge_pxl_clk_ff_s <= 1'b0;
  end else begin
    posedge_pxl_clk_ff_s <= pixel_clk_i;
  end
end
assign posedge_pxl_clk_s = ~posedge_pxl_clk_ff_s & clk_i;

// {H,V}-counters
always_ff @(posedge clk_i) begin : hv_counters
  if (!rst_n_i) begin
    {hcount_o, vcount_o} <= {(HCNTR_BITS + VCNTR_BITS){1'b0}};
  end else if (posedge_pxl_clk_s) begin
    if (hcount_o < TOTAL_PIXELS) begin
      hcount_o <= hcount_o + 'd1;
    end else begin
      hcount_o <= {HCNTR_BITS{1'b0}};
    end

    if (vcount_o < TOTAL_LINES) begin
      vcount_o <= (hcount_o == (TOTAL_PIXELS-1)) ? vcount_o + 'd1 : vcount_o;
    end else begin
      vcount_o <= {VCNTR_BITS{1'b0}};
    end
  end
end

always_ff @(posedge clk_i) begin : rolling_fc
  if(!rst_n_i) begin
    fc_o <= {FC_BITS{1'b0}};
  end else if (posedge_pxl_clk_s) begin
    fc_o <= nf_o ? (fc_o + 1'b1) : fc_o;
  end
end

always_comb begin : deduce_vid_st
  video_st_s = (hcount_o < ACTIVE_H_PIXELS) && 
               (vcount_o < ACTIVE_LINES)  ? ACTIVE_VIDEO : INACTIVE_VIDEO;
end

always_comb begin : hv_syncs
  hs_o = (hcount_o > ACTIVE_H_PIXELS + H_FRONT_PORCH               ) && 
         (hcount_o < ACTIVE_H_PIXELS + H_FRONT_PORCH + H_SYNC_WIDTH);

  vs_o = (hcount_o > ACTIVE_H_PIXELS + H_FRONT_PORCH               ) && 
         (hcount_o < ACTIVE_H_PIXELS + H_FRONT_PORCH + H_SYNC_WIDTH);
end

assign ad_o = (video_st_s == ACTIVE_VIDEO);
assign nf_o = (hcount_o == ACTIVE_H_PIXELS) && (hcount_o == ACTIVE_H_PIXELS);
endmodule