
module tb_sequence_detector_moore;
       reg clk;
       reg reset;
       reg in;
       wire out;
       
     // DUT instantiation
     sequence_detector_moore dut(
          .in(in),
          .clk(clk),
          .reset(reset),
          .out(out)  
          );
          
      // Clock generation
      initial begin
        clk = 0;
        forever #5 clk = ~clk;  //10ns clock period
      end
      
      //test stimulus
      initial begin
       $dumpfile("waveform.vcd") ;
       $dumpvars(0, tb_sequence_detector_moore);
       
      //init
      reset=1; in =0;
      #12 reset =0;
      
     // TEST SEQUENCE: 1 0 1 0 1 0
     send_bit(1);
     send_bit(0); 
     send_bit(1);
     send_bit(0);
     send_bit(1);
     send_bit(0);
     
     // Additional patterns
     send_bit(1); 
     send_bit(1);
     send_bit(0);
     send_bit(1);
     send_bit(0); 
     
     #50 $finish;
    end
   
   // Pure Verilog task
   task send_bit;
     input value;
   begin
       in = value;
       #10;
   end
   endtask   
    
endmodule
