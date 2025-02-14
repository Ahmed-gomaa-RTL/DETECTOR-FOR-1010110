module  DETECTOR_MEALY (
    input   wire     clk    , 
    input   wire     reset  ,
    input   wire     in     ,
    output  reg      detected
);

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011,
              S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

    reg [2:0] current_state, next_state;


    always @(posedge clk or negedge reset) begin
        if (!reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            S0: next_state = (in) ? S1 : S0;   
            S1: next_state = (in) ? S1 : S2;   
            S2: next_state = (in) ? S3 : S0;  
            S3: next_state = (in) ? S1 : S4;   
            S4: next_state = (in) ? S5 : S0;   
            S5: next_state = (in) ? S6 : S4;   
            S6: next_state = (in) ? S1 : S2;     
            default: next_state = S0;
        endcase
    end

    always @(*) begin 
       detected <= (current_state == S6) & ( in == 0) ; 
    end

endmodule  



