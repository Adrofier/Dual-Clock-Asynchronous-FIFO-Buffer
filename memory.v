
// FIFO memory

module fifo_memory
#(
  parameter DATA_SIZE = 8,      // Size of memory data word
  parameter ADDRESS_SIZE = 4    // Number of memory address bits
)
(
  input  logic winc, wfull, wclk,
  input  logic [ADDRESS_SIZE-1:0] waddr, raddr,
  input  logic [DATA_SIZE-1:0] wdata,
  output logic [DATA_SIZE-1:0] rdata
);

  localparam DEPTH = 1<<ADDRESS_SIZE;

  logic [DATA_SIZE-1:0] mem [0:DEPTH-1];

  assign rdata = mem[raddr];

  always_ff @(posedge wclk)
    if (winc && !wfull)
      mem[waddr] <= wdata;

endmodule
