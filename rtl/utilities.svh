//`ifndef __AXI_GEN_SVH__
//`define __AXI_GEN_SVH__

`define GEN_AXI_SLV_IF(NAME, A, D, I)\
  input  logic[I-1 : 0] ``NAME``_axi_awid,\
  input  logic[A-1 : 0] ``NAME``_axi_awaddr,\
  input  logic[7 : 0]   ``NAME``_axi_awlen,\
  input  logic[2 : 0]   ``NAME``_axi_awsize,\
  input  logic[1 : 0]   ``NAME``_axi_awburst,\
  input  logic          ``NAME``_axi_awlock,\
  input  logic[3 : 0]   ``NAME``_axi_awcache,\
  input  logic[2 : 0]   ``NAME``_axi_awprot,\
  input  logic[3 : 0]   ``NAME``_axi_awqos,\
  input  logic          ``NAME``_axi_awvalid,\
  output logic          ``NAME``_axi_awready,\
  input  logic[D-1 : 0] ``NAME``_axi_wdata,\
  input  logic[3 : 0]   ``NAME``_axi_wstrb,\
  input  logic          ``NAME``_axi_wlast,\
  input  logic          ``NAME``_axi_wvalid,\
  output logic          ``NAME``_axi_wready,\
  output logic[I-1 : 0] ``NAME``_axi_bid,\
  output logic[1 : 0]   ``NAME``_axi_bresp,\
  output logic          ``NAME``_axi_bvalid,\
  input  logic          ``NAME``_axi_bready,\
  input  logic[I-1 : 0] ``NAME``_axi_arid,\
  input  logic[A-1 : 0] ``NAME``_axi_araddr,\
  input  logic[7 : 0]   ``NAME``_axi_arlen,\
  input  logic[2 : 0]   ``NAME``_axi_arsize,\
  input  logic[1 : 0]   ``NAME``_axi_arburst,\
  input  logic          ``NAME``_axi_arlock,\
  input  logic[3 : 0]   ``NAME``_axi_arcache,\
  input  logic[2 : 0]   ``NAME``_axi_arprot,\
  input  logic[3 : 0]   ``NAME``_axi_arqos,\
  input  logic          ``NAME``_axi_arvalid,\
  output logic          ``NAME``_axi_arready,\
  output logic[I-1 : 0] ``NAME``_axi_rid,\
  output logic[D-1 : 0] ``NAME``_axi_rdata,\
  output logic[1 : 0]   ``NAME``_axi_rresp,\
  output logic          ``NAME``_axi_rlast,\
  output logic          ``NAME``_axi_rvalid,\
  input  logic          ``NAME``_axi_rready

`define GEN_AXI_SLV_IF_WO(NAME, A, D, I)\
  input  logic[I-1 : 0] ``NAME``_axi_awid,\
  input  logic[A-1 : 0] ``NAME``_axi_awaddr,\
  input  logic[7 : 0]   ``NAME``_axi_awlen,\
  input  logic[2 : 0]   ``NAME``_axi_awsize,\
  input  logic[1 : 0]   ``NAME``_axi_awburst,\
  input  logic          ``NAME``_axi_awlock,\
  input  logic[3 : 0]   ``NAME``_axi_awcache,\
  input  logic[2 : 0]   ``NAME``_axi_awprot,\
  input  logic          ``NAME``_axi_awvalid,\
  output logic          ``NAME``_axi_awready,\
  input  logic[D-1 : 0] ``NAME``_axi_wdata,\
  output logic[D/8-1 : 0] ``NAME``_axi_wstrb,\
  input  logic          ``NAME``_axi_wlast,\
  input  logic          ``NAME``_axi_wvalid,\
  output logic          ``NAME``_axi_wready,\
  output logic[I-1 : 0] ``NAME``_axi_bid,\
  output logic[1 : 0]   ``NAME``_axi_bresp,\
  output logic          ``NAME``_axi_bvalid,\
  input  logic          ``NAME``_axi_bready

`define GEN_AXI_MST_IF(NAME, A, D, I)\
  output logic[I-1 : 0] ``NAME``_axi_awid,\
  output logic[A-1 : 0] ``NAME``_axi_awaddr,\
  output logic[7 : 0]   ``NAME``_axi_awlen,\
  output logic[2 : 0]   ``NAME``_axi_awsize,\
  output logic[1 : 0]   ``NAME``_axi_awburst,\
  output logic          ``NAME``_axi_awlock,\
  output logic[3 : 0]   ``NAME``_axi_awcache,\
  output logic[2 : 0]   ``NAME``_axi_awprot,\
  output logic[3 : 0]   ``NAME``_axi_awqos,\
  output logic          ``NAME``_axi_awvalid,\
  input  logic          ``NAME``_axi_awready,\
  output logic[D-1 : 0] ``NAME``_axi_wdata,\
  output logic[D/8-1 : 0] ``NAME``_axi_wstrb,\
  output logic          ``NAME``_axi_wlast,\
  output logic          ``NAME``_axi_wvalid,\
  input  logic          ``NAME``_axi_wready,\
  input  logic[I-1 : 0] ``NAME``_axi_bid,\
  input  logic[1 : 0]   ``NAME``_axi_bresp,\
  input  logic          ``NAME``_axi_bvalid,\
  output logic          ``NAME``_axi_bready,\
  output logic[I-1 : 0] ``NAME``_axi_arid,\
  output logic[A-1 : 0] ``NAME``_axi_araddr,\
  output logic[7 : 0]   ``NAME``_axi_arlen,\
  output logic[2 : 0]   ``NAME``_axi_arsize,\
  output logic[1 : 0]   ``NAME``_axi_arburst,\
  output logic          ``NAME``_axi_arlock,\
  output logic[3 : 0]   ``NAME``_axi_arcache,\
  output logic[2 : 0]   ``NAME``_axi_arprot,\
  output logic[3 : 0]   ``NAME``_axi_arqos,\
  output logic          ``NAME``_axi_arvalid,\
  input  logic          ``NAME``_axi_arready,\
  input  logic[I-1 : 0] ``NAME``_axi_rid,\
  input  logic[D-1 : 0] ``NAME``_axi_rdata,\
  input  logic[1 : 0]   ``NAME``_axi_rresp,\
  input  logic          ``NAME``_axi_rlast,\
  input  logic          ``NAME``_axi_rvalid,\
  output logic          ``NAME``_axi_rready

`define GEN_AXI_MST_IF_WO(NAME, A, D, I)\
  output logic[I-1 : 0]   ``NAME``_axi_awid,\
  output logic[A-1 : 0]   ``NAME``_axi_awaddr,\
  output logic[7 : 0]     ``NAME``_axi_awlen,\
  output logic[2 : 0]     ``NAME``_axi_awsize,\
  output logic[1 : 0]     ``NAME``_axi_awburst,\
  output logic            ``NAME``_axi_awlock,\
  output logic[3 : 0]     ``NAME``_axi_awcache,\
  output logic[2 : 0]     ``NAME``_axi_awprot,\
  output logic[3 : 0]     ``NAME``_axi_awqos,\
  output logic            ``NAME``_axi_awvalid,\
  input  logic            ``NAME``_axi_awready,\
  output logic[D-1 : 0]   ``NAME``_axi_wdata,\
  output logic[D/8-1 : 0] ``NAME``_axi_wstrb,\
  output logic            ``NAME``_axi_wlast,\
  output logic            ``NAME``_axi_wvalid,\
  input  logic            ``NAME``_axi_wready,\
  input  logic[I-1 : 0]   ``NAME``_axi_bid,\
  input  logic[1 : 0]     ``NAME``_axi_bresp,\
  input  logic            ``NAME``_axi_bvalid,\
  output logic            ``NAME``_axi_bready

`define GEN_AXI_MST_IF_RO(NAME, A, D, I)\
  output logic[I-1 : 0] ``NAME``_axi_arid,\
  output logic[A-1 : 0] ``NAME``_axi_araddr,\
  output logic[7 : 0]   ``NAME``_axi_arlen,\
  output logic[2 : 0]   ``NAME``_axi_arsize,\
  output logic[1 : 0]   ``NAME``_axi_arburst,\
  output logic          ``NAME``_axi_arlock,\
  output logic[3 : 0]   ``NAME``_axi_arcache,\
  output logic[2 : 0]   ``NAME``_axi_arprot,\
  output logic[3 : 0]   ``NAME``_axi_arqos,\
  output logic          ``NAME``_axi_arvalid,\
  input  logic          ``NAME``_axi_arready,\
  input  logic[I-1 : 0] ``NAME``_axi_rid,\
  input  logic[D-1 : 0] ``NAME``_axi_rdata,\
  input  logic[1 : 0]   ``NAME``_axi_rresp,\
  input  logic          ``NAME``_axi_rlast,\
  input  logic          ``NAME``_axi_rvalid,\
  output logic          ``NAME``_axi_rready

`define GEN_AXI_WIRE(NAME, A, D, I)\
  logic[I-1 : 0] ``NAME``_axi_awid;\
  logic[A-1 : 0] ``NAME``_axi_awaddr;\
  logic[7 : 0]   ``NAME``_axi_awlen;\
  logic[2 : 0]   ``NAME``_axi_awsize;\
  logic[1 : 0]   ``NAME``_axi_awburst;\
  logic          ``NAME``_axi_awlock;\
  logic[3 : 0]   ``NAME``_axi_awcache;\
  logic[2 : 0]   ``NAME``_axi_awprot;\
  logic[3 : 0]   ``NAME``_axi_awqos;\
  logic          ``NAME``_axi_awvalid;\
  logic          ``NAME``_axi_awready;\
  logic[D-1 : 0] ``NAME``_axi_wdata;\
  logic[D/8-1 : 0] ``NAME``_axi_wstrb;\
  logic          ``NAME``_axi_wlast;\
  logic          ``NAME``_axi_wvalid;\
  logic          ``NAME``_axi_wready;\
  logic[I-1 : 0] ``NAME``_axi_bid;\
  logic[1 : 0]   ``NAME``_axi_bresp;\
  logic          ``NAME``_axi_bvalid;\
  logic          ``NAME``_axi_bready;\
  logic[I-1 : 0] ``NAME``_axi_arid;\
  logic[A-1 : 0] ``NAME``_axi_araddr;\
  logic[7 : 0]   ``NAME``_axi_arlen;\
  logic[2 : 0]   ``NAME``_axi_arsize;\
  logic[1 : 0]   ``NAME``_axi_arburst;\
  logic          ``NAME``_axi_arlock;\
  logic[3 : 0]   ``NAME``_axi_arcache;\
  logic[2 : 0]   ``NAME``_axi_arprot;\
  logic[3 : 0]   ``NAME``_axi_arqos;\
  logic          ``NAME``_axi_arvalid;\
  logic          ``NAME``_axi_arready;\
  logic[I-1 : 0] ``NAME``_axi_rid;\
  logic[D-1 : 0] ``NAME``_axi_rdata;\
  logic[1 : 0]   ``NAME``_axi_rresp;\
  logic          ``NAME``_axi_rlast;\
  logic          ``NAME``_axi_rvalid;\
  logic          ``NAME``_axi_rready

`define GEN_AXI_WIRE_WO(NAME, A, D, I)\
  logic[I-1 : 0] ``NAME``_axi_awid;\
  logic[A-1 : 0] ``NAME``_axi_awaddr;\
  logic[7 : 0]   ``NAME``_axi_awlen;\
  logic[2 : 0]   ``NAME``_axi_awsize;\
  logic[1 : 0]   ``NAME``_axi_awburst;\
  logic          ``NAME``_axi_awlock;\
  logic[3 : 0]   ``NAME``_axi_awcache;\
  logic[2 : 0]   ``NAME``_axi_awprot;\
  logic[3 : 0]   ``NAME``_axi_awqos;\
  logic          ``NAME``_axi_awvalid;\
  logic          ``NAME``_axi_awready;\
  logic[D-1 : 0] ``NAME``_axi_wdata;\
  logic[D/8-1 : 0] ``NAME``_axi_wstrb;\
  logic          ``NAME``_axi_wlast;\
  logic          ``NAME``_axi_wvalid;\
  logic          ``NAME``_axi_wready;\
  logic[I-1 : 0] ``NAME``_axi_bid;\
  logic[1 : 0]   ``NAME``_axi_bresp;\
  logic          ``NAME``_axi_bvalid;\
  logic          ``NAME``_axi_bready

`define GEN_AXI_WIRE_RO(NAME, A, D, I)\
  logic[I-1 : 0] ``NAME``_axi_arid;\
  logic[A-1 : 0] ``NAME``_axi_araddr;\
  logic[7 : 0]   ``NAME``_axi_arlen;\
  logic[2 : 0]   ``NAME``_axi_arsize;\
  logic[1 : 0]   ``NAME``_axi_arburst;\
  logic          ``NAME``_axi_arlock;\
  logic[3 : 0]   ``NAME``_axi_arcache;\
  logic[2 : 0]   ``NAME``_axi_arprot;\
  logic[3 : 0]   ``NAME``_axi_arqos;\
  logic          ``NAME``_axi_arvalid;\
  logic          ``NAME``_axi_arready;\
  logic[I-1 : 0] ``NAME``_axi_rid;\
  logic[D-1 : 0] ``NAME``_axi_rdata;\
  logic[1 : 0]   ``NAME``_axi_rresp;\
  logic          ``NAME``_axi_rlast;\
  logic          ``NAME``_axi_rvalid;\
  logic          ``NAME``_axi_rready

`define GEN_AXI_ITERCON_CON(ID, NAME)\
  .``ID``_AXI_AWID         (``NAME``_axi_awid        ),\
  .``ID``_AXI_AWADDR       (``NAME``_axi_awaddr      ),\
  .``ID``_AXI_AWLEN        (``NAME``_axi_awlen       ),\
  .``ID``_AXI_AWSIZE       (``NAME``_axi_awsize      ),\
  .``ID``_AXI_AWBURST      (``NAME``_axi_awburst     ),\
  .``ID``_AXI_AWLOCK       (``NAME``_axi_awlock      ),\
  .``ID``_AXI_AWCACHE      (``NAME``_axi_awcache     ),\
  .``ID``_AXI_AWPROT       (``NAME``_axi_awprot      ),\
  .``ID``_AXI_AWQOS        (``NAME``_axi_awqos       ),\
  .``ID``_AXI_AWVALID      (``NAME``_axi_awvalid     ),\
  .``ID``_AXI_AWREADY      (``NAME``_axi_awready     ),\
  .``ID``_AXI_WDATA        (``NAME``_axi_wdata       ),\
  .``ID``_AXI_WSTRB        (``NAME``_axi_wstrb       ),\
  .``ID``_AXI_WLAST        (``NAME``_axi_wlast       ),\
  .``ID``_AXI_WVALID       (``NAME``_axi_wvalid      ),\
  .``ID``_AXI_WREADY       (``NAME``_axi_wready      ),\
  .``ID``_AXI_BID          (``NAME``_axi_bid         ),\
  .``ID``_AXI_BRESP        (``NAME``_axi_bresp       ),\
  .``ID``_AXI_BVALID       (``NAME``_axi_bvalid      ),\
  .``ID``_AXI_BREADY       (``NAME``_axi_bready      ),\
  .``ID``_AXI_ARID         (``NAME``_axi_arid        ),\
  .``ID``_AXI_ARADDR       (``NAME``_axi_araddr      ),\
  .``ID``_AXI_ARLEN        (``NAME``_axi_arlen       ),\
  .``ID``_AXI_ARSIZE       (``NAME``_axi_arsize      ),\
  .``ID``_AXI_ARBURST      (``NAME``_axi_arburst     ),\
  .``ID``_AXI_ARLOCK       (``NAME``_axi_arlock      ),\
  .``ID``_AXI_ARCACHE      (``NAME``_axi_arcache     ),\
  .``ID``_AXI_ARPROT       (``NAME``_axi_arprot      ),\
  .``ID``_AXI_ARQOS        (``NAME``_axi_arqos       ),\
  .``ID``_AXI_ARVALID      (``NAME``_axi_arvalid     ),\
  .``ID``_AXI_ARREADY      (``NAME``_axi_arready     ),\
  .``ID``_AXI_RID          (``NAME``_axi_rid         ),\
  .``ID``_AXI_RDATA        (``NAME``_axi_rdata       ),\
  .``ID``_AXI_RRESP        (``NAME``_axi_rresp       ),\
  .``ID``_AXI_RLAST        (``NAME``_axi_rlast       ),\
  .``ID``_AXI_RVALID       (``NAME``_axi_rvalid      ),\
  .``ID``_AXI_RREADY       (``NAME``_axi_rready      )


`define GEN_AXI_ITERCON_CON_SFRO(ID, NAME)\
  .``ID``_AXI_AWID         ('d0),\
  .``ID``_AXI_AWADDR       ('d0),\
  .``ID``_AXI_AWLEN        ('d0),\
  .``ID``_AXI_AWSIZE       ('d0),\
  .``ID``_AXI_AWBURST      ('d0),\
  .``ID``_AXI_AWLOCK       ('d0),\
  .``ID``_AXI_AWCACHE      ('d0),\
  .``ID``_AXI_AWPROT       ('d0),\
  .``ID``_AXI_AWQOS        ('d0),\
  .``ID``_AXI_AWVALID      ('d0),\
  .``ID``_AXI_AWREADY      (),\
  .``ID``_AXI_WDATA        ('d0),\
  .``ID``_AXI_WSTRB        ('d0),\
  .``ID``_AXI_WLAST        ('d0),\
  .``ID``_AXI_WVALID       ('d0),\
  .``ID``_AXI_WREADY       (),\
  .``ID``_AXI_BID          (),\
  .``ID``_AXI_BRESP        (),\
  .``ID``_AXI_BVALID       (),\
  .``ID``_AXI_BREADY       ('d0),\
  .``ID``_AXI_ARID         (``NAME``_axi_arid        ),\
  .``ID``_AXI_ARADDR       (``NAME``_axi_araddr      ),\
  .``ID``_AXI_ARLEN        (``NAME``_axi_arlen       ),\
  .``ID``_AXI_ARSIZE       (``NAME``_axi_arsize      ),\
  .``ID``_AXI_ARBURST      (``NAME``_axi_arburst     ),\
  .``ID``_AXI_ARLOCK       (``NAME``_axi_arlock      ),\
  .``ID``_AXI_ARCACHE      (``NAME``_axi_arcache     ),\
  .``ID``_AXI_ARPROT       (``NAME``_axi_arprot      ),\
  .``ID``_AXI_ARQOS        (``NAME``_axi_arqos       ),\
  .``ID``_AXI_ARVALID      (``NAME``_axi_arvalid     ),\
  .``ID``_AXI_ARREADY      (``NAME``_axi_arready     ),\
  .``ID``_AXI_RID          (``NAME``_axi_rid         ),\
  .``ID``_AXI_RDATA        (``NAME``_axi_rdata       ),\
  .``ID``_AXI_RRESP        (``NAME``_axi_rresp       ),\
  .``ID``_AXI_RLAST        (``NAME``_axi_rlast       ),\
  .``ID``_AXI_RVALID       (``NAME``_axi_rvalid      ),\
  .``ID``_AXI_RREADY       (``NAME``_axi_rready      )

`define GEN_AXI_ITERCON_CON_SFWO(ID, NAME)\
  .``ID``_AXI_AWID         (``NAME``_axi_awid        ),\
  .``ID``_AXI_AWADDR       (``NAME``_axi_awaddr      ),\
  .``ID``_AXI_AWLEN        (``NAME``_axi_awlen       ),\
  .``ID``_AXI_AWSIZE       (``NAME``_axi_awsize      ),\
  .``ID``_AXI_AWBURST      (``NAME``_axi_awburst     ),\
  .``ID``_AXI_AWLOCK       (``NAME``_axi_awlock      ),\
  .``ID``_AXI_AWCACHE      (``NAME``_axi_awcache     ),\
  .``ID``_AXI_AWPROT       (``NAME``_axi_awprot      ),\
  .``ID``_AXI_AWQOS        (``NAME``_axi_awqos       ),\
  .``ID``_AXI_AWVALID      (``NAME``_axi_awvalid     ),\
  .``ID``_AXI_AWREADY      (``NAME``_axi_awready     ),\
  .``ID``_AXI_WDATA        (``NAME``_axi_wdata       ),\
  .``ID``_AXI_WSTRB        (``NAME``_axi_wstrb       ),\
  .``ID``_AXI_WLAST        (``NAME``_axi_wlast       ),\
  .``ID``_AXI_WVALID       (``NAME``_axi_wvalid      ),\
  .``ID``_AXI_WREADY       (``NAME``_axi_wready      ),\
  .``ID``_AXI_BID          (``NAME``_axi_bid         ),\
  .``ID``_AXI_BRESP        (``NAME``_axi_bresp       ),\
  .``ID``_AXI_BVALID       (``NAME``_axi_bvalid      ),\
  .``ID``_AXI_BREADY       (``NAME``_axi_bready      ),\
  .``ID``_AXI_ARID         ('d0),\
  .``ID``_AXI_ARADDR       ('d0),\
  .``ID``_AXI_ARLEN        ('d0),\
  .``ID``_AXI_ARSIZE       ('d0),\
  .``ID``_AXI_ARBURST      ('d0),\
  .``ID``_AXI_ARLOCK       ('d0),\
  .``ID``_AXI_ARCACHE      ('d0),\
  .``ID``_AXI_ARPROT       ('d0),\
  .``ID``_AXI_ARQOS        ('d0),\
  .``ID``_AXI_ARVALID      ('d0),\
  .``ID``_AXI_ARREADY      (),\
  .``ID``_AXI_RID          (),\
  .``ID``_AXI_RDATA        (),\
  .``ID``_AXI_RRESP        (),\
  .``ID``_AXI_RLAST        (),\
  .``ID``_AXI_RVALID       (),\
  .``ID``_AXI_RREADY       ('d0)

  
`define GEN_AXI_CON_BRAM(LID, RID)\
  .``LID``_axi_awid    (``RID``_axi_awid    ),\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bid     (``RID``_axi_bid     ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  ),\
  .``LID``_axi_arid    (``RID``_axi_arid    ),\
  .``LID``_axi_araddr  (``RID``_axi_araddr  ),\
  .``LID``_axi_arlen   (``RID``_axi_arlen   ),\
  .``LID``_axi_arsize  (``RID``_axi_arsize  ),\
  .``LID``_axi_arburst (``RID``_axi_arburst ),\
  .``LID``_axi_arvalid (``RID``_axi_arvalid ),\
  .``LID``_axi_arready (``RID``_axi_arready ),\
  .``LID``_axi_rid     (``RID``_axi_rid     ),\
  .``LID``_axi_rdata   (``RID``_axi_rdata   ),\
  .``LID``_axi_rresp   (``RID``_axi_rresp   ),\
  .``LID``_axi_rlast   (``RID``_axi_rlast   ),\
  .``LID``_axi_rvalid  (``RID``_axi_rvalid  ),\
  .``LID``_axi_rready  (``RID``_axi_rready  )

`define GEN_AXI_CON_BRAM_SFRO(LID, RID)\
  .``LID``_axi_awid    ('d0),\
  .``LID``_axi_awaddr  ('d0),\
  .``LID``_axi_awlen   ('d0),\
  .``LID``_axi_awsize  ('d0),\
  .``LID``_axi_awburst ('d0),\
  .``LID``_axi_awvalid ('d0),\
  .``LID``_axi_awready (),\
  .``LID``_axi_wdata   ('d0),\
  .``LID``_axi_wstrb   ('d0),\
  .``LID``_axi_wlast   ('d0),\
  .``LID``_axi_wvalid  ('d0),\
  .``LID``_axi_wready  (),\
  .``LID``_axi_bid     (),\
  .``LID``_axi_bresp   (),\
  .``LID``_axi_bvalid  (),\
  .``LID``_axi_bready  ('d0),\
  .``LID``_axi_arid    (``RID``_axi_arid    ),\
  .``LID``_axi_araddr  (``RID``_axi_araddr  ),\
  .``LID``_axi_arlen   (``RID``_axi_arlen   ),\
  .``LID``_axi_arsize  (``RID``_axi_arsize  ),\
  .``LID``_axi_arburst (``RID``_axi_arburst ),\
  .``LID``_axi_arvalid (``RID``_axi_arvalid ),\
  .``LID``_axi_arready (``RID``_axi_arready ),\
  .``LID``_axi_rid     (``RID``_axi_rid     ),\
  .``LID``_axi_rdata   (``RID``_axi_rdata   ),\
  .``LID``_axi_rresp   (``RID``_axi_rresp   ),\
  .``LID``_axi_rlast   (``RID``_axi_rlast   ),\
  .``LID``_axi_rvalid  (``RID``_axi_rvalid  ),\
  .``LID``_axi_rready  (``RID``_axi_rready  )

`define GEN_AXI_CON(LID, RID)\
  .``LID``_axi_awid    (``RID``_axi_awid    ),\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awlock  (``RID``_axi_awlock  ),\
  .``LID``_axi_awcache (``RID``_axi_awcache ),\
  .``LID``_axi_awprot  (``RID``_axi_awprot  ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bid     (``RID``_axi_bid     ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  ),\
  .``LID``_axi_arid    (``RID``_axi_arid    ),\
  .``LID``_axi_araddr  (``RID``_axi_araddr  ),\
  .``LID``_axi_arlen   (``RID``_axi_arlen   ),\
  .``LID``_axi_arsize  (``RID``_axi_arsize  ),\
  .``LID``_axi_arburst (``RID``_axi_arburst ),\
  .``LID``_axi_arlock  (``RID``_axi_arlock  ),\
  .``LID``_axi_arcache (``RID``_axi_arcache ),\
  .``LID``_axi_arprot  (``RID``_axi_arprot  ),\
  .``LID``_axi_arvalid (``RID``_axi_arvalid ),\
  .``LID``_axi_arready (``RID``_axi_arready ),\
  .``LID``_axi_rid     (``RID``_axi_rid     ),\
  .``LID``_axi_rdata   (``RID``_axi_rdata   ),\
  .``LID``_axi_rresp   (``RID``_axi_rresp   ),\
  .``LID``_axi_rlast   (``RID``_axi_rlast   ),\
  .``LID``_axi_rvalid  (``RID``_axi_rvalid  ),\
  .``LID``_axi_rready  (``RID``_axi_rready  )

`define GEN_AXI_CON_SWO(LID, RID)\
  .``LID``_axi_awid    (``RID``_axi_awid    ),\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awlock  (``RID``_axi_awlock  ),\
  .``LID``_axi_awcache (``RID``_axi_awcache ),\
  .``LID``_axi_awprot  (``RID``_axi_awprot  ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bid     (``RID``_axi_bid     ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  )

`define GEN_AXI_CON_SFWO(LID, RID)\
  .``LID``_axi_awid    (``RID``_axi_awid    ),\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awlock  (``RID``_axi_awlock  ),\
  .``LID``_axi_awcache (``RID``_axi_awcache ),\
  .``LID``_axi_awprot  (``RID``_axi_awprot  ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bid     (``RID``_axi_bid     ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  ),\
  .``LID``_axi_arid    ('d0),\
  .``LID``_axi_araddr  ('d0),\
  .``LID``_axi_arlen   ('d0),\
  .``LID``_axi_arsize  ('d0),\
  .``LID``_axi_arburst ('d0),\
  .``LID``_axi_arlock  ('d0),\
  .``LID``_axi_arcache ('d0),\
  .``LID``_axi_arprot  ('d0),\
  .``LID``_axi_arvalid ('d0),\
  .``LID``_axi_arready (),\
  .``LID``_axi_rid     (),\
  .``LID``_axi_rdata   (),\
  .``LID``_axi_rresp   (),\
  .``LID``_axi_rlast   (),\
  .``LID``_axi_rvalid  (),\
  .``LID``_axi_rready  ('d0)

`define GEN_AXI_CON_QOS(LID, RID)\
  `GEN_AXI_CON(LID, RID),\
  .``LID``_axi_awqos   (``RID``_axi_awqos   ),\
  .``LID``_axi_arqos   (``RID``_axi_arqos   )

`define GEN_AXI_CON_WO_DMA(LID, RID)\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awcache (``RID``_axi_awcache ),\
  .``LID``_axi_awprot  (``RID``_axi_awprot  ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  )

`define GEN_AXI_CON_WO(LID, RID)\
  .``LID``_axi_awid    (``RID``_axi_awid    ),\
  .``LID``_axi_awaddr  (``RID``_axi_awaddr  ),\
  .``LID``_axi_awlen   (``RID``_axi_awlen   ),\
  .``LID``_axi_awsize  (``RID``_axi_awsize  ),\
  .``LID``_axi_awburst (``RID``_axi_awburst ),\
  .``LID``_axi_awlock  (``RID``_axi_awlock  ),\
  .``LID``_axi_awcache (``RID``_axi_awcache ),\
  .``LID``_axi_awprot  (``RID``_axi_awprot  ),\
  .``LID``_axi_awvalid (``RID``_axi_awvalid ),\
  .``LID``_axi_awready (``RID``_axi_awready ),\
  .``LID``_axi_wdata   (``RID``_axi_wdata   ),\
  .``LID``_axi_wstrb   (``RID``_axi_wstrb   ),\
  .``LID``_axi_wlast   (``RID``_axi_wlast   ),\
  .``LID``_axi_wvalid  (``RID``_axi_wvalid  ),\
  .``LID``_axi_wready  (``RID``_axi_wready  ),\
  .``LID``_axi_bid     (``RID``_axi_bid     ),\
  .``LID``_axi_bresp   (``RID``_axi_bresp   ),\
  .``LID``_axi_bvalid  (``RID``_axi_bvalid  ),\
  .``LID``_axi_bready  (``RID``_axi_bready  )

`define GEN_AXI_CON_RO_DMA(LID, RID)\
  .``LID``_axi_araddr  (``RID``_axi_araddr  ),\
  .``LID``_axi_arlen   (``RID``_axi_arlen   ),\
  .``LID``_axi_arsize  (``RID``_axi_arsize  ),\
  .``LID``_axi_arburst (``RID``_axi_arburst ),\
  .``LID``_axi_arcache (``RID``_axi_arcache ),\
  .``LID``_axi_arprot  (``RID``_axi_arprot  ),\
  .``LID``_axi_arvalid (``RID``_axi_arvalid ),\
  .``LID``_axi_arready (``RID``_axi_arready ),\
  .``LID``_axi_rdata   (``RID``_axi_rdata   ),\
  .``LID``_axi_rresp   (``RID``_axi_rresp   ),\
  .``LID``_axi_rlast   (``RID``_axi_rlast   ),\
  .``LID``_axi_rvalid  (``RID``_axi_rvalid  ),\
  .``LID``_axi_rready  (``RID``_axi_rready  )

`define GEN_AXI_CON_RO(LID, RID)\
  .``LID``_axi_arid    (``RID``_axi_arid    ),\
  .``LID``_axi_araddr  (``RID``_axi_araddr  ),\
  .``LID``_axi_arlen   (``RID``_axi_arlen   ),\
  .``LID``_axi_arsize  (``RID``_axi_arsize  ),\
  .``LID``_axi_arburst (``RID``_axi_arburst ),\
  .``LID``_axi_arlock  (``RID``_axi_arlock  ),\
  .``LID``_axi_arcache (``RID``_axi_arcache ),\
  .``LID``_axi_arprot  (``RID``_axi_arprot  ),\
  .``LID``_axi_arvalid (``RID``_axi_arvalid ),\
  .``LID``_axi_arready (``RID``_axi_arready ),\
  .``LID``_axi_rid     (``RID``_axi_rid     ),\
  .``LID``_axi_rdata   (``RID``_axi_rdata   ),\
  .``LID``_axi_rresp   (``RID``_axi_rresp   ),\
  .``LID``_axi_rlast   (``RID``_axi_rlast   ),\
  .``LID``_axi_rvalid  (``RID``_axi_rvalid  ),\
  .``LID``_axi_rready  (``RID``_axi_rready  )
//`endif
