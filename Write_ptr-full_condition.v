
// Write pointer and full generation

module write_ptr_full
#(
  parameter ADDRESS_SIZE = 4
)
(
  input  logic winc, wclk, wrst_n,
  input  logic [ADDRESS_SIZE :0] wq2_read_ptr,
  output logic wfull,
  output logic [ADDRESS_SIZE-1:0] waddr,
  output logic [ADDRESS_SIZE :0] write_ptr
);

  logic [ADDRESS_SIZE:0] wbin;
  logic [ADDRESS_SIZE:0] wgraynext, wbinnext;

  
  always_ff @(posedge wclk or negedge wrst_n)
    if (!wrst_n)
      {wbin, write_ptr} <= '0;
    else
      {wbin, write_ptr} <= {wbinnext, wgraynext};

  
  assign waddr = wbin[ADDRESS_SIZE-1:0];
  assign wbinnext = wbin + (winc & ~wfull);
  assign wgraynext = (wbinnext>>1) ^ wbinnext;

  
  assign wfull_val = (wgraynext == {~wq2_read_ptr[ADDRESS_SIZE:ADDRESS_SIZE-1], wq2_read_ptr[ADDRESS_SIZE-2:0]});

  always_ff @(posedge wclk or negedge wrst_n)
    if (!wrst_n)
      wfull <= 1'b0;
    else
      wfull <= wfull_val;

endmodule
