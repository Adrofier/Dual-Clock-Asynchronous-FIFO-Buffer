module async_fifo
#(
  parameter DSIZE = 8,
  parameter ASIZE = 4
 )
(
  input  logic winc, wclk, wrst_n,
  input  logic rinc, rclk, rrst_n,
  input  logic [DSIZE-1:0] wdata,

  output logic [DSIZE-1:0] rdata,
  output logic wfull,
  output logic rempty
);

  logic [ASIZE-1:0] waddr, raddr;
  logic [ASIZE:0] write_ptr, read_ptr, wq2_read_ptr, rq2_write_ptr;

  sync_read2write sync_read2write (.*);
  sync_write2read sync_write2read (.*);
  
  fifo_memory #(DSIZE, ASIZE) fifo_memory (.*);
  
  read_ptr_empty #(ASIZE) read_ptr_empty (.*);
  write_ptr_full #(ASIZE) write_ptr_full (.*);

endmodule
