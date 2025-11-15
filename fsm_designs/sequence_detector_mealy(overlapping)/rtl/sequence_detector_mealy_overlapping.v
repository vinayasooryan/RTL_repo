

module sequence_detector_mealy_overlapping( 
                  input clk,
                  input reset,
                  input in,
                  output out
                            );
                  
      //state encoding
      parameter S0 = 2'b00,
                S1 = 2'b01,
                S2 = 2'b10,
                S3 = 2'b11;
                
      reg [1:0]current, next;
      
      //state register (sequential logic)
      always @(posedge clk)begin
           if (reset)
              current <= S0;
           else 
              current <= next;
           end
         
      //next block logic(combinational logic)
      always@(*) begin
           case(current)
              default: next = S0;
             S0: begin
                 if (in)
                    next = S1;
                 else
                    next = S0;
                 end
                 
             S1: begin
                 if(~in)
                   next = S2;
                 else
                   next = S1;
                 end
                   
             S2: begin
                 if (in)
                   next = S3;
                 else
                   next = S0;
                 end
                 
             S3: begin
                  if (~in)
                    next = S2;
                  else
                    next = S1;
                 end
             endcase
          end
        
        //output logic(mealy)
        assign out =( (current ==S3) && (~in) ) ? 1 : 0;
        
        endmodule
        
        
  /*  ANOTHER WAY OF CODING USING ALWAYS BLOCK TO DEFINE OUTPUT
        
       module sequence_detector_mealy_overlapping(
    input  wire clk,
    input  wire reset,
    input  wire in,
    output reg  out
);

// state encoding
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [1:0] current, next;

// state register
always @(posedge clk) begin
    if (reset)
        current <= S0;
    else
        current <= next;
end

// next-state and output logic (Mealy output here)
always @(*) begin
    out = 0;  // default

    case (current)

        S0: begin
            if (in)
                next = S1;
            else
                next = S0;
        end

        S1: begin
            if (in)
                next = S1;
            else
                next = S2;
        end

        S2: begin
            if (in)
                next = S3;
            else
                next = S0;
        end

        S3: begin
            if (in) begin
                next = S1;
                out  = 0;
            end
            else begin
                next = S2;
                out  = 1;  // detection occurs HERE
            end
        end

        default: begin
            next = S0;
            out  = 0;
        end

    endcase
end

endmodule       */
           

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
