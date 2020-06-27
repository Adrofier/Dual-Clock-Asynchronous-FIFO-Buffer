
// Read pointer to write clock synchronizer

module sync_read2write
#(
  parameter ADDRESS_SIZE = 4
)
(
  input  logic wclk, wrst_n,
  input  logic [ADDRESS_SIZE:0] read_ptr,
  output logic [ADDRESS_SIZE:0] wq2_read_ptr
);

  logic [ADDRESS_SIZE:0] wq1_read_ptr;

  always_ff @(posedge wclk or negedge wrst_n)
    if (!wrst_n) 
        {wq2_read_ptr, wq1_read_ptr} <= 0;
    else 
        {wq2_read_ptr, wq1_read_ptr} <= {wq1_read_ptr, read_ptr};

endmodule
