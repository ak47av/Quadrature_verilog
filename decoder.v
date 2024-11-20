module decoder(input clk, input A, input B, input reset, output reg[7:0] count);

    reg [1:0] state;
    parameter A_LEAD = 2'b00, B_LEAD = 2'b01, NO_SIG = 2'b10;
    reg[7:0] counter = 0;

    reg a_high, b_high;

    always @(posedge clk or negedge reset) begin
        if(reset) state <= NO_SIG;
        count <= counter;
    end

    always @(posedge clk) begin
        if(A) a_high<= 1;
        else a_high <= 0;
    end
    
    always @(posedge clk) begin
        if(B) b_high <= 1;
        else b_high <= 0;
    end

    always @(*) begin
        case(state)
            A_LEAD: begin 
                case({a_high, b_high})
                    2'b00: state <= NO_SIG;
                    2'b11: state <= A_LEAD;
                endcase
            end
            B_LEAD: begin 
                case({a_high, b_high})
                    2'b00: state <= NO_SIG;
                    default: state <= B_LEAD;
                endcase
            end
            NO_SIG: begin
                case({a_high, b_high})
                    2'b10: begin
                        state <= A_LEAD;
                        counter--;
                    end
                    2'b01: begin
                        state <= B_LEAD;
                        counter++;
                    end
                    default: state <= NO_SIG;
                endcase
            end
        endcase
    end

    // always @(posedge clk) begin
    //     case(state)
    //         A_LEAD: counter--;
    //         B_LEAD: counter++;
    //         default: count <= count;
    //     endcase
    // end

endmodule