//Parameterized FIFO

module qs_fifo #(
  parameter DATA_W = 8,
  parameter DEPTH = 4
)(
 input logic    clk,
 input logic    reset,
  
 input logic               push_i,
 input logic [DATA_W-1:0] push_data_i,
  
 input logic               pop_i,
 output logic [DATA_W-1:0]pop_data_o,
  
 output logic              full_o,
 output logic              empty_o
  
);
  
  typedef enum logic[1:0]{
    ST_PUSH = 2'b10,
    ST_POP = 2'b01,
    ST_BOTH = 2'b11
  }state_t;

  localparam PTR_W = $clog2(DEPTH); /*$clog2() = ceiling of log base 2

Meaning:

“How many bits are required to represent numbers from 0 to DEPTH-1?”
PTR_W means pointer width*/
  
  logic [DATA_W-1:0]fifo_data_q [DEPTH-1:0];
  
  logic [PTR_W-1:0]rd_ptr_q;
  logic [PTR_W-1:0]wr_ptr_q;
  logic [PTR_W-1:0]nxt_rd_ptr;
  logic [PTR_W-1:0]nxt_wr_ptr;
  
  logic          wrapped_rd_ptr_q;
  logic          wrapped_wr_ptr_q;
  logic          nxt_wrapped_rd_ptr;
  logic          nxt_wrapped_wr_ptr;
  
  logic [DATA_W-1:0]nxt_fifo_data;
  
  logic [DATA_W-1:0]pop_data;
  
  logic empty;
  logic full;
  
  
  //Flops for fifo pointers
  always_ff @(posedge clk or posedge reset)
    if (reset)begin
      rd_ptr_q <= PTR_W'(1'b0);
      wr_ptr_q <= PTR_W'(1'b0);
      wrapped_rd_ptr_q <= 1'b0;
      wrapped_wr_ptr_q <= 1'b0;
    end else begin
      rd_ptr_q <= nxt_rd_ptr;
      wr_ptr_q <= nxt_wr_ptr;
      wrapped_rd_ptr_q <= nxt_wrapped_rd_ptr;
      wrapped_wr_ptr_q <= nxt_wrapped_wr_ptr;
    end
  
  //Pointer logic for push and pop
  always_comb begin
    nxt_fifo_data = fifo_data_q[wr_ptr_q];
    nxt_rd_ptr = rd_ptr_q;
    nxt_wr_ptr = wr_ptr_q;
    nxt_wrapped_wr_ptr = wrapped_wr_ptr_q;
    nxt_wrapped_rd_ptr = wrapped_rd_ptr_q;
    
    pop_data = pop_data_o; // or pop_data = fifo_data_q[rd_ptr_q];
    
    case ({push_i && !full, pop_i && !empty})
   /*case ({push_i, pop_i}) //2 bit signal with push and pop as LSB*/
      
      ST_PUSH : begin
         nxt_fifo_data = push_data_i;
         //Manipulate the write pointer
         //Depth =6
        //wr_ptr_q = 5(0b0101)
        //wr_ptr_q = 6(0b0110) - incorrect
        if (wr_ptr_q == PTR_W'(DEPTH-1))begin
          nxt_wr_ptr = PTR_W'(1'b0);
          nxt_wrapped_wr_ptr = ~wrapped_wr_ptr_q;
        end else begin
          nxt_wr_ptr = wr_ptr_q + PTR_W'(1'b1);
        end
        
      end
      ST_POP: begin
        //Read the fifo location pointed by rd_pointer
        pop_data = fifo_data_q[rd_ptr_q[PTR_W-1:0]];
        //Manipulate the read pointer
        if (rd_ptr_q == PTR_W'(DEPTH-1))begin
          nxt_rd_ptr = PTR_W'(1'b0);
          nxt_wrapped_rd_ptr = ~wrapped_rd_ptr_q;
        end else begin
          nxt_rd_ptr = rd_ptr_q + PTR_W'(1'b1);
        end
      end
      ST_BOTH:begin
        nxt_fifo_data = push_data_i;
         //Manipulate the write pointer
         //Depth =6
        //wr_ptr_q = 5(0b0101)
        //wr_ptr_q = 6(0b0110) - incorrect
        if (wr_ptr_q == PTR_W'(DEPTH-1))begin
          nxt_wr_ptr = PTR_W'(1'b0);
          nxt_wrapped_wr_ptr = ~wrapped_wr_ptr_q;
          
        end else begin
          nxt_wr_ptr = wr_ptr_q + PTR_W'(1'b1);
        end
        //Read the fifo location pointed by rd_pointer
        pop_data = fifo_data_q[rd_ptr_q[PTR_W-1:0]];
        //Manipulate the read pointer
        if (rd_ptr_q == PTR_W'(DEPTH-1))begin
          nxt_rd_ptr = PTR_W'(1'b0);
          nxt_wrapped_rd_ptr = ~wrapped_rd_ptr_q;
        end else begin
          nxt_rd_ptr = rd_ptr_q + PTR_W'(1'b1);
        end
      end
      default:begin
        nxt_fifo_data = fifo_data_q[wr_ptr_q[PTR_W-1:0]];
        nxt_rd_ptr = rd_ptr_q;
        nxt_wr_ptr = wr_ptr_q;
      end
        endcase
        end
      
    //Empty
      assign empty = (rd_ptr_q == wr_ptr_q)&
        (wrapped_rd_ptr_q == wrapped_wr_ptr_q);
      assign full = (rd_ptr_q == wr_ptr_q)&
        (wrapped_rd_ptr_q != wrapped_wr_ptr_q);
      
      
      
      //Fifo is of depth 4
      //wr_ptr      rd_ptr
      //1 00          0 00
      //0 01          0 01
      //0 10          0 10
      //0 11          0 11
      //empty?   or   full?
      //(rd_ptr == wr_ptr)
      //Full when rd_ptr == wr_ptr & (wrapped_wr_ptr == wrapped_rd_pointer)
      //Empty when rd_ptr == wr_ptr& (wrapped_wr_ptr == wrapped_rd_pointer)
      //Wrapped pointers
      //reset to 0
      //wrapped_pointers are toggled
      //Flops for fifo data
      always_ff @(posedge clk) begin
        if (push_i && !full)
           fifo_data_q[wr_ptr_q] <= nxt_fifo_data;
       end

      /*always_ff@(posedge clk)
        fifo_data_q[wr_ptr_q[PTR_W-1:0]]<=nxt_fifo_data;*/
      
      //Output assignments
      assign pop_data_o = pop_data;
      assign full_o = full;
      assign empty_o = empty;
      
      
      
      
      endmodule
        
        
  
  
  
  
  
  
  
  
  
  
  
   