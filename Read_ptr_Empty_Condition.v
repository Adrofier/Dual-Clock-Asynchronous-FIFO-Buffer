
// Read pointer and empty generation

module read_ptr_empty
#(
  parameter ADDRESS_SIZE = 4
)
(
  input  logic rinc, rclk, rrst_n,
  input  logic [ADDRESS_SIZE :0] rq2_write_ptr,
  output logic rempty,
  output logic [ADDRESS_SIZE-1:0] raddr,
  output logic [ADDRESS_SIZE :0] read_ptr
);

  logic [ADDRESS_SIZE:0] r_binary;
  logic [ADDRESS_SIZE:0] rgraynext, r_binarynext;


  always_ff @(posedge rclk or negedge rrst_n)
    if (!rrst_n)
      {r_binary, read_ptr} <= '0;
    else
      {r_binary, read_ptr} <= {r_binarynext, rgraynext};

 
  assign raddr = r_binary[ADDRESS_SIZE-1:0];
  assign r_binarynext = r_binary + (rinc & ~rempty);
  assign rgraynext = (r_binarynext>>1) ^ r_binarynext;


  // FIFO should be empty when the next read_ptr == synchronized write_ptr or on reset

  assign rempty_val = (rgraynext == rq2_write_ptr);

  always_ff @(posedge rclk or negedge rrst_n)
    if (!rrst_n)
      rempty <= 1'b1;
    else
      rempty <= rempty_val;

endmodule
