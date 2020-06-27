
// Write pointer to read clock synchronizer

module sync_write2read
#(
  parameter ADDRESS_SIZE = 4
)
(
  input  logic rclk, rrst_n,
  input  logic [ADDRESS_SIZE:0] write_ptr,
  output logic [ADDRESS_SIZE:0] rq2_write_ptr
);

  logic [ADDRESS_SIZE:0] rq1_write_ptr;

  always_ff @(posedge rclk or negedge rrst_n)
    if (!rrst_n)
      {rq2_write_ptr,rq1_write_ptr} <= 0;
    else
      {rq2_write_ptr,rq1_write_ptr} <= {rq1_write_ptr,write_ptr};

endmodule
